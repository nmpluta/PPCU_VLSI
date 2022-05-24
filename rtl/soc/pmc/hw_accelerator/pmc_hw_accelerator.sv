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

module pmc_hw_accelerator (
    output logic [63:0]       pm_din,
    input logic [63:0]        pm_dout,

    output logic [31:0][15:0] din,
    input logic               clk,
    input logic               rst_n,
    input logic               clk_sh,
    input logic               sh_a,
    input logic [31:0][15:0]  dout
);


/**
 * Submodules placement
 */

pmc_hw_accelerator_transmitter u_pmc_hw_accelerator_transmitter (
    .pm_dout(pm_din),
    .clk(clk_sh & sh_a),
    .rst_n,
    .dout
);

pmc_hw_accelerator_receiver u_pmc_hw_accelerator_receiver (
    .din,
    .clk(clk_sh & sh_a),
    .rst_n,
    .pm_din(pm_dout)
);

endmodule
