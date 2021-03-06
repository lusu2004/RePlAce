# 
# Examples for Timing-driven RePlAce with TCL usage
#

set design wb_dma_top 
set lib_dir library/a2a/
set design_dir design/a2a/${design}
set exp_folder or-td-test-02 

# Import LEF/DEF files
read_lef ${lib_dir}/contest.lef
read_def ${design_dir}/${design}.def

# timing-driven parameters
read_liberty ${lib_dir}/contest.lib
read_sdc ${design_dir}/${design}.sdc

set rep [replace_external]
$rep set_verbose_level 0
$rep set_unit_res 1.6
$rep set_unit_cap 0.23e-14
$rep set_net_weight_apply false
$rep set_timing_driven 1 
$rep init_replace
$rep place_cell_nesterov_place

# global_placement -timing_driven -wire_res 1.6 -wire_cap 0.23e-14

set fp [open ${exp_folder}/${design}_2_orig.rpt w]
puts $fp "HPWL: [$rep get_hpwl]"
puts $fp "WNS: [$rep get_wns]"
puts $fp "TNS: [$rep get_tns]"
close $fp

exit
