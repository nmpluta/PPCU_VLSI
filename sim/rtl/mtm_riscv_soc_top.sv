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

module mtm_riscv_soc_top (
    output logic [3:0] led,
    output logic       boot_sequence_done,
    input logic        clk,
    input logic        rst_n,
    input logic [3:0]  btn
);


/**
 * Local variables and signals
 */

logic [31:0] gpio_out, gpio_in;
logic        ss, sck, mosi, miso;


/**
 * Signals assignments
 */

assign gpio_in[17] = 1'b0;     /* codeload skipping */
assign gpio_in[16] = 1'b0;     /* codeload source: spi */
assign gpio_in[3:0] = btn;
assign led = gpio_out[3:0];


/**
 * Submodules placement
 */

`ifdef KMIE_IMPLEMENT_FPGA

assign boot_sequence_done = gpio_out[15];

mtm_riscv_soc_wrapper u_mtm_riscv_soc_wrapper (
    .clk,
    .rst_n,

    .gpio_out,
    .gpio_in,

    .ss,
    .sck,
    .mosi,
    .miso,

    .sout(),
    .sin(1'b0)
);
`endif

`ifdef KMIE_IMPLEMENT_ASIC
assign boot_sequence_done = gpio_out[4];

mtm_riscv_chip u_mtm_riscv_chip (
    .clk,
    .rst_n,

    .gpio_out(gpio_out[4:0]),
    .gpio_in(gpio_in[3:0]),

    .ss,
    .sck,
    .mosi,
    .miso,

    .sout(),
    .sin(1'b0)
);
`endif

spi_flash_memory u_spi_flash_memory (
    .miso,
    .clk,
    .rst_n,
    .ss,
    .sck,
    .mosi
);

endmodule
