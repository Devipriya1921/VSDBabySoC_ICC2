################################################################################
#
# Created by icc2 write_floorplan on Wed Sep 14 02:05:32 2022
#
################################################################################


set _dirName__0 [file dirname [file normalize [info script]]]

################################################################################
# Rows
################################################################################

remove_site_arrays -all

remove_site_rows -all

################################################################################
# Pins
################################################################################

set __pins [get_terminals -quiet]
if {[sizeof_collection $__pins] > 0} {
set __termShapes [get_shapes -of_objects [get_terminals * -quiet] -quiet]
if {[sizeof_collection $__termShapes] > 0} {
remove_shapes $__termShapes -force
}
set __termVias [get_vias -of_objects [get_terminals * -quiet] -quiet]
if {[sizeof_collection $__termVias] > 0} {
remove_vias $__termVias -force
}
set __termShapePatterns [get_shape_patterns -of_objects [get_terminals * -quiet] -quiet]
if {[sizeof_collection $__termShapePatterns] > 0} {
remove_shape_patterns $__termShapePatterns
}
}

################################################################################
# Net shapes and vias
################################################################################

set __netshapes [get_shapes -quiet]
if {[sizeof_collection $__netshapes] > 0} {
remove_shapes $__netshapes -force
}

set __netShapePatterns [get_shape_patterns -quiet]
if {[sizeof_collection $__netShapePatterns] > 0} {
remove_shape_patterns $__netShapePatterns
}

set __vias [get_vias -quiet]
if {[sizeof_collection $__vias] > 0} {
remove_vias $__vias -force
}

################################################################################
# Read DEF
################################################################################

read_def  ${_dirName__0}/floorplan.def.gz

################################################################################
# Voltage areas
################################################################################

remove_voltage_areas -all



################################################################################
# User attributes of voltage areas
################################################################################

################################################################################
# Site arrays
################################################################################

create_site_array -name unit_row -site unit -default -boundary { {0.0000 0.0000} {267.7100 267.4000} } -flip_first_row true -flip_alternate_row true -transparent false -direction horizontal -x_margin 0.0000 -y_margin 0.0000 -core_offset { 0.0000 0.0000 } -aligned true

################################################################################
# User attributes of site arrays
################################################################################


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

remove_routing_guides -all



################################################################################
# Blockages
################################################################################

remove_routing_blockages -all -force

remove_placement_blockages -all -force

remove_pin_blockages -all

remove_shaping_blockages -all

################################################################################
# User attributes of blockages
################################################################################

################################################################################
# Module Boundaries
################################################################################

set hbCells [get_cells -quiet -filter hierarchy_type==boundary -hierarchical]
if [sizeof_collection $hbCells] {
   set_cell_hierarchy_type -type normal $hbCells
}


################################################################################
# Placment_Attractions
################################################################################

set _placementAttractions [get_placement_attractions * -quiet]
if [sizeof_collection $_placementAttractions] {
remove_placement_attractions $_placementAttractions -force
}

################################################################################
# User attributes of placement attractions
################################################################################


################################################################################
# Bump regions
################################################################################

remove_bump_regions -all

remove_bump_region_patterns -all

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
# I/O guides
################################################################################

remove_io_guides -all


################################################################################
# User attributes of I/O guides
################################################################################


################################################################################
# Edit groups
################################################################################

remove_edit_groups -all -force


################################################################################
# User attributes of edit groups
################################################################################


################################################################################
# PG regions
################################################################################

remove_pg_regions -all


################################################################################
# User attributes of pg regions
################################################################################


################################################################################
# Routing corridors
################################################################################

remove_routing_corridors -all


################################################################################
# Routing directions
################################################################################

set_attribute -objects [get_layers metal1] -name routing_direction -value horizontal
set_attribute -objects [get_layers metal2] -name routing_direction -value vertical
set_attribute -objects [get_layers metal3] -name routing_direction -value horizontal
set_attribute -objects [get_layers metal4] -name routing_direction -value vertical
set_attribute -objects [get_layers metal5] -name routing_direction -value horizontal
set_attribute -objects [get_layers metal6] -name routing_direction -value vertical
set_attribute -objects [get_layers metal7] -name routing_direction -value horizontal
set_attribute -objects [get_layers metal8] -name routing_direction -value vertical
set_attribute -objects [get_layers metal9] -name routing_direction -value horizontal
set_attribute -objects [get_layers metal10] -name routing_direction -value vertical

################################################################################
# Tracks and their user attributes
################################################################################

remove_tracks -all

set track [create_track -layer metal1 -count 1911 -dir Y -space 0.1400 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.7100 267.4000 }}]
set track [create_track -layer metal1 -count 1913 -dir X -space 0.1400 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.6800 267.4000 }}]
set track [create_track -layer metal2 -count 1408 -dir Y -space 0.1900 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.7100 267.3300 }}]
set track [create_track -layer metal2 -count 1410 -dir X -space 0.1900 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.7100 267.4000 }}]
set track [create_track -layer metal3 -count 1911 -dir Y -space 0.1400 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.7100 267.4000 }}]
set track [create_track -layer metal3 -count 1913 -dir X -space 0.1400 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.6800 267.4000 }}]
set track [create_track -layer metal4 -count 956 -dir Y -space 0.2800 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.7100 267.4000 }}]
set track [create_track -layer metal4 -count 957 -dir X -space 0.2800 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.6800 267.4000 }}]
set track [create_track -layer metal5 -count 956 -dir Y -space 0.2800 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.7100 267.4000 }}]
set track [create_track -layer metal5 -count 957 -dir X -space 0.2800 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.6800 267.4000 }}]
set track [create_track -layer metal6 -count 956 -dir Y -space 0.2800 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.7100 267.4000 }}]
set track [create_track -layer metal6 -count 957 -dir X -space 0.2800 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.6800 267.4000 }}]
set track [create_track -layer metal7 -count 335 -dir Y -space 0.8000 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.7100 267.2000 }}]
set track [create_track -layer metal7 -count 335 -dir X -space 0.8000 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.2000 267.4000 }}]
set track [create_track -layer metal8 -count 335 -dir Y -space 0.8000 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.7100 267.2000 }}]
set track [create_track -layer metal8 -count 335 -dir X -space 0.8000 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.2000 267.4000 }}]
set track [create_track -layer metal9 -count 168 -dir Y -space 1.6000 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.7100 267.2000 }}]
set track [create_track -layer metal9 -count 168 -dir X -space 1.6000 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.2000 267.4000 }}]
set track [create_track -layer metal10 -count 168 -dir Y -space 1.6000 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.7100 267.2000 }}]
set track [create_track -layer metal10 -count 168 -dir X -space 1.6000 -coord 0.0000 -bbox {{0.0000 0.0000 } {267.2000 267.4000 }}]

################################################################################
# Terminals/shapes/vias of ports with user attributes
################################################################################

################################################################################
# User attributes of ports
################################################################################


################################################################################
# Shapes and vias of net and their user attributes
################################################################################


################################################################################
# User attributes of routing rules
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


