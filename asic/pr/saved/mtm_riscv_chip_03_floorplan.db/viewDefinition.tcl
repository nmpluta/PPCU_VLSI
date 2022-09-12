if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name WCZ_stdcell_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tcbn40lpbwpwcz.lib]
create_library_set -name ML_iocell_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tpfn40lpgv2od3ml1.lib]
create_library_set -name LT_mem_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/ts1n40lpb4096x32m4m_250a_ff1p21vm40c.lib]
create_library_set -name WCZ_iocell_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tpfn40lpgv2od3wcz1.lib]
create_library_set -name WC_iocell_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tpfn40lpgv2od3wc1.lib]
create_library_set -name WC_mem_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/ts1n40lpb4096x32m4m_250a_ss0p99v125c.lib]
create_library_set -name WC_stdcell_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tcbn40lpbwpwc.lib]
create_library_set -name ML_mem_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/ts1n40lpb4096x32m4m_250a_ff1p21v125c.lib]
create_library_set -name LT_stdcell_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tcbn40lpbwplt.lib]
create_library_set -name BC_mem_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/ts1n40lpb4096x32m4m_250a_ff1p21v0c.lib]
create_library_set -name TC_stdcell_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tcbn40lpbwptc.lib]
create_library_set -name WCL_stdcell_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tcbn40lpbwpwcl.lib]
create_library_set -name TC_mem_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/ts1n40lpb4096x32m4m_250a_tt1p1v25c.lib]
create_library_set -name WCL_mem_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/ts1n40lpb4096x32m4m_250a_ss0p99vm40c.lib]
create_library_set -name BC_iocell_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tpfn40lpgv2od3bc1.lib]
create_library_set -name ML_stdcell_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tcbn40lpbwpml.lib]
create_library_set -name BC_stdcell_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tcbn40lpbwpbc.lib]
create_library_set -name LT_iocell_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tpfn40lpgv2od3lt1.lib]
create_library_set -name WCZ_mem_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/ts1n40lpb4096x32m4m_250a_ss0p99v0c.lib]
create_library_set -name TC_iocell_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tpfn40lpgv2od3tc1.lib]
create_library_set -name WCL_iocell_libs\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tpfn40lpgv2od3wcl1.lib]
create_opcond -name ML_op_cond -process 1 -voltage 1.21 -temperature 125
create_opcond -name WCZ_op_cond -process 1 -voltage 0.99 -temperature 0
create_opcond -name LT_op_cond -process 1 -voltage 1.21 -temperature -40
create_opcond -name WC_op_cond -process 1 -voltage 0.99 -temperature 125
create_opcond -name BC_op_cond -process 1 -voltage 1.21 -temperature 0
create_opcond -name TC_op_cond -process 1 -voltage 0.99 -temperature 25
create_opcond -name WCL_op_cond -process 1 -voltage 0.99 -temperature -40
create_timing_condition -name BC_tc\
   -library_sets [list BC_stdcell_libs BC_mem_libs BC_iocell_libs]\
   -opcond BC_op_cond
create_timing_condition -name WC_tc\
   -library_sets [list WC_stdcell_libs WC_mem_libs WC_iocell_libs]\
   -opcond WC_op_cond
create_timing_condition -name WCZ_tc\
   -library_sets [list WCZ_stdcell_libs WCZ_mem_libs WCZ_iocell_libs]\
   -opcond WCZ_op_cond
create_timing_condition -name ML_tc\
   -library_sets [list ML_stdcell_libs ML_mem_libs ML_iocell_libs]\
   -opcond ML_op_cond
create_timing_condition -name TC_tc\
   -library_sets [list TC_stdcell_libs TC_mem_libs TC_iocell_libs]\
   -opcond TC_op_cond
create_timing_condition -name WCL_tc\
   -library_sets [list WCL_stdcell_libs WCL_mem_libs WCL_iocell_libs]\
   -opcond WCL_op_cond
create_timing_condition -name LT_tc\
   -library_sets [list LT_stdcell_libs LT_mem_libs LT_iocell_libs]\
   -opcond LT_op_cond
