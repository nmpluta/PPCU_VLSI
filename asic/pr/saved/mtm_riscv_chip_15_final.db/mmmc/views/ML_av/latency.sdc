set_clock_latency -source -early -min -rise  -0.261345 [get_pins {u_pads_in/u_clk/C}] -clock Tclk 
set_clock_latency -source -early -min -fall  -0.270208 [get_pins {u_pads_in/u_clk/C}] -clock Tclk 
set_clock_latency -source -early -max -rise  -0.261345 [get_pins {u_pads_in/u_clk/C}] -clock Tclk 
set_clock_latency -source -early -max -fall  -0.270208 [get_pins {u_pads_in/u_clk/C}] -clock Tclk 
set_clock_latency -source -late -min -rise  -0.261345 [get_pins {u_pads_in/u_clk/C}] -clock Tclk 
set_clock_latency -source -late -min -fall  -0.270208 [get_pins {u_pads_in/u_clk/C}] -clock Tclk 
set_clock_latency -source -late -max -rise  -0.261345 [get_pins {u_pads_in/u_clk/C}] -clock Tclk 
set_clock_latency -source -late -max -fall  -0.270208 [get_pins {u_pads_in/u_clk/C}] -clock Tclk 
