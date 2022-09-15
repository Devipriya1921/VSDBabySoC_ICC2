###################################################################

# Created by write_sdc on Tue Sep 13 11:10:32 2022

###################################################################
set sdc_version 2.0

set_units -time ns
set_max_area 8000
set_load -pin_load 0.5 [get_ports {OUT[9]}]
set_load -pin_load 0.5 [get_ports {OUT[8]}]
set_load -pin_load 0.5 [get_ports {OUT[7]}]
set_load -pin_load 0.5 [get_ports {OUT[6]}]
set_load -pin_load 0.5 [get_ports {OUT[5]}]
set_load -pin_load 0.5 [get_ports {OUT[4]}]
set_load -pin_load 0.5 [get_ports {OUT[3]}]
set_load -pin_load 0.5 [get_ports {OUT[2]}]
set_load -pin_load 0.5 [get_ports {OUT[1]}]
set_load -pin_load 0.5 [get_ports {OUT[0]}]
set_load -min -pin_load 0.5 [get_ports {OUT[9]}]
set_load -min -pin_load 0.5 [get_ports {OUT[8]}]
set_load -min -pin_load 0.5 [get_ports {OUT[7]}]
set_load -min -pin_load 0.5 [get_ports {OUT[6]}]
set_load -min -pin_load 0.5 [get_ports {OUT[5]}]
set_load -min -pin_load 0.5 [get_ports {OUT[4]}]
set_load -min -pin_load 0.5 [get_ports {OUT[3]}]
set_load -min -pin_load 0.5 [get_ports {OUT[2]}]
set_load -min -pin_load 0.5 [get_ports {OUT[1]}]
set_load -min -pin_load 0.5 [get_ports {OUT[0]}]
create_clock [get_ports CLK]  -name MYCLK  -period 10  -waveform {0 5}
set_clock_uncertainty -setup 0.5  [get_clocks MYCLK]
set_clock_uncertainty -hold 0.1  [get_clocks MYCLK]
set_input_delay -clock MYCLK  -max 5  [get_ports CLK]
set_input_delay -clock MYCLK  -min 1  [get_ports CLK]
set_input_delay -clock MYCLK  -max 5  [get_ports reset]
set_input_delay -clock MYCLK  -min 1  [get_ports reset]
set_input_transition -max 0.4  [get_ports reset]
set_input_transition -min 0.1  [get_ports reset]
set_input_transition -max 0.4  [get_ports CLK]
set_input_transition -min 0.1  [get_ports CLK]
