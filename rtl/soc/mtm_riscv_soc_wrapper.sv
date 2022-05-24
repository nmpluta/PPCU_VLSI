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

module mtm_riscv_soc_wrapper (
    input logic         clk,
    input logic         rst_n,

    output logic [31:0] gpio_out,
    input logic [31:0]  gpio_in,

    output logic        ss,
    output logic        sck,
    output logic        mosi,
    input logic         miso,

    output logic        sout,
    input logic         sin
);


/**
 * Local variables and signals
 */

soc_gpio_bus          gpio_bus ();
soc_spi_bus           spi_bus ();
soc_uart_bus          uart_bus ();

soc_pm_ctrl           pm_ctrl ();
soc_pm_data           pm_data ();
soc_pm_analog_config  pm_analog_config ();
soc_pm_digital_config pm_digital_config ();


/**
 * Signals assignments
 */

assign gpio_out = gpio_bus.dout;
assign gpio_bus.din = gpio_in;

assign ss = spi_bus.ss;
assign sck = spi_bus.sck;
assign mosi = spi_bus.mosi;
assign spi_bus.miso = miso;

assign sout = uart_bus.sout;
assign uart_bus.sin = sin;

assign pm_data.dout = 64'b0;


/**
 * Submodules placement
 */

mtm_riscv_soc u_mtm_riscv_soc (
    .clk,
    .rst_n,

    .gpio_bus,
    .spi_bus,
    .uart_bus,

    .pm_ctrl,
    .pm_data,
    .pm_analog_config,
    .pm_digital_config
);

endmodule
