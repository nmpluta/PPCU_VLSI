// Library - PPCU_VLSI_RISCV, Cell - pads_pwr, View - schematic
// LAST TIME SAVED: Apr  6 13:36:45 2020
// NETLIST TIME: Apr  6 16:46:17 2020
`timescale 1ns / 1ns

// TODO: provide proper number of power pads
// Note: the module must be set to "dont_touch" in the constraints

`ifdef KMIE_IMPLEMENT_ASIC

module pads_pwr ( );

//-- pad instances are note connected

//------------------------------------------------------------------------------
// Three power cell PVDD2DGZ and four ground cell PVSS3DGZ for I/O cells added.
// Three additional power pads added to get number of every pads divisible by 4.
//------------------------------------------------------------------------------

// core vdd
PVDD1DGZ VDD1_1_ ( .VDD() );
PVDD1DGZ VDD1_0_ ( .VDD() );

// additional power pads - vdd
PVDD2DGZ VDD2_4_ ( .VDDPST() );
PVDD2DGZ VDD2_3_ ( .VDDPST() );
    
// io vdd
PVDD2DGZ VDD2_2_ ( .VDDPST() );
PVDD2DGZ VDD2_1_ ( .VDDPST() );
PVDD2DGZ VDD2_0_ ( .VDDPST() );
    
// io power on control (only one)
PVDD2POC VDD2POC ( .VDDPST() );

// additional power pad - ground
PVSS3DGZ VSS3_6_ ( .VSS() );

// io ground
PVSS3DGZ VSS3_5_ ( .VSS() );
PVSS3DGZ VSS3_4_ ( .VSS() );
PVSS3DGZ VSS3_3_ ( .VSS() );
PVSS3DGZ VSS3_2_ ( .VSS() );

// common ground    
PVSS3DGZ VSS3_1_ ( .VSS() );
PVSS3DGZ VSS3_0_ ( .VSS() );

endmodule

`endif
