################################################################################
#
# Created by icc2 write_floorplan on Wed Sep 14 02:05:32 2022
#
################################################################################

set _dirName__0 [file dirname [file normalize [info script]]]

################################################################################
# Rows
################################################################################

cut_row -all

################################################################################
# Pins
################################################################################

if {![string equal "icc_shell" $synopsys_program_name]} {
remove_terminal *

}
if {[string equal "icc_shell" $synopsys_program_name] && [sizeof_collection  [get_terminals  -quiet *]] > 0}  {
remove_terminal [get_terminals  -quiet *]

}
################################################################################
# Net shapes and vias
################################################################################

if {![string equal "icc_shell" $synopsys_program_name]} {
remove_net_shape *
}

if {[string equal "icc_shell" $synopsys_program_name] && [sizeof_collection [get_net_shapes *]] > 0} {
remove_net_shape [get_net_shapes *]
}

if {![string equal "icc_shell" $synopsys_program_name]} {
remove_user_shape *
}

if {[string equal "icc_shell" $synopsys_program_name] && [sizeof_collection [get_user_shapes *]] > 0} {
remove_user_shape [get_user_shapes *]
}

if {![string equal "icc_shell" $synopsys_program_name]} {
remove_via *
}

if {[string equal "icc_shell" $synopsys_program_name] && [sizeof_collection [get_vias *]] > 0} {
remove_via [get_vias *]
}

################################################################################
# Read DEF
################################################################################

set_app_var def_enable_no_legalize_name true
read_def  -snet_no_shape_as_detail_route ${_dirName__0}/floorplan.def.gz

################################################################################
# Site rows cycle and offset attributes
################################################################################

################################################################################
# User attributes of site rows
################################################################################


################################################################################
# Keepouts
################################################################################


################################################################################
# User attributes of cells
################################################################################


################################################################################
# Bounds and user attributes of bound shapes
################################################################################

remove_bounds -all


################################################################################
# User attributes of bounds
################################################################################


################################################################################
# Pin guides
################################################################################

remove_pin_guides -all


################################################################################
# Route guides and their user attributes
################################################################################

remove_route_guide -all

if {[string equal "icc_shell" $synopsys_program_name]} {
}


if {[string equal "icc_shell" $synopsys_program_name]} {
}


################################################################################
# Blockages
################################################################################

remove_placement_blockage -all

################################################################################
# User attributes of blockages
################################################################################

################################################################################
# Placment_Attractions
################################################################################

################################################################################
# User attributes of placement attractions
################################################################################


################################################################################
# Bump regions
################################################################################

set __pbs [get_pseudo_bumps -quiet]
if {[sizeof_collection $__pbs] > 0} {
################################################################################
# set attributes of pseudo bumps
################################################################################

}
################################################################################
# User attributes of bump region
################################################################################

################################################################################
# Anchors
################################################################################

################################################################################
# Voltage areas
################################################################################

remove_voltage_area -all



################################################################################
# User attributes of voltage areas
################################################################################

################################################################################
# I/O guides
################################################################################


################################################################################
# User attributes of I/O guides
################################################################################

################################################################################
# Edit groups
################################################################################

remove_edit_groups -all


################################################################################
# User attributes of edit groups
################################################################################


################################################################################
# PG regions
################################################################################

################################################################################
# User attributes of pg regions
################################################################################

################################################################################
# Routing corridors
################################################################################

remove_routing_corridor -all


################################################################################
# Routing directions
################################################################################

set_preferred_routing_direction -layers [get_layers metal1] -direction horizontal
set_preferred_routing_direction -layers [get_layers metal2] -direction vertical
set_preferred_routing_direction -layers [get_layers metal3] -direction horizontal
set_preferred_routing_direction -layers [get_layers metal4] -direction vertical
set_preferred_routing_direction -layers [get_layers metal5] -direction horizontal
set_preferred_routing_direction -layers [get_layers metal6] -direction vertical
set_preferred_routing_direction -layers [get_layers metal7] -direction horizontal
set_preferred_routing_direction -layers [get_layers metal8] -direction vertical
set_preferred_routing_direction -layers [get_layers metal9] -direction horizontal
set_preferred_routing_direction -layers [get_layers metal10] -direction vertical

################################################################################
# Tracks and their user attributes
################################################################################

remove_track -all

set track [create_track -layer metal1 -count 1911 -dir Y -space 0.1400 -coord 0.0000 -return_object]
set track [create_track -layer metal1 -count 1913 -dir X -space 0.1400 -coord 0.0000 -return_object]
set track [create_track -layer metal2 -count 1408 -dir Y -space 0.1900 -coord 0.0000 -return_object]
set track [create_track -layer metal2 -count 1410 -dir X -space 0.1900 -coord 0.0000 -return_object]
set track [create_track -layer metal3 -count 1911 -dir Y -space 0.1400 -coord 0.0000 -return_object]
set track [create_track -layer metal3 -count 1913 -dir X -space 0.1400 -coord 0.0000 -return_object]
set track [create_track -layer metal4 -count 956 -dir Y -space 0.2800 -coord 0.0000 -return_object]
set track [create_track -layer metal4 -count 957 -dir X -space 0.2800 -coord 0.0000 -return_object]
set track [create_track -layer metal5 -count 956 -dir Y -space 0.2800 -coord 0.0000 -return_object]
set track [create_track -layer metal5 -count 957 -dir X -space 0.2800 -coord 0.0000 -return_object]
set track [create_track -layer metal6 -count 956 -dir Y -space 0.2800 -coord 0.0000 -return_object]
set track [create_track -layer metal6 -count 957 -dir X -space 0.2800 -coord 0.0000 -return_object]
set track [create_track -layer metal7 -count 335 -dir Y -space 0.8000 -coord 0.0000 -return_object]
set track [create_track -layer metal7 -count 335 -dir X -space 0.8000 -coord 0.0000 -return_object]
set track [create_track -layer metal8 -count 335 -dir Y -space 0.8000 -coord 0.0000 -return_object]
set track [create_track -layer metal8 -count 335 -dir X -space 0.8000 -coord 0.0000 -return_object]
set track [create_track -layer metal9 -count 168 -dir Y -space 1.6000 -coord 0.0000 -return_object]
set track [create_track -layer metal9 -count 168 -dir X -space 1.6000 -coord 0.0000 -return_object]
set track [create_track -layer metal10 -count 168 -dir Y -space 1.6000 -coord 0.0000 -return_object]
set track [create_track -layer metal10 -count 168 -dir X -space 1.6000 -coord 0.0000 -return_object]

################################################################################
# Terminals/shapes/vias of ports with user attributes
################################################################################

#user attribute definitions from ICC2's terminal
#user attribute definitions from ICC2's shape
#user attribute definitions from ICC2's via
################################################################################
# User attributes of ports
################################################################################


################################################################################
# Shapes and vias of net and their user attributes
################################################################################


################################################################################
# User attributes of pins
################################################################################


################################################################################
# User attributes of nets
################################################################################


################################################################################
# User attributes of current block
################################################################################


