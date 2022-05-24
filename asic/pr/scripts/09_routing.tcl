#------------------------------------------------------------------------------
# (#09) ROUTING
#------------------------------------------------------------------------------
# Do not modify this file.
#------------------------------------------------------------------------------
source scripts/_00_common_settings.tcl

# Insert I/O filler instances to close the I/O ring.
# Menu: Place -> Physical cell -> Add I/O Filler ...
add_io_fillers -cells {PFILLER20 PFILLER10 PFILLER5 PFILLER1 PFILLER05 PFILLER0005}


# Insert decaps and fillers in the standard cell rows

# Menu: Place -> Physical cell -> Add Filler ...
set_db add_fillers_cells {OD25DCAP64BWP OD25DCAP32BWP OD25DCAP16BWP DCAP8BWP DCAP4BWP DCAPBWP FILL3BWP FILL2BWP FILL1BWP}

# Specify the prefix for the added filler cells
set_db add_fillers_prefix FILLER

# Insert filler cell instances in the gaps between standard cell instances
add_fillers


# Route design.
# Menu: Route -> Nanoroute -> Route...

# Minimize timing violations by analyzing the timing slack for each path,
# the drive strengths of each cell in the library, and the maximum capacitance
# and maximum transition limits
set_db route_design_with_timing_driven 1

# Disable crosstalk prevention and reduction
set_db route_design_with_si_driven 0

# Replace single-cut vias with multiple-cut vias in a fully routed design
set_db route_design_detail_post_route_swap_via multiCut

# Run routing and postroute via and wire optimization using the NanoRoute router
route_design -global_detail -via_opt -wire_opt