create_rc_corner -name RCcorner_typical\
   -pre_route_res 1\
   -post_route_res {1 1 1}\
   -pre_route_cap 1\
   -post_route_cap {1 1 1}\
   -post_route_cross_cap {1 1 1}\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -post_route_clock_cap {1 1 1}\
   -post_route_clock_res {1 1 1}\
   -qrc_tech ${::IMEX::libVar}/mmmc/qrcTechFile
create_rc_corner -name RCcorner_cbest\
   -pre_route_res 1\
   -post_route_res {1 1 1}\
   -pre_route_cap 1\
   -post_route_cap {1 1 1}\
   -post_route_cross_cap {1 1 1}\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -post_route_clock_cap {1 1 1}\
   -post_route_clock_res {1 1 1}\
   -qrc_tech ${::IMEX::libVar}/mmmc/qrcTechFile.1
create_rc_corner -name RCcorner_rcworst\
   -pre_route_res 1\
   -post_route_res {1 1 1}\
   -pre_route_cap 1\
   -post_route_cap {1 1 1}\
   -post_route_cross_cap {1 1 1}\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -post_route_clock_cap {1 1 1}\
   -post_route_clock_res {1 1 1}\
   -qrc_tech ${::IMEX::libVar}/mmmc/qrcTechFile.2
create_rc_corner -name RCcorner_rcbest\
   -pre_route_res 1\
   -post_route_res {1 1 1}\
   -pre_route_cap 1\
   -post_route_cap {1 1 1}\
   -post_route_cross_cap {1 1 1}\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -post_route_clock_cap {1 1 1}\
   -post_route_clock_res {1 1 1}\
   -qrc_tech ${::IMEX::libVar}/mmmc/qrcTechFile.3
create_rc_corner -name RCcorner_cworst\
   -pre_route_res 1\
   -post_route_res {1 1 1}\
   -pre_route_cap 1\
   -post_route_cap {1 1 1}\
   -post_route_cross_cap {1 1 1}\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -post_route_clock_cap {1 1 1}\
   -post_route_clock_res {1 1 1}\
   -qrc_tech ${::IMEX::libVar}/mmmc/qrcTechFile.4
create_delay_corner -name WC_dc\
   -early_timing_condition {WC_tc}\
   -late_timing_condition {WC_tc}\
   -rc_corner RCcorner_cworst
create_delay_corner -name WCZ_dc\
   -early_timing_condition {WCZ_tc}\
   -late_timing_condition {WCZ_tc}\
   -rc_corner RCcorner_cworst
create_delay_corner -name ML_dc\
   -early_timing_condition {ML_tc}\
   -late_timing_condition {ML_tc}\
   -rc_corner RCcorner_cbest
create_delay_corner -name TC_dc\
   -early_timing_condition {TC_tc}\
   -late_timing_condition {TC_tc}\
   -rc_corner RCcorner_typical
create_delay_corner -name WCL_dc\
   -early_timing_condition {WCL_tc}\
   -late_timing_condition {WCL_tc}\
   -rc_corner RCcorner_cworst
create_delay_corner -name LT_dc\
   -early_timing_condition {LT_tc}\
   -late_timing_condition {LT_tc}\
   -rc_corner RCcorner_cbest
create_delay_corner -name BC_dc\
   -early_timing_condition {BC_tc}\
   -late_timing_condition {BC_tc}\
   -rc_corner RCcorner_cbest
create_constraint_mode -name standard_cm\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/mtm_riscv_chip.standard_cm.sdc]
create_analysis_view -name BC_av -constraint_mode standard_cm -delay_corner BC_dc
create_analysis_view -name WC_av -constraint_mode standard_cm -delay_corner WC_dc
create_analysis_view -name WCZ_av -constraint_mode standard_cm -delay_corner WCZ_dc
create_analysis_view -name ML_av -constraint_mode standard_cm -delay_corner ML_dc
create_analysis_view -name TC_av -constraint_mode standard_cm -delay_corner TC_dc
create_analysis_view -name WCL_av -constraint_mode standard_cm -delay_corner WCL_dc
create_analysis_view -name LT_av -constraint_mode standard_cm -delay_corner LT_dc
set_analysis_view -setup [list WC_av WCL_av WCZ_av] -hold [list BC_av LT_av ML_av] -leakage ML_av -dynamic LT_av
