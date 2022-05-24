/**
 * Copyright (C) 2021  AGH University of Science and Technology
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

`timescale 1ns / 1ns
`ifdef KMIE_IMPLEMENT_ASIC

module mtm_riscv_chip (
    input logic        clk,
    input logic        rst_n,

    output logic [4:0] gpio_out,
    input logic [3:0]  gpio_in,

    output logic       ss,
    output logic       sck,
    output logic       mosi,
    input logic        miso,

    output logic       sout,
    input logic        sin
);


/**
 * Local variables and signals
 */

logic        clk_core, rst_n_core;
logic [31:0] gpio_out_core, gpio_in_core;
logic        ss_core, sck_core, mosi_core, miso_core;
logic        sout_core, sin_core;


/**
 * Signals assignments
 */

assign gpio_in_core[17] = 1'b0;  /* codeload skipping */
assign gpio_in_core[16] = 1'b0;  /* codeload source: spi */


/**
 * Submodules placement
 */

mtm_riscv_soc_wrapper u_mtm_riscv_soc_wrapper (
    .clk(clk_core),
    .rst_n(rst_n_core),

    .gpio_out(gpio_out_core),
    .gpio_in(gpio_in_core),

    .ss(ss_core),
    .sck(sck_core),
    .mosi(mosi_core),
    .miso(miso_core),

    .sout(sout_core),
    .sin(sin_core)
);

pads_out u_pads_out (
    .boot_sequence_done(gpio_out[4]),
    .led(gpio_out[3:0]),
    .spi_mosi(mosi),
    .spi_sck(sck),
    .spi_ss(ss),
    .uart_sout(sout),
    .boot_sequence_done_core(gpio_out_core[15]),
    .led_core(gpio_out_core[3:0]),
    .spi_mosi_core(mosi_core),
    .spi_sck_core(sck_core),
    .spi_ss_core(ss_core),
    .uart_sout_core(sout_core)
);

pads_in u_pads_in (
    .btn_core(gpio_in_core[3:0]),
    .clk_core(clk_core),
    .rst_n_core(rst_n_core),
    .spi_miso_core(miso_core),
    .uart_sin_core(sin_core),
    .btn(gpio_in[3:0]),
    .clk(clk),
    .rst_n(rst_n),
    .spi_miso(miso),
    .uart_sin(sin)
);

pads_pwr u_pads_pwr ();

endmodule

`endif
