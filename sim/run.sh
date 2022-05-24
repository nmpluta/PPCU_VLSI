#!/bin/bash
#------------------------------------------------------------------------------
function syntax {
  echo "Syntax: $0 -m ASIC|FPGA [-g] [-s SEED]"
  echo "   where: -m - select implementation target. "
  echo "               ASIC - use TSMC memory models, chip with pads."
  echo "               FPGA - use generic memory model"
  echo "          -g - run xrun in debug gui mode"
  echo "          -s - set SEED for the simulation (integer number). Generated automatically"
  echo "               if not set"
  echo "          -d - debug mode. Dumps memories contents to files at time 0, after boot, and at the end of simulation."
  exit -1
}

function compile_programs {
  cmake -S ../sw -B ../sw/build -Dtarget:string=sim && \
  cmake --build ../sw/build -j "$(nproc)"
}

function generate_boot_mem {
  ../tools/rxd_rom_generator.py boot_mem ../sw/build/bootloader/bootloader.vmem ../rtl/soc/memories/boot_mem.sv
}

function generate_code_mem {
  ../tools/rxd_rom_generator.py spi_mem ../sw/build/app/app.vmem ../rtl/misc/spi_flash_memory/spi_mem.sv
}

#------------------------------------------------------------------------------
# xrun paths
. /cad/env/cadence_path.XCELIUM1909
#------------------------------------------------------------------------------
# argumetn parsing and checking
#------------------------------------------------------------------------------
GUI="";
MODE="";
SEED="";
DEBUG="";
while getopts m:gs:d option
  do case "${option}" in
    m) MODE=${OPTARG};;
    g) GUI="-xmdebug -linedebug -fsmdebug -gui" ;;
    s) SEED=${OPTARG} ;;
    d) DEBUG="-define DEBUG" ;;
    ?) syntax;;
  esac
done
#------------------------------------------------------------------------------
case "$MODE" in
  "ASIC") KMIE_IMPLEMENT="-define KMIE_IMPLEMENT_ASIC" ;;
  "FPGA") KMIE_IMPLEMENT="-define KMIE_IMPLEMENT_FPGA" ;;
  "") echo "ERROR: mode (-m) not specified."; syntax ;;
  *) echo "ERROR: incorrect mode specified: $MODE"; syntax ;;
esac
#------------------------------------------------------------------------------
if [[ "$SEED" == "" ]] ; then
  SEED=$((`date +"%s"` % 1000))
  echo Generated random SEED: $SEED
elif [[ $SEED =~ ^[0-9]+$ ]] ; then
  echo Using provided SEED: $SEED
else
  echo "ERROR: incorrect seed specified: $SEED (should be integer number).";  syntax ;
fi
#------------------------------------------------------------------------------
# Generate initialization file for the memory (both FPGA and ASIC)
#------------------------------------------------------------------------------
  TSMC_MEM_FILE="TS1N40LPB4096X32M4M_initial.cde"
  RANDOM=$SEED
  rm -f $TSMC_MEM_FILE
  for i in {1..4096} ; do
#    printf "%08x\n" 0 >> $TSMC_MEM_FILE ;
    printf "%08x\n" $(($RANDOM*65536+$RANDOM)) >> $TSMC_MEM_FILE ;
  done
#------------------------------------------------------------------------------
# TSMC specific settings for the ASIC
#------------------------------------------------------------------------------
# TSMC memory paramters
# Note: all the instances of the memory are initialized into the same state
# TSMC_PARAMS="-UNIT_DELAY" - disable all the timing checks in the memory
TSMC_PARAMS=""
if [[ "$MODE" == "ASIC" ]]; then
  TSMC_PARAMS=" -define UNIT_DELAY"
  TSMC_PARAMS+=" -define TSMC_INITIALIZE_MEM"
  TSMC_PARAMS+=" -exclude_file xminitialize.exclude"
  TSMC_PARAMS+=" -v /cad/dk/PDK_CRN45GS_DGO_11_25/IMEC_RAM_generator/ram/ts1n40lpb4096x32m4m_250a/VERILOG/ts1n40lpb4096x32m4m_250a_tt1p1v25c.v"
  TSMC_PARAMS+=" -v /cad/dk/PDK_CRN45GS_DGO_11_25/digital/Front_End/verilog/tpfn40lpgv2od3_120a/tpfn40lpgv2od3.v"
  TSMC_PARAMS+=" -xmhierarchy \"tb_mtm_riscv_soc.u_mtm_riscv_soc_top\""
  TSMC_PARAMS+=" +nowarnTRNNOP"
