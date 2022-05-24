SHELL=/bin/bash

NETLIST=netlist.sv

# disabling defaults suffixes
.SUFFIXES:

${NETLIST} : get_netlist.sh \
../../../deps/ibex/rtl/ibex_pkg.sv \
../../../deps/ibex/rtl/ibex_alu.sv \
../../../deps/ibex/rtl/ibex_compressed_decoder.sv \
../../../deps/ibex/rtl/ibex_controller.sv \
../../../deps/ibex/rtl/ibex_core.sv \
../../../deps/ibex/rtl/ibex_counter.sv \
../../../deps/ibex/rtl/ibex_csr.sv \
../../../deps/ibex/rtl/ibex_cs_registers.sv \
../../../deps/ibex/rtl/ibex_decoder.sv \
../../../deps/ibex/rtl/ibex_dummy_instr.sv \
../../../deps/ibex/rtl/ibex_ex_block.sv \
../../../deps/ibex/rtl/ibex_fetch_fifo.sv \
../../../deps/ibex/rtl/ibex_icache.sv \
../../../deps/ibex/rtl/ibex_id_stage.sv \
../../../deps/ibex/rtl/ibex_if_stage.sv \
../../../deps/ibex/rtl/ibex_load_store_unit.sv \
../../../deps/ibex/rtl/ibex_multdiv_fast.sv \
../../../deps/ibex/rtl/ibex_pmp.sv \
../../../deps/ibex/rtl/ibex_prefetch_buffer.sv \
../../../deps/ibex/rtl/ibex_register_file_fpga.sv \
../../../deps/ibex/rtl/ibex_wb_stage.sv \
../../../rtl/soc/mtm_riscv_soc_pkg.sv \
../../../rtl/soc/data_bus_arbiter.sv \
../../../rtl/soc/instr_bus_arbiter.sv \
../../../rtl/soc/peripherals.sv \
../../../rtl/soc/gpio/gpio_pkg.sv \
../../../rtl/soc/gpio/gpio_interrupt_detector.sv \
../../../rtl/soc/gpio/gpio_offset_decoder.sv \
../../../rtl/soc/gpio/gpio.sv \
../../../rtl/soc/interfaces/ibex_data_bus.sv \
../../../rtl/soc/interfaces/ibex_instr_bus.sv \
../../../rtl/soc/interfaces/soc_gpio_bus.sv \
../../../rtl/soc/interfaces/soc_pm_analog_config.sv \
../../../rtl/soc/interfaces/soc_pm_ctrl.sv \
../../../rtl/soc/interfaces/soc_pm_data.sv \
../../../rtl/soc/interfaces/soc_pm_digital_config.sv \
../../../rtl/soc/interfaces/soc_spi_bus.sv \
../../../rtl/soc/interfaces/soc_timer_bus.sv \
../../../rtl/soc/interfaces/soc_uart_bus.sv \
../../../rtl/soc/memories/asic/ram.sv \
../../../rtl/soc/memories/fpga/ram.sv \
../../../rtl/soc/memories/boot_rom.sv \
../../../rtl/soc/memories/code_ram.sv \
../../../rtl/soc/memories/data_ram.sv \
../../../rtl/soc/pmc/analog_conf/pmc_ac_pkg.sv \
../../../rtl/soc/pmc/analog_conf/pmc_ac_offset_decoder.sv \
../../../rtl/soc/pmc/analog_conf/pmc_ac.sv \
../../../rtl/soc/pmc/digital_conf/pmc_dc_pkg.sv \
../../../rtl/soc/pmc/digital_conf/pmc_dc_offset_decoder.sv \
../../../rtl/soc/pmc/digital_conf/pmc_dc.sv \
../../../rtl/soc/pmc/coprocessor/pmcc_pkg.sv \
../../../rtl/soc/pmc/coprocessor/pmcc_instr_decoder.sv \
../../../rtl/soc/pmc/coprocessor/pmcc_loop_controller.sv \
../../../rtl/soc/pmc/coprocessor/pmcc_loop_lifo.sv \
../../../rtl/soc/pmc/coprocessor/pmcc_matrix_controller.sv \
../../../rtl/soc/pmc/coprocessor/pmcc_wait_controller.sv \
../../../rtl/soc/pmc/coprocessor/pmcc.sv \
../../../rtl/soc/pmc/memories/fpga/pmcc_dpram.sv \
../../../rtl/soc/pmc/memories/pmcc_code_ram.sv \
../../../rtl/soc/pmc/pmc_pkg.sv \
../../../rtl/soc/pmc/pmc_offset_decoder.sv \
../../../rtl/soc/pmc/pmc.sv \
../../../rtl/soc/spi/spi_pkg.sv \
../../../rtl/soc/spi/spi_offset_decoder.sv \
../../../rtl/soc/spi/spi_master.sv \
../../../rtl/soc/spi/spi.sv \
../../../rtl/soc/timer/timer_pkg.sv \
../../../rtl/soc/timer/timer_core.sv \
../../../rtl/soc/timer/timer_offset_decoder.sv \
../../../rtl/soc/timer/timer.sv \
../../../rtl/soc/uart/uart_pkg.sv \
../../../rtl/soc/uart/uart_offset_decoder.sv \
../../../rtl/soc/uart/uart_receiver.sv \
../../../rtl/soc/uart/uart_transmitter.sv \
../../../rtl/soc/uart/uart.sv \
../../../rtl/soc/misc/edge_detector.sv \
../../../rtl/soc/misc/serial_clock_generator.sv \
../../../rtl/soc/mtm_riscv_soc.sv \
../../../asic/rtl/mtm_riscv_chip.sv \
../../../asic/rtl/pads_in.v \
../../../asic/rtl/pads_out.v \
../../../asic/rtl/pads_pwr.v \
../../../sim/rtl/prim_clock_gating.sv
	./get_netlist.sh

clean:
	rm -f ${NETLIST} src_file_list.txt xrun.log
	rm -rf xcelium.d
