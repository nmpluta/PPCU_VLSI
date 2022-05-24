/**
 * Copyright (C) 2020  AGH University of Science and Technology
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

module tb_mtm_riscv_soc ();


/**
 * Local variables and signals
 */

logic            clk, rst_n;
logic            boot_sequence_done;
logic      [3:0] led, btn;


/**
 * Submodules placement
 */

`define TOP_MODULE u_mtm_riscv_soc_top

mtm_riscv_soc_top `TOP_MODULE (.*);


/**
 * Task and functions definitions
 */

task reset();
    $assertoff;
    @(posedge clk) $display("%0t reset: posedge clk detected",$time);
    repeat(1)
        @(negedge clk) $display("%0t reset: negedge clk detected",$time);
    rst_n = 0;
    $display("%0t reset: reset activated",$time);
    @(negedge clk) ;
    $asserton;
    rst_n = 1;
    $display("%0t reset: reset disactivated",$time);
endtask

`ifdef KMIE_IMPLEMENT_FPGA
// FPGA memory uses the same input file as the ASIC for initialization
task fpga_memory_init();
    $readmemh("TS1N40LPB4096X32M4M_initial.cde",
        `TOP_MODULE.u_mtm_riscv_soc_wrapper.u_mtm_riscv_soc.u_peripherals.u_code_ram.u_ram.mem);
    $readmemh("TS1N40LPB4096X32M4M_initial.cde",
        `TOP_MODULE.u_mtm_riscv_soc_wrapper.u_mtm_riscv_soc.u_peripherals.u_data_ram.u_ram.mem);
endtask
`endif


/**
 * Test
 */

localparam       ON                 = 3, OFF = 4;
localparam       UNIQUE             = 32, UNIQUE0 = 64, PRIORITY = 128;

initial begin
`ifdef KMIE_IMPLEMENT_FPGA
    fpga_memory_init();
`endif

`ifdef DEBUG
    dump_memories();
`endif

    rst_n = 1;
    btn   = 4'h0;

    $assertoff; // Disable time 0 assertions
    // Turn OFF the violation reporting for unique case, unique0 case, priority case, unique if, etc.
    $assertcontrol( OFF , UNIQUE | UNIQUE0 | PRIORITY );

    reset();

    $asserton;  // Enable assertions after reset
    // Turn ON the violation reporting for unique case, unique0 case, priority case, unique if, etc.
    $assertcontrol( ON , UNIQUE | UNIQUE0 | PRIORITY );

    @(posedge boot_sequence_done) ;
    $display("%0t main: boot_sequence_done",$time);

`ifdef DEBUG
    dump_memories();
`endif

    #2000000;

`ifdef DEBUG
    dump_memories();
`endif

    $finish;
end


/**
 * Monitoring
 */

initial begin : watchdog
    $timeformat(-9, 0, " ns", 0);
    #50ms $display("%0t watchdog timeout!",$time);
`ifdef DEBUG
    dump_memories();
`endif
    $finish;
end

always begin : timestamp
    #1ms $display("%0t timestamp", $time);
end


/**
 * Write led[3:0] waveforms to file.
 */

integer          F;
initial begin
    F = $fopen("led_waves.txt");
    #1ns wait(boot_sequence_done);
    $fmonitor(F, "%b", led);
end

final begin
    $fclose(F);
end


/**
 * Clock generator
 */

initial begin
    // -xminitialize rand_2state:N can set the clock line elements in different
    // logic values. Need to propagate the correct clock value at the beginning.
    clk = 0; // This can generate active clock edge detected at 0 time.
    // This generates assertion errors at time 0. Need to disable assertions
    // at time 0 as above ($assert...).

    forever begin : clock
        #10 clk = 1'b0;
        #10 clk = 1'b1;
    end
end


/**
 * Memory dump functions.
 */

task dump_memories();
`ifdef KMIE_IMPLEMENT_FPGA
    dump_memory_code_fpga();
    dump_memory_data_fpga();
`endif
`ifdef KMIE_IMPLEMENT_ASIC
    dump_memory_code_TS1N40LPB4096X32M4M();
    dump_memory_data_TS1N40LPB4096X32M4M();
`endif
endtask

// -----------------------------------------------------------------------------
// generic memory dump
`define DUMP_MEMORY_TASK(NAME, MEM_SIZE, MEM_VAR) \
task automatic NAME (); \
    integer mem_f; \
    string file_name; \
    begin \
        file_name = $sformatf("%s_%0d.hex", `"NAME`", $realtime); \
        $display("%0t Dumping memory: %s", $time, `"MEM_VAR`"); \
        $display("          File name: %s", file_name); \
        mem_f = $fopen(file_name); \
        for(int i=0; i < MEM_SIZE; i++) begin \
            $fdisplay(mem_f, "%X", MEM_VAR[i]); \
        end \
        $fclose(mem_f); \
    end \
endtask

// -----------------------------------------------------------------------------
// FPGA memories

`ifdef KMIE_IMPLEMENT_FPGA
`DUMP_MEMORY_TASK(dump_memory_code_fpga, 4096,
    `TOP_MODULE.u_mtm_riscv_soc_wrapper.u_mtm_riscv_soc.u_peripherals.u_code_ram.u_ram.mem)
`DUMP_MEMORY_TASK(dump_memory_data_fpga, 4096,
    `TOP_MODULE.u_mtm_riscv_soc_wrapper.u_mtm_riscv_soc.u_peripherals.u_data_ram.u_ram.mem)
`endif

// -----------------------------------------------------------------------------
// ASIC memories

`ifdef KMIE_IMPLEMENT_ASIC

`define DUMP_MEMORY_TASK_TS1N40LPB4096X32M4M(NAME, MEM_VAR) \
task automatic NAME (); \
    integer mem_f; \
    string file_name; \
    begin \
        file_name = $sformatf("%s_%0d.hex", `"NAME`", $realtime); \
        $display("%0t Dumping memory: %s", $time, `"MEM_VAR`"); \
        $display("          File name: %s", file_name); \
        mem_f = $fopen(file_name); \
        for (int row = 0; row <= 1024-1; row++) begin \
            for (int col = 0; col <= 4-1; col++) begin \
                $fdisplay(mem_f, "%X", MEM_VAR[row][col] ); \
            end \
        end \
        $fclose(mem_f); \
    end \
endtask

`DUMP_MEMORY_TASK_TS1N40LPB4096X32M4M(dump_memory_code_TS1N40LPB4096X32M4M,
    `TOP_MODULE.u_mtm_riscv_chip.u_mtm_riscv_soc_wrapper.u_mtm_riscv_soc.u_peripherals.u_code_ram.u_ram.u_TS1N40LPB4096X32M4M.MEMORY)
`DUMP_MEMORY_TASK_TS1N40LPB4096X32M4M(dump_memory_data_TS1N40LPB4096X32M4M,
    `TOP_MODULE.u_mtm_riscv_chip.u_mtm_riscv_soc_wrapper.u_mtm_riscv_soc.u_peripherals.u_data_ram.u_ram.u_TS1N40LPB4096X32M4M.MEMORY)

`endif
// -----------------------------------------------------------------------------

endmodule