fi
#------------------------------------------------------------------------------
rm -f led_waves.txt
LOG_FILE=xrun.log.$MODE.$SEED
# ZROMCW warning blocked as MHPMCounterNum is set to 0
### regenerate memories and runs simulation
./clear.sh
compile_programs || { echo "error: programs compilation failed"; exit 1; }
generate_boot_mem || { echo "error: boot_mem generation failed"; exit 1; }
generate_code_mem || { echo "error: code_mem generation failed"; exit 1; }
xrun \
  -q \
  -F mtm_riscv_soc.f \
  tb/tb_mtm_riscv_soc.sv \
  -64bit \
  -l $LOG_FILE \
  -xminitialize rand_2state:$SEED \
  +nowarnDSEM2009 \
  +nowarnDSEMEL \
  +nowarnZROMCW \
  -timescale 1ns/1ps \
  -incdir ../deps/ibex/vendor/lowrisc_ip/ip/prim/rtl \
  -incdir ../deps/ibex/vendor/lowrisc_ip/dv/sv/dv_utils \
  "$DEBUG" \
  "$TSMC_PARAMS" \
  "$KMIE_IMPLEMENT" \
  "$GUI"

#  -xminitialize 0 \
#  -assert_logging_error_off \

#------------------------------------------------------------------------------
### Check the simulation results and report status.
# The led[3:0] state is written into the led_waves.txt file in the testbench.
# It is compared with the led_waves_correct.txt (golden).
status=$?
sep="------------------------------------------------------------------------------";

# store xrun warnings and errors in the separate file

if [[ "$status" != "0" ]]; then
    echo $sep |& tee -a $LOG_FILE
    echo "-- xrun exited with status $status, " `grep -c "*E" $LOG_FILE` "errors in $LOG_FILE". |& tee -a $LOG_FILE
    echo "SEED $SEED" >> seed.xrun.errors.$MODE
    egrep "\*[WE]." $LOG_FILE >> seed.xrun.errors.$MODE
    echo "" >> seed.xrun.errors.$MODE
fi

# compare the led[3:0] waves with reference and report

if [[ -e led_waves.txt ]] ; then
  # sum of inserted+deleted reported by diff
  led_diffs=$(diff led_waves_correct.txt led_waves.txt | diffstat | tail -1 | perl -lane 'print $F[3]+$F[5]')
  echo $sep |& tee -a $LOG_FILE
  if [[ "$led_diffs" == "0" ]]; then
    echo "-- Simlation PASSED. led[3:0] waves OK. SEED=$SEED" |& tee -a $LOG_FILE
    echo $sep |& tee -a $LOG_FILE
    echo $SEED >> seed.passed.$MODE
    exit 0
  elif [[ "$led_diffs" < "5" ]]; then
    echo "-- Simlation PASSED. led[3:0] waves minor difference (diff: $led_diffs). SEED=$SEED" |& tee -a $LOG_FILE
    echo $sep |& tee -a $LOG_FILE
    echo $SEED >> seed.passed.$MODE
    exit 0
  else
    echo "-- Simlation FAILED led[3:0] waves incorrect (diff: $led_diffs). SEED=$SEED" |& tee -a $LOG_FILE
    echo $sep |& tee -a $LOG_FILE
    echo $SEED "wrong output waveforms" >> seed.failed.$MODE
    exit -1
  fi
fi
