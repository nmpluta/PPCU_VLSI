# mtm_ppcu_vlsi_riscv

mtm_ppcu_vlsi_riscv is a repository used during MTM PPCU VLSI classes.

Project cloning
```bash
git clone --recursive git@github.com:agh-riscv/mtm_ppcu_vlsi_riscv.git
```

## Project structure

```bash
.

├── asic            # synthesis and P&R
├── deps            # external dependencies
├── README.md       # this file
├── rtl             # SystemVerilog files used in synthesis and simulation
├── sim             # simulation environment
├── sim_post        # simulation environment for post-layout simulations
├── sw              # software files
└── tools           # tools used for ROM memories generation
```
## Software compilation
```bash
cd sw
# Build structure initialization
cmake -H. -Bbuild
# Compilation
cmake --build build
```

## Simulation execution:

```bash
cd sim
./run.sh <options> - run the script with no options to see the help
```

## Technology-related files

### IO cells
* DOC: /cad/dk/PDK_CRN45GS_DGO_11_25/digital/Documentation/documents/tpfn40lpgv2od3_120a
* LIB: /cad/dk/PDK_CRN45GS_DGO_11_25/digital/Front_End/timing_power_noise/NLDM/tpfn40lpgv2od3_120a
* VERILOG: /cad/dk/PDK_CRN45GS_DGO_11_25/digital/Front_End/verilog/tpfn40lpgv2od3_120a

### Standard cell library
* DOC: /cad/dk/PDK_CRN45GS_DGO_11_25/digital/Documentation/documents/tcbn40lpbwp_200a
* LIB: /cad/dk/PDK_CRN45GS_DGO_11_25/digital/Front_End/timing_power_noise/NLDM/tcbn40lpbwp_200a
* VERILOG: /cad/dk/PDK_CRN45GS_DGO_11_25/digital/Front_End/verilog/tcbn40lpbwp_200a

### Analog IO cells
* DOC: /cad/dk/PDK_CRN45GS_DGO_11_25/digital/Documentation/documents/tpan40lpgv2od3_120a
* LIB: /cad/dk/PDK_CRN45GS_DGO_11_25/digital/Front_End/timing_power_noise/NLDM/tpan40lpgv2od3_120a
* VERILOG: /cad/dk/PDK_CRN45GS_DGO_11_25/digital/Front_End/verilog/tpan40lpgv2od3_120a

### Application notes
* /cad/dk/PDK_CRN45GS_DGO_11_25/digital/Documentation/application_notes
