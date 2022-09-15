# VSDBabySoC

VSDBabySoC is a small SoC including PLL, DAC, and a RISCV-based processor named RVMYTH.

# Table of Contents
- [Introduction to VSDBabySoC](#introduction-to-vsdbabysoc)
  - [SoC](#soc)
  - [RVMYTH](#rvmyth)
  - [PLL](#pll)
  - [DAC](#dac)
- [VSDBabySoC Modeling](#vsdbabysoc-modeling)
- [Steps to follow for the OpenLane flow](#steps-to-follow-for-the-openlane-flow)
  - [OpenLANE installation](#openlane-installation)
  - [Pre-Synthesis Simulation](pre-synthesis-simulation)
  - [Post-Synthesis Simulation](#post-synthesis-simulation)
  - [Static timing analysis using OpenSTA](#static-timing-analysis-using-opensta)
  - [VSDBabySoC and TestBench GTKWave](#vsdbabysoc-and-testbench-gtkwave)
- [Synthesis of VSDBabySoC using Design Compiler](#synthesis-of-vsdbabysoc-using-design-compiler)
  - [Core Block Diagram and Schematic](#core-block-diagram-and-schematic)
  - [Pre-Synthesis Simulation](#pre-synthesis-simulation)
  - [Post-Synthesis Simulation](#post-synthesis-simulation)
- [Acknowledgements](#acknowledgements)
- [Author](#author)



# Intoduction to VSDBabySoC

VSDBabySoC is a small yet powerful RISCV-based SoC. The main purpose of designing such a small SoC is to test three open-source IP cores together for the first time and 
calibrate the analog part of it. VSDBabySoC contains one RVMYTH microprocessor, an 8x-PLL to generate a stable clock, and a 10-bit DAC to communicate with other analog 
devices.

![vsdbabysoc_block_diagram - 1](https://user-images.githubusercontent.com/83152452/180604666-65f17efc-f281-42bd-8f43-cccf0067891d.png)

## SoC

An SoC is a single-die chip that has some different IP cores on it. These IPs could vary from microprocessors (completely digital) to 5G broadband modems (completely analog).

## RVMYTH

RVMYTH core is a simple RISCV-based CPU, introduced in a workshop by RedwoodEDA and VSD. During a 5-day workshop students (including middle-schoolers) managed to create a processor from scratch. 
The workshop used the TLV for faster development. All of the present and future contributions to the IP will be done by students and under open-source licenses.

## PLL

A phase-locked loop or PLL is a control system that generates an output signal whose phase is related to the phase of an input signal. PLLs are widely used for synchronization purposes, including 
clock generation and distribution.

## DAC

A digital-to-analog converter or DAC is a system that converts a digital signal into an analog signal. DACs are widely used in modern communication systems enabling the 
generation of digitally-defined transmission signals. As a result, high-speed DACs are used for mobile communications and ultra-high-speed DACs are employed in optical 
communications systems.


# VSDBabySoC Modeling

Here we are going to use IC Compiler II for running the complete Physical Design Flow of VSDBabySoC (consisting of RVMYTH : Digital block, PLL & DAC : Analog blocks). 

The results, conclusions and future work will be summarized accordingly. 

Some initial input signals will be fed into vsdbabysoc module that make the pll start generating the proper CLK for the circuit. The clock signal will make the rvmyth 
to execute instructions in its imem. As a result, the register r17 will be filled with some values cycle by cycle. These values are used by dac core to provide the 
final output signal named OUT. So we have 3 main elements (IP cores) and a wrapper as an SoC.

The complete Design flow is supposed to be run using SAED32_28nm PDKs, But due to some issues with the .lib files of SAED32_28nm, We had to proceed further/shift to Nangate45nm PDKs.
And due to some issues with the DAC and PLL files, for the time-being we had to go ahead with running only the RVMYTH Digital block, in the VSDBabySoC for learning purpose.


# RVMYTH Modeling

As we mentioned in [What is RVMYTH](#what-is-rvmyth) section, RVMYTH is designed and created by the TL-Verilog language. 

So we need a way for compile and trasform it to the Verilog language and use the result in our SoC. Here the `sandpiper-saas` could help us do the job.

[Here](https://github.com/Devipriya1921/vsdriscv.git) is the repo we used as a reference to model the RVMYTH


# DAC Modeling

For the synthesis of Digital to Analog Converter, that is designed using Design Compiler and verified using PrimeWave we will refer the below repository. 

[Here](https://github.com/Devipriya1921/avsddac28nm.git) is the repository that documents all the work done for DAC


# PLL Modeling

It is not possible to sythesis an analog design with Verilog, yet. But there is a chance to simulate it using `real` datatype.

We will use the following repository done by my teammate to model the PLL core:

[Here](https://github.com/ireneann713/PLL) is the repo we used as a reference to model the PLL


# Getting Started with VSDBabySoC

1. Exporting the LEF Files for the Analog Blocks, i.e, DAC and PLL:

```
Custom Compiler (CC) Home Page > Export > LEF & Export > Stream
```

2. For the Digital Block, i.e, RVMYTH:

```
Use the rvmyth.v file
```

3. Write a vsdbabysoc.v code with modules named, rvmyth, PLL and DAC.

4. For the Gate-Level Synthesis of vsdbabysoc.v

```
Design Compiler (DC) shell [dc_shell] > source vsdbabysoc.tcl > generates the vsdbabysoc_gtlvl.v file (Synthesis file)
```

NOTE : You can check the contents of vsdbabysoc.tcl in the files provided in repository.

5. Perform the Physical Design:

```
Go to IC Compiler II Shell [icc2_shell] > source top.tcl > Performs the complete Physical Design Flow (The complete flow will be explained in the repository) > Note the results
```

NOTE : You can check the contents of top.tcl in the files provided in repository.



# IC Compiler II

![IC Compiler II Anchor in Synopsys Design Platform](https://user-images.githubusercontent.com/83152452/190413796-9000e5ae-2ffc-4704-b418-fee5395c3e4d.png)


IC Compiler II is the industry leading place and route solution that delivers best-in-class quality-of-results (QoR) for next-generation designs across all market verticals and 
process technologies while enabling unprecedented productivity. IC Compiler II includes innovative for flat and hierarchical design planning, early design exploration, congestion 
aware placement and optimization, clock tree synthesis, advanced node routing convergence, manufacturing compliance, and signoff closure.

![ic compiler summary](https://user-images.githubusercontent.com/83152452/190413831-db6fb1bb-95db-4dc3-8f62-c5171756ee0a.png)

IC Compiler II is specifically architected to address aggressive performance, power, area (PPA), and time-to-market pressures of leading-edge designs. Key technologies 
include a pervasively parallel optimization framework, multi-objective global placement, routing driven placement optimization, full flow Arc based concurrent clock and data 
optimization, total power optimization, multi-pattern and FinFET aware flow and machine learning (ML) driven optimization for fast and predictive design closure. Advanced Fusion 
technologies offer signoff IR drop driven optimization, PrimeTime delay calculation within IC Compiler II, exhaustive path-based analysis (PBA) and signoff ECO within place 
and route for unmatched QoR and design convergence.


## ICC Design Planning Overview

![design planning flow](https://user-images.githubusercontent.com/83152452/190414654-854275e2-c1a7-4de3-a334-fa5706209bb2.png)

Design planning is an integral part of the RTL to GDSII design process. During design planning, you assess the feasibility of different implementation strategies early in the 
design flow. For large designs, design planning helps you to “divide and conquer” the implementation process by partitioning the design into smaller, more manageable pieces 
for more efficient processing.

Floorplanning is the process of partitioning logical blocks into physical blocks, sizing and placing the blocks, performing a floorplan-level placement of macros and standard 
cells, and creating a power plan. The goal of floorplanning is to increase the efficiency of downstream physical design steps to enable a robust, optimized design. To generate 
accurate budget estimates for the physical blocks, you generate timing estimates to guide timing budget allocation between the blocks and top-level cells in the design. 
Floorplanning can also be an iterative process that reshapes blocks, creates a new cell placement, reallocates timing budgets, and rechecks top-level timing until an optimal 
floorplan is created.

An effective floorplan helps to achieve timing closure by placing blocks to minimize critical path length and reduce routing congestion. The challenge is to create a floorplan with 
good area efficiency and a small footprint, while leaving sufficient area for routing. Similarly, design planning supports pattern-based power planning, including low-power 
design techniques that can be used in multivoltage designs. Using pattern-based power planning, you can create different voltage areas within the design and define a power plan 
strategy for each voltage area. 

The tool creates the power and ground mesh based on your specification, and it connects the macros and standard cells to the mesh. You can quickly iterate on different power plan strategies to investigate different implementations 
and select the optimal power plan. 

The IC Compiler II tool supports complete hierarchical design planning for both channeled and abutted layout styles.

### Design planning in the IC Compiler II tool provides the following features for developing hierarchical and flat designs, such as :

• Multi-Level Physical Hierarchy Floorplanning
• Advanced abstraction management for processing large designs
• Guided floorplanning with a graphical Task Manager
• Data flow analysis for macro management and placement assistance
• Fast placement of macros and standard cells
• Pattern-based power planning
• Power network description using UPF
• Virtual in-place timing optimization
• Pin placement and bus bundling
• Timing budgeting


### Milkyway Reference Libraries

Information is stored in “views”, for example:

* CEL: The full layout view
* FRAM: The abstract view used for P&R
* LM: Logic Model with Timing and Power info (optional*)

(Optional) here means that the logical libraries do not have to be stored within the Milkyway library structure, but can be located anywhere else. IC Compiler only reads logical libraries (.db) specified through the link_library
variable.


### Technology File (.tf file)

Tech File is unique to each technology.

Contains metal layer technology parameters like :

* Number and name designations for each layer/via
* Dielectric constant for technology
* Physical and electrical characteristics of each layer/via
* Design rules for each layer/Via (Minimum wire widths and wire-to-wire spacing, etc.)
* Units and precision for electrical units
* Colors and patterns of layers for display

Example of a Technology File:

```
Technology {
dielectric = 3.7
unitTimeName = "ns"
timePrecision = 1000
unitLengthName = "micron"
lengthPrecision = 1000
gridResolution = 5
unitVoltageName = "v"
}
...
Layer "m1" {
layerNumber = 16
maskName = "metal1"
pitch = 0.56
defaultWidth = 0.23
minWidth = 0.23
minSpacing = 0.23
```


### Flow

![icc design planning flow](https://user-images.githubusercontent.com/83152452/190413963-65903c08-7ec9-4411-ace0-0ae4febb736e.png)

If the design contains black boxes or the netlist is dirty, use the read_mw_verilog command in place of import_designs. 
Also include adding of power pads (VSS,VDD) and insertion of pad fillers.


### Hierarchical Design Planning Flow

The hierarchical design planning flow provides an efficient approach for managing large designs. By dividing the design into multiple blocks, different design teams can work 
on different blocks in parallel, from RTL through physical implementation. Working with smaller blocks and using multiply instantiated blocks can reduce overall runtime.
Consider using a hierarchical methodology in the following scenarios:

• The design is large, complex, and requires excessive computing resources to process the design in a flat form.

• You anticipate problems that might delay the delivery of some blocks and might cause the schedule to slip. A robust hierarchical methodology accommodates late design changes to individual blocks while maintaining minimal disruption to the design 
schedule.

• The design contains hard intellectual property (IP) macros such as RAMs, or the design was previously implemented and can be converted and reused.

After the initial design netlist is generated in Design Compiler topographical mode, you can use the hierarchical methodology for design planning in the IC Compiler II tool. Design 
planning is performed during the first stage of the hierarchical flow to partition the design into blocks, generate hierarchical physical design constraints, and allocate top-level timing 
budgets to lower-level physical blocks. The flow to implement a hierarchical design plan is shown in Figure below :

![hierarchical design flow](https://user-images.githubusercontent.com/83152452/190413869-a52aec73-5368-4b13-8660-158f465308bb.png)


#### Design Partitioning

After reading in the netlist and initializing the floorplan, you can determine the physical partitioning for your hierarchical design project. When deciding on the physical partitions, 
consider the following factors:

• Size
Partition your design with blocks of similar size. Small blocks should be grouped and large blocks should be divided when appropriate.

• Function
Partition your design using its functional units for verification and simulation purposes. Consider top-level connectivity and minimal block pin counts to avoid congestion and 
timing issues.

• Floorplan style
Different floorplan styles require different physical hierarchies to support them. An abutted floorplan style has no top-level logic and a channeled floorplan has either a 
small or large amount of top-level logic.

• Common hierarchy with Design Compiler topographical mode
To exchange SCANDEF information at the block level and the top level, the physical hierarchy used in Design Compiler topographical mode must also be used in the IC 
Compiler II tool.

#### Deciding on the Physical Partitions

The IC Compiler II tool provides the following features to help you decide on the physical 
partitions:

• Using the Hierarchy Browser
You can use the hierarchy browser to navigate through the design hierarchy, to examine the logic design hierarchy, and to display information about the hierarchical 
cells and logic blocks in your design. You can select the hierarchical cells, leaf cells, or other objects in layout or schematic views. The viewer provides a tree browser to help 
in understanding the design hierarchy, and information about the blocks in the design such as the utilization, number of standard cells, and so on.

• Committing Blocks
After you decide on an initial partitioning, you can commit the blocks. Blocks are committed early in the floorplanning flow, and abstract views are used to generate an 
initial floorplan and timing budgets for the design.


## Design Planning at Multiple Levels of Physical Hierarchy

Large, complex SoC designs require hierarchical layout methodologies capable of managing multiple levels of physical hierarchy at the same time. Many traditional design 
tools -- including physical planning, place and route, and other tools -- are limited to two levels of physical hierarchy: top and block. The IC Compiler II tool provides 
comprehensive support for designs with multiple levels of physical hierarchy, resulting in shorter time to results, better QoR, and higher productivity for physical design teams. Use 
the set_editability command to enable or disable specific blocks and design levels of hierarchy for planning.

![1](https://user-images.githubusercontent.com/83152452/190419795-77cbbdb9-d6a8-4678-a9c1-83d5fdb638f2.png)

The IC Compiler II tool provides support in several areas to accommodate designs with multiple levels of physical hierarchy:

### Data Model

The data model in the IC Compiler II tool has built-in support for multiple levels of physical hierarchy. Native physical hierarchy support provides significant advantages for multilevel physical hierarchy planning and implementation. 
When performing block shaping, placement, routing, timing, and other steps, the tool can quickly access the specific data relative to physical hierarchy needed to perform the function.

### Block Shaping

In a complex design with multiple levels of physical hierarchy, the block shaper needs to know the target area for each sub-chip, the aspect ratio constraints required by hard 
macro children, and any interconnect that exists at the sibling-to-sibling, parent-to-child, and child-to parent interfaces. For multi-voltage designs, the block shaper needs the target 
locations for voltage areas. These requirements add additional constraints for the shaper to manage. For multi-level physical hierarchy planning, block shaping constraints on lower 
level sub-chips must be propagated to the top level; these constraints take the form of block shaping constraints on parent sub-chips. To improve performance, the shaper does 
not need the full netlist content that exists within each sub-chip or block.

The IC Compiler II data model provides block shaping with the specific data required to accomplish these goals. For multi-voltage designs, the tool reads UPF and saves the 
power intent at the sub-chip level. The tool retrieves data from the data model to calculate targets based on natural design utilization or retrieves user-defined attributes that specify 
design targets.

### Cell and Macro Placement

After block shaping, the cell and macro placement function sees a global view of the interconnect paths and data flow at the physical hierarchy boundaries and connectivity 
to macro cells. With this information, the tool places macros for each sub-chip at each level of hierarchy. Because the tool understands the relative location requirements of 
interconnect paths at the boundaries at all levels, sufficient resources at the adjacent subchip edges are reserved to accommodate interconnect paths. The placer anticipates the 
needs of hierarchical pin placement and places macros where interconnect paths do not require significant buffering to drive signals across macros.

The placer models the external environment at the boundaries of both child and parent sub-chips by considering sub-chip shapes, locations, and the global macro placements. 
Using this information, the placer creates cell placement jobs for each sub-chip at each level of hierarchy. By delegating sub-chip placement across multiple processes, the tool 
minimizes turnaround time while maximizing the use of compute resources.

### Power Planning

For power planning, the IC Compiler II tool provides an innovative pattern-based methodology. Patterns describing construction rules -- widths, layers, and pitches required 
to form rings and meshes -- are applied to different areas of the floorplan such as voltage areas, groups of macros, and so on. Strategies associate single patterns or multiple 
patterns with areas. Given these strategy definitions, the IC Compiler II tool characterizes the power plan and automatically generates definitions of strategies for sub-chips at 
all levels. A complete power plan is generated in a distributed manner. Because the characterized strategies are written in terms of objects at each sub-chip level, power plans 
can be easily re-created to accommodate floorplan changes at any level.

![2](https://user-images.githubusercontent.com/83152452/190419827-11696e7a-e541-4213-83b0-96689d102fcb.png)


### Pin Placement

With block shapes formed, macros placed, and power routed, pin placement retrieves interface data from all levels and invokes the global router to determine the optimal 
location to place hierarchical pins. The global router recognizes physical boundaries at all levels to ensure efficient use of resources at hierarchical pin interfaces. Pins are aligned 
across multiple levels when possible. Like all IC Compiler II operations, the global router comprehends multiply instantiated blocks (MIBs) and creates routes compliant with each 
MIB instantiation. To place pins for MIBs, the pin placement algorithm determines the best pin placement that works for all instances, ensuring that the pin placement on each 
instance is identical. Additionally, pin placement creates feedthroughs for all sub-chips, including MIBs, throughout the hierarchy. The global router creates feedthroughs across 
MIBs, determines feedthrough reuse, and connects unused feedthroughs to power or ground as required.

### Timing Budgeting

The IC Compiler II tool estimates the timing at hierarchical interfaces and creates timing budgets for sub-chips. The timing budgeter in IC Compiler II creates timing constraints for
all child interface pins within the full chip, the parent and child interfaces for mid-level subchips and the primary pins at lowest level sub-chips. The entire design can proceed with 
placement and optimization concurrently and in a distributed manner.

To examine critical timing paths in the layout or perform other design planning tasks, you can interactively view, analyze, and manually edit any level of the design in a fullchip context. You can choose to view top-level only or multiple levels of hierarchy. 
When viewing multiple levels, interactive routing is performed as if the design is flat. At completion, routes are pushed into children and hierarchical pins are automatically added.


## Design Validation During Design Planning

As you proceed through the design planning flow, you can use the check_design command to validate your design and ensure that it is ready for the next design stage. 
The command performs one or more checks on your design, based on the arguments you specify. To use the check_design command to check your design, specify the command 
and the -checks option followed by one or more check keywords.

The following example performs the dp_pre_floorplan checks:
```
icc2_shell> check_design -checks {dp_pre_floorplan}
```

The list of keywords related to design planning for the -checks option is shown in the following list.

```
• dp_pre_floorplan
◦ Checks that the technology file information is correct
◦ Checks that the layer directions are set
◦ Checks that the design contains both horizontal and vertical layers
```

```
• dp_pre_create_placement_abstract
◦ Checks that the constraint mapping file specifies a UPF file for all blocks
◦ Checks that the Verilog files are in place for the outline view for blocks
```

```
• dp_pre_block_shaping
◦ Checks that the target utilization or area exists for all black boxes
◦ Checks that there is at least one block or voltage area to shape
◦ Checks that the core area and block boundaries are valid
◦ Checks that the block grid is set if the design contains multiply instantiated blocks (MIBs)
◦ Performs the multivoltage checks related to the shape_blocks command
```

Figure : Fast interactive analysis through multiple-levels of physical hierarchy and MIB

![MIB](https://user-images.githubusercontent.com/83152452/190420541-354d7763-eac1-4885-bc54-3f9f0febb176.png)

```
• dp_pre_macro_placement
◦ Checks that block shapes do not overlap
◦ Checks that blocks and voltage areas are inside the parent boundaries
◦ Performs basic placement constraint checking, such as overlapping or out-of bounds relative locations constraints, macro cell width and height that are an even multiple of the FinFET grid, and macro cell orientation
◦ Checks that each block has a logical hierarchy
◦ Checks block, voltage area, exclusive movebound, and hard movebound utilization
◦ Performs the multivoltage checks related to the create_placement command
```

```
• dp_pre_power_insertion
◦ Checks that the preferred routing direction is set for the routing layers
◦ Checks that the tracks exist for routing layers
```

Figure : Intelligent and accurate analysis for congestion and power

![power analysis](https://user-images.githubusercontent.com/83152452/190421807-a267b4d8-987f-4a86-8fdf-230361ad0ba2.png)

```
• dp_pre_pin_placement
◦ Performs pin constraint checks, including topological constraints, individual constraints, constraints propagated from individual pins, bundle pin constraints, block pin constraints, size-related constraints, pin guide and pin blockage constraints, routing guide constraints, and routing blockage constraints
◦ Checks that the routing direction of each layer in a topological constraint is consistent with the block edge constraints
◦ Checks for consistent edge directions in topological constraint pairs
◦ Checks for off-edge pins that are part of a feedthrough constraint
◦ Checks for possible overlaps with existing internal block objects such as route blockages, pin blockages, fixed pins, preroutes, and so on
◦ Runs the checks performed by the check_mib_for_pin_placement command
```

Figure : Pipeline register placement enables superior QoR for designs with complex buses

![register placements](https://user-images.githubusercontent.com/83152452/190421795-d1c68df0-56e5-4aae-ac0a-7b1b28bb3bbb.png)

```
• dp_pre_push_down
◦ Runs the checks performed by the check_mib_alignment command
```

```
• dp_pre_create_timing_abstract
◦ Checks that the constraint mapping file specifies SDC files for all blocks
```

```
• dp_pre_timing_estimation (timing abstract checks)
◦ Checks that the top and block levels have defined modes and corners
◦ Checks that the top-level modes and corners have corresponding block-level modes and corners
◦ Checks that the top level contains at least one clock, at least one scenario using a nonestimated corner, and the corner has parasitic parameters
```

```
• dp_pre_timing_estimation (placement abstract checks)
◦ Performs the pre_create_timing_abstract checks
◦ Checks whether placement abstracts exist
```

```
• dp_pre_budgeting
◦ Checks that the estimated_corner is available
◦ Performs the same checks as dp_pre_timing_estimation
```

```
• dp_floorplan_rules
◦ Checks the segment parity rule
◦ Checks the macro spacing rule
◦ Runs the checks performed by the check_finfet_grid command
```


# RVMYTH CORE

## Synthesis 

![1  dc_shell - source vsd tc](https://user-images.githubusercontent.com/83152452/190433331-796b4d65-f5e6-428c-a3ae-f52be437b3ee.png)

Here is the vsdbabysoc.tcl (Or, whichever file name you give [filename.tcl] ) script file for generating the Gate-Level Netlist as ```vsdbabysoc_gtlvl.v``` file.

```
set target_library [list /home/skandha/Tools_SNPS/Downloads_temp/SAED32_EDK/lib/stdcell_hvt/db_ccs/saed32hvt_tt0p85v25c.db /home/devipriya/VSDBabySoC/src/lib/avsdpll.db  /home/devipriya/VSDBabySoC/src/lib/avsddac.db]
set link_library [list  /home/skandha/Tools_SNPS/Downloads_temp/SAED32_EDK/lib/stdcell_hvt/db_ccs/saed32hvt_tt0p85v25c.db  /home/devipriya/VSDBabySoC/src/lib/avsdpll.db  /home/devipriya/VSDBabySoC/src/lib/avsddac.db] 
set symbol_library ""

read_file -format verilog {/home/devipriya/VSDBabySoC/src/module/vsdbabysoc.v}
read_verilog /home/devipriya/VSDBabySoC/src/module/rvmyth.v
read_verilog /home/devipriya/VSDBabySoC/src/module/clk_gate.v

read_lib -lib /home/devipriya/VSDBabySoC/src/module/avsdpll.lib
read_lib -lib /home/devipriya/VSDBabySoC/src/module/avsddac.lib

analyze -library WORK -format verilog {/home/devipriya/VSDBabySoC/src/module/vsdbabysoc.v}
elaborate vsdbabysoc -architecture verilog -library WORK
analyze {}

set_units -time ns
create_clock [get_pins {pll/CLK}] -name clk -period 10
set_max_area 8000;
set_max_fanout 5 vsdbabysoc;
set_max_transition 10 vsdbabysoc
#set_min_delay -max 10 -clock[get_clk myclk] [get_ports OUT]
set_max_delay 10 -from dac/OUT -to [get_ports OUT]

#set_input_delay[expr 0.34][all_inputs]

set_clock_latency -source 2 [get_clocks MYCLK];
set_clock_latency 1 [get_clocks MYCLK];
set_clock_uncertainty -setup 0.5 [get_clocks MYCLK];
set_clock_uncertainty -hold 0.5 [get_clocks MYCLK];

set_input_delay -max 4 -clock [get_clocks MYCLK] [get_ports VCO_IN];
set_input_delay -max 4 -clock [get_clocks MYCLK] [get_ports ENb_CP];
set_input_delay -min 1 -clock [get_clocks MYCLK] [get_ports VCO_IN];
set_input_delay -min 1 -clock [get_clocks MYCLK] [get_ports ENb_CP];

set_input_transition -max 0.4 [get_ports ENb_CP];
set_input_transition -max 0.4 [get_ports VCO_IN];
set_input_transition -min 0.1 [get_ports ENb_CP];
set_input_transition -min 0.1 [get_ports VCO_IN];

set_load -max 0.5 [get_ports OUT];
set_load -min 0.5 [get_ports OUT];

check_design

compile_ultra

file mkdir report
write -hierarchy -format verilog -output /home/devipriya/VSDBabySoC/src/module/report/vsdbabysoc_gtlvl.v
write_sdc -nosplit -version 2.0 /home/devipriya/VSDBabySoC/src/module/report/vsdbabysoc.sdc
report_area -hierarchy > /home/devipriya/VSDBabySoC/src/module/report/vsdbabysoc.area
report_timing > /home/devipriya/VSDBabySoC/src/module/report/vsdbabysoc.timing
report_power -hierarchy > /home/devipriya/VSDBabySoC/src/module/report/vsdbabysoc.power

gui_start
```

Running this in ```dc_shell``` generates the vsdbabysoc_gtlvl.v file that is added in the repository.


## Schematic

Once the Synthesis flow is run without errors, the following block is generated as shown below:

![rvmyth_schematic-1](https://user-images.githubusercontent.com/83152452/190432284-a4bf6ec9-9d31-44d6-9d69-6deb1cc28042.png)

![rvmyth_schematic-2](https://user-images.githubusercontent.com/83152452/190432336-a41d7efc-785e-442c-bfcf-d7ea7ec44fcb.png)

![rvmyth_schematic-3](https://user-images.githubusercontent.com/83152452/190432416-d17c43d1-927b-440f-b3fe-954ce7981967.png)

![rvmyth_schematic-4](https://user-images.githubusercontent.com/83152452/190432447-cb804800-d9f8-4c9b-aced-889220563bb4.png)


## Performing Physical Design

Here is the ```top.tcl``` script file that is run in the ```icc2_shell``` that generates the Final Layout

```
source -echo /home/devipriya/rvmyth_45nm/icc2_workshop_collaterals/standaloneFlow/icc2_common_setup.tcl
source -echo /home/devipriya/rvmyth_45nm/icc2_workshop_collaterals/standaloneFlow/icc2_dp_setup.tcl
if {[file exists ${WORK_DIR}/$DESIGN_LIBRARY]} {
   file delete -force ${WORK_DIR}/${DESIGN_LIBRARY}
}
###---NDM Library creation---###
set create_lib_cmd "create_lib ${WORK_DIR}/$DESIGN_LIBRARY"
if {[file exists [which $TECH_FILE]]} {
   lappend create_lib_cmd -tech $TECH_FILE ;# recommended
} elseif {$TECH_LIB != ""} {
   lappend create_lib_cmd -use_technology_lib $TECH_LIB ;# optional
}
lappend create_lib_cmd -ref_libs $REFERENCE_LIBRARY
puts "RM-info : $create_lib_cmd"
eval ${create_lib_cmd}

###---Read Synthesized Verilog---###
if {$DP_FLOW == "hier" && $BOTTOM_BLOCK_VIEW == "abstract"} {
   # Read in the DESIGN_NAME outline.  This will create the outline
   puts "RM-info : Reading verilog outline (${VERILOG_NETLIST_FILES})"
   read_verilog_outline -design ${DESIGN_NAME}/${INIT_DP_LABEL_NAME} -top ${DESIGN_NAME} ${VERILOG_NETLIST_FILES}
   } else {
   # Read in the full DESIGN_NAME.  This will create the DESIGN_NAME view in the database
   puts "RM-info : Reading full chip verilog (${VERILOG_NETLIST_FILES})"
   read_verilog -design ${DESIGN_NAME}/${INIT_DP_LABEL_NAME} -top ${DESIGN_NAME} ${VERILOG_NETLIST_FILES}
}

## Technology setup for routing layer direction, offset, site default, and site symmetry.
#  If TECH_FILE is specified, they should be properly set.
#  If TECH_LIB is used and it does not contain such information, then they should be set here as well.
if {$TECH_FILE != "" || ($TECH_LIB != "" && !$TECH_LIB_INCLUDES_TECH_SETUP_INFO)} {
   if {[file exists [which $TCL_TECH_SETUP_FILE]]} {
      puts "RM-info : Sourcing [which $TCL_TECH_SETUP_FILE]"
      source -echo $TCL_TECH_SETUP_FILE
   } elseif {$TCL_TECH_SETUP_FILE != ""} {
      puts "RM-error : TCL_TECH_SETUP_FILE($TCL_TECH_SETUP_FILE) is invalid. Please correct it."
   }
}

# Specify a Tcl script to read in your TLU+ files by using the read_parasitic_tech command
if {[file exists [which $TCL_PARASITIC_SETUP_FILE]]} {
   puts "RM-info : Sourcing [which $TCL_PARASITIC_SETUP_FILE]"
   source -echo $TCL_PARASITIC_SETUP_FILE
} elseif {$TCL_PARASITIC_SETUP_FILE != ""} {
   puts "RM-error : TCL_PARASITIC_SETUP_FILE($TCL_PARASITIC_SETUP_FILE) is invalid. Please correct it."
} else {
   puts "RM-info : No TLU plus files sourced, Parastic library containing TLU+ must be included in library reference list"
}

###---Routing settings---###
## Set max routing layer
if {$MAX_ROUTING_LAYER != ""} {set_ignored_layers -max_routing_layer $MAX_ROUTING_LAYER}
## Set min routing layer
if {$MIN_ROUTING_LAYER != ""} {set_ignored_layers -min_routing_layer $MIN_ROUTING_LAYER}

####################################
# Check Design: Pre-Floorplanning
####################################
if {$CHECK_DESIGN} {
   redirect -file ${REPORTS_DIR_INIT_DP}/check_design.pre_floorplan     {check_design -ems_database check_design.pre_floorplan.ems -checks dp_pre_floorplan}
}

####################################
# Floorplanning
####################################
initialize_floorplan -core_utilization 0.07
#initialize_floorplan -honor_pad_limit 
save_lib -all

####################################
## PG Pin connections
#####################################
puts "RM-info : Running connect_pg_net -automatic on all blocks"
connect_pg_net -automatic -all_blocks
save_block -force       -label ${PRE_SHAPING_LABEL_NAME}
save_lib -all

####################################
### Place IO
######################################
if {[file exists [which $TCL_PAD_CONSTRAINTS_FILE]]} {
   puts "RM-info : Loading TCL_PAD_CONSTRAINTS_FILE file ($TCL_PAD_CONSTRAINTS_FILE)"
   source -echo $TCL_PAD_CONSTRAINTS_FILE

   puts "RM-info : running place_io"
   place_io
}
set_attribute [get_cells -hierarchical -filter pad_cell==true] status fixed

save_block -hier -force   -label ${PLACE_IO_LABEL_NAME}
save_lib -all

####################################
### Memory Placement
######################################
if [sizeof_collection [get_cells -hier -filter is_hard_macro==true -quiet]] {
   set all_macros [get_cells -hier -filter is_hard_macro==true]
   # Check top-level
   report_macro_constraints -allowed_orientations -preferred_location -alignment_grid -align_pins_to_tracks $all_macros > $REPORTS_DIR_PLACEMENT/report_macro_constraints.rpt
}

###---Place Macro at user defined locations---### 
if {$USE_INCREMENTAL_DATA && [file exists $OUTPUTS_DIR/preferred_macro_locations.tcl]} {
source $OUTPUTS_DIR/preferred_macro_locations.tcl
}

####################################
# Configure placement
####################################
if {$DISTRIBUTED} {
   set HOST_OPTIONS "-host_options block_script"
} else {
   set HOST_OPTIONS ""
}
set CMD_OPTIONS "-floorplan $HOST_OPTIONS"

########################################
## Read parasitic files
########################################
if {[file exists [which $TCL_PARASITIC_SETUP_FILE]]} {
   puts "RM-info : Sourcing [which $TCL_PARASITIC_SETUP_FILE]"
   source -echo $TCL_PARASITIC_SETUP_FILE
    } elseif {$TCL_PARASITIC_SETUP_FILE != ""} {
   puts "RM-error : TCL_PARASITIC_SETUP_FILE($TCL_PARASITIC_SETUP_FILE) is invalid. Please correct it."
    } else {
   puts "RM-info : No TLU plus files sourced, Parastic library containing TLU+ must be included in library reference list"
    }

########################################
## Read constraints
########################################
if {[file exists $TCL_MCMM_SETUP_FILE]} {
   puts "RM-info : Loading TCL_MCMM_SETUP_FILE ($TCL_MCMM_SETUP_FILE)"
   source -echo $TCL_MCMM_SETUP_FILE
   } else {
   puts "RM-error : Cannot find TCL_MCMM_SETUP_FILE ($TCL_MCMM_SETUP_FILE)"
   error
   }
#set CMD_OPTIONS "$CMD_OPTIONS -timing_driven"
set plan.place.auto_generate_blockages true
legalize_placement -cells [get_cells \
-design [current_block] {intadd_0/U31 intadd_0/U30 intadd_0/U29 intadd_0/U28 intadd_0/U27 gen_clkP_CPU_rs2_valid_a2 gen_clkP_CPU_rs1_valid_a2 gen_clkP_CPU_rd_valid_a5 gen_clkP_CPU_rd_valid_a4 gen_clkP_CPU_rd_valid_a3 gen_clkP_CPU_rd_valid_a2 gen_clkP_CPU_dmem_rd_en_a5 U7801 U7800 U7799 U7798 U7797 U7796 U7795 U7794 U7793 U7792 U7791 U7790 U7789 U7788 U7787 U7786 U7785 U7784 U7783 U7782 U7781 U7780 U7779 U7778 U7777 U7776 U7775 U7774 U7773 U7772 U7771 U7770 U7769 U7768 U7767 U7766 U7765 U7764 U7763 U7762 U7761 U7760 U7759 U7758 U7757 U7756 U7755 U7754 U7753 U7752 U7751 U7750 U7749 U7748 U7747 U7746 U7745 U7744 U7743 U7742 U7741 U7740 U7739 U7738 U7737 U7736 U7735 U7734 U7733 U7732 U7731 U7730 U7729 U7728 U7727 U7726 U7725 U7724 U7723 U7722 U7721 U7720 U7719 U7718 U7717 U7716 U7715 U7714 U7713 U7712 U7711 U7710 U7709 U7708 U7707 U7706 U7705 U7704 U7703 U7702 U7701 U7700 U7699 U7698 U7697 U7696 U7695 U7694 U7693 U7692 U7690 U7689 U7688 U7687 U7686 U7685 U7684 U7683 U7682 U7681 U7680 U7679 U7678 U7677 U7676 U7675 U7674 U7673 U7672 U7671 U7670 U7669 U7668 U7667 U7666 U7665 U7664 U7663 U7662 U7661 U7660 U7659 U7658 U7657 U7656 U7655 U7654 U7653 U7652 U7651 U7650 U7649 U7648 U7647 U7646 U7645 U7644 U7643 U7642 U7641 U7640 U7639 U7638 U7637 U7636 U7635 U7634 U7633 U7632 U7631 U7630 U7629 U7628 U7627 U7626 U7625 U7624 U7623 U7622 U7621 U7620 U7619 U7618 U7617 U7616 U7615 U7614 U7613 U7612 U7611 U7610 U7609 U7608 U7607 U7606 U7605 U7604 U7603 U7602 U7601 U7600 U7599 U7598 U7597 U7596 U7595 U7594 U7593 U7592 U7591 U7590 U7589 U7588 U7587 U7586 U7585 U7584 U7583 U7582 U7581 U7580 U7579 U7578 U7577 U7576 U7575 U7574 U7573 U7572 U7571 U7570 U7569 U7568 U7567 U7566 U7565 U7564 U7563 U7562 U7561 U7560 U7559 U7558 U7557 U7556 U7555 U7554 U7553 U7552 U7551 U7550 U7549 U7548 U7547 U7546 U7545 U7544 U7543 U7542 U7541 U7540 U7539 U7538 U7537 U7536 U7535 U7534 U7533 U7532 U7531 U7530 U7529 U7528 U7527 U7526 U7525 U7524 U7523 U7522 U7521 U7520 U7519 U7518 U7517 U7516 U7515 U7514 U7513 U7512 U7511 U7510 U7509 U7508 U7507 U7506 U7505 U7504 U7503 U7502 U7501 U7500 U7499 U7498 U7497 U7496 U7495 U7494 U7493 U7492 U7491 U7490 U7489 U7488 U7487 U7486 U7485 U7484 U7483 U7482 U7481 U7480 U7479 U7478 U7477 U7476 U7475 U7474 U7473 U7472 U7471 U7470 U7469 U7468 U7467 U7466 U7465 U7464 U7463 U7462 U7461 U7460 U7459 U7458 U7457 U7456 U7455 U7454 U7453 U7452 U7451 U7450 U7449 U7448 U7447 U7446 U7445 U7444 U7443 U7442 U7441 U7440 U7439 U7438 U7437 U7436 U7435 U7434 U7433 U7432 U7431 U7430 U7429 U7428 U7427 U7426 U7425 U7424 U7423 U7422 U7421 U7420 U7419 U7418 U7417 U7416 U7415 U7414 U7413 U7412 U7411 U7410 U7409 U7408 U7407 U7406 U7405 U7404 U7403 U7402 U7401 U7400 U7399 U7398 U7397 U7396 U7395 U7394 U7393 U7392 U7391 U7390 U7389 U7388 U7387 U7386 U7385 U7384 U7383 U7382 U7381 U7380 U7379 U7378 U7377 U7376 U7375 U7374 U7373 U7372 U7371 U7370 U7369 U7368 U7367 U7366 U7365 U7364 U7363 U7362 U7361 U7360 U7359 U7358 U7357 U7356 U7355 U7354 U7353 U7352 U7351 U7350 U7349 U7348 U7347 U7346 U7345 U7344 U7343 U7342 U7341 U7340 U7339 U7338 U7337 U7336 U7335 U7334 U7333 U7332 U7331 U7330 U7329 U7328 U7327 U7326 U7325 U7324 U7323 U7322 U7321 U7320 U7319 U7318 U7317 U7316 U7315 U7314 U7313 U7312 U7311 U7310 U7309 U7308 U7307 U7306 U7305 U7304 U7303 U7302 U7301 U7300 U7299 U7298 U7297 U7296 U7295 U7294 U7293 U7292 U7291 U7290 U7289 U7288 U7287 U7286 U7285 U7284 U7283 U7282 U7281 U7280 U7279 U7278 U7277 U7276 U7275 U7274 U7273 U7272 U7271 U7270 U7269 U7268 U7267 U7266 U7265 U7264 U7263 U7262 U7261 U7260 U7259 U7258 U7257 U7256 U7255 U7254 U7253 U7252 U7251 U7250 U7249 U7248 U7247 U7246 U7245 U7244 U7243 U7242 U7241 U7240 U7239 U7238 U7237 U7236 U7235 U7234 U7233 U7232 U7231 U7230 U7229 U7228 U7227 U7226 U7225 U7224 U7223 U7222 U7221 U7220 U7219 U7218 U7217 U7216 U7215 U7214 U7213 U7212 U7211 U7210 U7209 U7208 U7207 U7206 U7205 U7204 U7203 U7202 U7201 U7200 U7199 U7198 U7197 U7196 U7195 U7194 U7193 U7192 U7191 U7190 U7189 U7188 U7187 U7186 U7185 U7184 U7183 U7182 U7181 U7180 U7179 U7178 U7177 U7176 U7175 U7174 U7173 U7172 U7171 U7170 U7169 U7168 U7167 U7166 U7165 U7164 U7163 U7162 U7161 U7160 U7159 U7158 U7157 U7156 U7155 U7154 U7153 U7152 U7151 U7150 U7149 U7148 U7147 U7146 U7145 U7144 U7143 U7142 U7141 U7140 U7139 U7138 U7137 U7136 U7135 U7134 U7133 U7132 U7131 U7130 U7129 U7128 U7127 U7126 U7125 U7124 U7123 U7122 U7121 U7120 U7119 U7118 U7117 U7116 U7115 U7114 U7113 U7112 U7111 U7110 U7109 U7108 U7107 U7106 U7105 U7104 U7103 U7102 U7101 U7100 U7099 U7098 U7097 U7096 U7095 U7094 U7093 U7092 U7091 U7090 U7089 U7088 U7087 U7086 U7085 U7084 U7083 U7082 U7081 U7080 U7079 U7078 U7077 U7076 U7075 U7074 U7073 U7072 U7071 U7070 U7069 U7068 U7067 U7066 U7065 U7064 U7063 U7062 U7061 U7060 U7059 U7058 U7057 U7056 U7055 U7054 U7053 U7052 U7051 U7050 U7049 U7048 U7047 U7046 U7045 U7044 U7043 U7042 U7041 U7040 U7039 U7038 U7037 U7036 U7035 U7034 U7033 U7032 U7031 U7030 U7029 U7028 U7027 U7026 U7025 U7024 U7023 U7022 U5220 U5886 U5219 U5885 U5218 U5884 U5217 U5883 U5216 U5882 U5215 U5881 U5214 U5880 U5213 U5879 U5212 U5878 U5211 U5877 U5210 U5876 U5209 U5875 U5208 U5874 U5207 U5873 U5206 U5872 U5205 U5871 U5204 U5870 U5203 U5869 U5202 U5868 U5201 U5867 U5200 U5866 U5199 U5865 U5198 U5864 U5197 U5863 U5196 U5862 U5195 U5861 U5194 U5860 U5193 U5859 U5192 U5858 U5191 U5857 U5190 U5856 U5189 U5855 U5188 U5854 U5187 U5853 U5186 U5852 U5185 U5851 U5184 U5850 U5183 U5849 U5182 U5848 {CPU_Xreg_value_a4_reg[9][22]} U5181 U5847 {CPU_Xreg_value_a4_reg[8][22]} U5180 U5846 {CPU_Xreg_value_a4_reg[7][22]} U5179 U5845 {CPU_Xreg_value_a4_reg[6][22]} U5178 U5844 {CPU_Xreg_value_a4_reg[5][22]} U5177 U5843 {CPU_Xreg_value_a4_reg[4][22]} U5176 U5842 {CPU_Xreg_value_a4_reg[3][22]} U5175 U5841 {CPU_Xreg_value_a4_reg[2][22]} U5174 U5840 {CPU_Xreg_value_a4_reg[1][22]} U5173 U5839 {CPU_src1_value_a3_reg[21]} U5172 U5838 {CPU_src2_value_a3_reg[21]} U5171 U5837 {CPU_Xreg_value_a4_reg[16][21]} U5170 U5836 {CPU_Xreg_value_a4_reg[17][21]} U5169 U5835 {CPU_Xreg_value_a4_reg[18][21]} U5168 U5834 {CPU_Xreg_value_a4_reg[19][21]} U5167 U5833 {CPU_Xreg_value_a4_reg[20][21]} U5166 {CPU_Xreg_value_a4_reg[21][21]} U5165 {CPU_Xreg_value_a4_reg[22][21]} U5164 {CPU_Xreg_value_a4_reg[23][21]} U5163 {CPU_Xreg_value_a4_reg[24][21]} U5162 {CPU_Xreg_value_a4_reg[25][21]} U5161 {CPU_Xreg_value_a4_reg[26][21]} U5160 {CPU_Xreg_value_a4_reg[27][21]} U5159 {CPU_Xreg_value_a4_reg[28][21]} U5158 {CPU_Xreg_value_a4_reg[29][21]} U5157 {CPU_Xreg_value_a4_reg[30][21]} U5156 {CPU_Xreg_value_a4_reg[31][21]} U5155 {CPU_Xreg_value_a4_reg[15][21]} U5154 {CPU_Xreg_value_a4_reg[14][21]} U5153 {CPU_Xreg_value_a4_reg[13][21]} U5152 {CPU_Xreg_value_a4_reg[12][21]} U5151 {CPU_Xreg_value_a4_reg[11][21]} U5150 {CPU_Xreg_value_a4_reg[10][21]} U5149 {CPU_Xreg_value_a4_reg[9][21]} U5148 {CPU_Xreg_value_a4_reg[8][21]} U5147 {CPU_Xreg_value_a4_reg[7][21]} U5146 {CPU_Xreg_value_a4_reg[6][21]} U5145 {CPU_Xreg_value_a4_reg[5][21]} U5144 {CPU_Xreg_value_a4_reg[4][21]} U5143 {CPU_Xreg_value_a4_reg[3][21]} U5142 {CPU_Xreg_value_a4_reg[2][21]} U5141 {CPU_Xreg_value_a4_reg[1][21]} U5140 {CPU_src1_value_a3_reg[20]} U5139 {CPU_src2_value_a3_reg[20]} U5138 {CPU_Xreg_value_a4_reg[16][20]} U5137 {CPU_Xreg_value_a4_reg[17][20]} U5136 {CPU_Xreg_value_a4_reg[18][20]} U5135 {CPU_Xreg_value_a4_reg[19][20]} U5134 {CPU_Xreg_value_a4_reg[20][20]} U5133 {CPU_Xreg_value_a4_reg[21][20]} U5132 {CPU_Xreg_value_a4_reg[22][20]} U5131 {CPU_Xreg_value_a4_reg[23][20]} U5130 {CPU_Xreg_value_a4_reg[24][20]} U5129 {CPU_Xreg_value_a4_reg[25][20]} U5128 U5127 U5126 U5125 U5124 U5123 U5122 U5121 U5120 U5119 U5118 U5117 U5116 U5115 U5114 U5113 U5112 U5111 U5110 U5109 U5055 U5108 U5054 U5107 U1151 U5106 U1137 U5092 {OUT_reg[9]} U5093 {OUT_reg[8]} U5094 {OUT_reg[7]} U5095 {OUT_reg[6]} U5096 {OUT_reg[5]} U5097 {OUT_reg[4]} U5098 {OUT_reg[3]} U5099 {OUT_reg[2]} U5100 {OUT_reg[1]} U5101 {OUT_reg[0]} CPU_valid_taken_br_a5_reg U5224 CPU_valid_taken_br_a4_reg U5223 CPU_valid_load_a5_reg U5102 CPU_valid_load_a4_reg {CPU_src2_value_a3_reg[31]} U5832 U6498 {CPU_src2_value_a3_reg[30]} {CPU_src2_value_a3_reg[29]} {CPU_Xreg_value_a4_reg[21][9]} U6631 {CPU_src2_value_a3_reg[28]} {CPU_Xreg_value_a4_reg[20][8]} U6598 U5462 U5429 {CPU_src2_value_a3_reg[18]} {CPU_src2_value_a3_reg[12]} U6736 {CPU_src2_value_a3_reg[6]} U6535 {CPU_Xreg_value_a4_reg[4][10]} {CPU_Xreg_value_a4_reg[5][11]} U6676 {CPU_src2_value_a3_reg[3]} U5799 U6465 DP_OP_214J1_122_1213/U28 {CPU_Xreg_value_a4_reg[25][14]} U6792 {CPU_src2_value_a3_reg[2]} U5058 {CPU_Xreg_value_a4_reg[23][15]} U6827 {CPU_src2_value_a3_reg[1]} {CPU_src2_value_a3_reg[0]} {CPU_src1_value_a3_reg[31]} U6499 {CPU_src1_value_a3_reg[30]} {CPU_src1_value_a3_reg[29]} {CPU_Xreg_value_a4_reg[20][9]} U6632 {CPU_src1_value_a3_reg[28]} {CPU_Xreg_value_a4_reg[19][8]} U6599 U5463 U5430 {CPU_src1_value_a3_reg[18]} {CPU_src1_value_a3_reg[12]} U6737 {CPU_src1_value_a3_reg[6]} U6536 {CPU_src1_value_a3_reg[5]} U6502 {CPU_src1_value_a3_reg[4]} U6501 {CPU_src1_value_a3_reg[3]} U5800 U6466 {CPU_src1_value_a3_reg[2]} DP_OP_214J1_122_1213/U3 {CPU_Xreg_value_a4_reg[14][15]} U6817 {CPU_src1_value_a3_reg[1]} U5083 U6852 {CPU_src1_value_a3_reg[0]} U5230 {CPU_rs2_a2_reg[4]} U5231 {CPU_rs2_a2_reg[3]} U5232 {CPU_rs2_a2_reg[2]} U5233 {CPU_rs2_a2_reg[1]} U5234 {CPU_rs2_a2_reg[0]} U5225 {CPU_rs1_a2_reg[3]} U5226 {CPU_rs1_a2_reg[2]} U5227 {CPU_rs1_a2_reg[1]} {CPU_Xreg_value_a4_reg[5][10]} U5287 {CPU_result_a4_reg[2]} U5222 CPU_reset_a2_reg CPU_reset_a1_reg U5105 CPU_rd_valid_a4_reg U5104 CPU_rd_valid_a3_reg U5103 CPU_rd_valid_a2_reg {CPU_rd_a5_reg[4]} {CPU_rd_a5_reg[3]} {CPU_rd_a5_reg[2]} {CPU_rd_a5_reg[1]} {CPU_rd_a5_reg[0]} {CPU_rd_a4_reg[4]} {CPU_rd_a4_reg[3]} {CPU_rd_a4_reg[2]} {CPU_rd_a4_reg[1]} {CPU_rd_a4_reg[0]} {CPU_rd_a3_reg[4]} {CPU_rd_a3_reg[3]} {CPU_rd_a3_reg[2]} {CPU_rd_a3_reg[1]} {CPU_rd_a3_reg[0]} {CPU_rd_a2_reg[4]} {CPU_rd_a2_reg[3]} {CPU_rd_a2_reg[2]} {CPU_rd_a2_reg[1]} {CPU_rd_a2_reg[0]} {CPU_pc_a2_reg[5]} {CPU_pc_a2_reg[4]} {CPU_pc_a2_reg[3]} {CPU_pc_a2_reg[2]} {CPU_pc_a2_reg[1]} {CPU_pc_a2_reg[0]} {CPU_pc_a1_reg[5]} {CPU_pc_a1_reg[4]} {CPU_pc_a1_reg[3]} {CPU_pc_a1_reg[2]} {CPU_pc_a1_reg[1]} {CPU_pc_a1_reg[0]} U5286 CPU_is_sub_a3_reg U5285 CPU_is_sub_a2_reg CPU_is_blt_a3_reg CPU_is_blt_a2_reg CPU_is_addi_a3_reg CPU_is_addi_a2_reg U5229 CPU_is_add_a3_reg U5228 CPU_is_add_a2_reg U5236 {CPU_imm_a3_reg[31]} U5238 {CPU_imm_a3_reg[30]} U5240 {CPU_imm_a3_reg[29]} U5242 {CPU_imm_a3_reg[28]} U5244 {CPU_imm_a3_reg[27]} U5246 {CPU_imm_a3_reg[26]} U5248 {CPU_imm_a3_reg[25]} U5250 {CPU_imm_a3_reg[24]} U5252 {CPU_imm_a3_reg[23]} U5254 {CPU_imm_a3_reg[22]} U5256 {CPU_imm_a3_reg[21]} U5258 {CPU_imm_a3_reg[20]} U5260 {CPU_imm_a3_reg[19]} U5262 {CPU_imm_a3_reg[18]} U5264 {CPU_imm_a3_reg[17]} U5266 {CPU_imm_a3_reg[16]} U5268 {CPU_imm_a3_reg[15]} U5270 {CPU_imm_a3_reg[14]} U5272 {CPU_imm_a3_reg[13]} U5274 {CPU_imm_a3_reg[12]} U5276 {CPU_imm_a3_reg[11]} U5278 {CPU_imm_a3_reg[10]} U5280 {CPU_imm_a3_reg[9]} U5282 {CPU_imm_a3_reg[8]} {CPU_imm_a3_reg[7]} {CPU_imm_a3_reg[6]} {CPU_imm_a3_reg[5]} {CPU_imm_a3_reg[4]} {CPU_imm_a3_reg[3]} U5284 {CPU_imm_a3_reg[2]} {CPU_imm_a3_reg[1]} U5221 {CPU_imm_a3_reg[0]} U5235 {CPU_imm_a2_reg[31]} U5237 {CPU_imm_a2_reg[30]} U5239 {CPU_imm_a2_reg[29]} U5241 {CPU_imm_a2_reg[28]} U5243 {CPU_imm_a2_reg[27]} U5245 {CPU_imm_a2_reg[26]} U5247 {CPU_imm_a2_reg[25]} U5249 {CPU_imm_a2_reg[24]} U5251 {CPU_imm_a2_reg[23]} U5253 {CPU_imm_a2_reg[22]} U5255 {CPU_imm_a2_reg[21]} U5257 {CPU_imm_a2_reg[20]} U5259 {CPU_imm_a2_reg[19]} U5261 {CPU_imm_a2_reg[18]} U5263 {CPU_imm_a2_reg[17]} U5265 {CPU_imm_a2_reg[16]} U5267 {CPU_imm_a2_reg[15]} U5269 {CPU_imm_a2_reg[14]} U5271 {CPU_imm_a2_reg[13]} U5273 {CPU_imm_a2_reg[12]} U5275 {CPU_imm_a2_reg[11]} U5277 {CPU_imm_a2_reg[10]} U5279 {CPU_imm_a2_reg[9]} U5281 {CPU_imm_a2_reg[8]} {CPU_imm_a2_reg[7]} {CPU_imm_a2_reg[6]} {CPU_imm_a2_reg[5]} {CPU_imm_a2_reg[4]} {CPU_imm_a2_reg[3]} U5283 {CPU_imm_a2_reg[2]} {CPU_imm_a2_reg[1]} {CPU_imm_a2_reg[0]} {CPU_imem_rd_addr_a1_reg[3]} {CPU_imem_rd_addr_a1_reg[2]} {CPU_imem_rd_addr_a1_reg[1]} {CPU_imem_rd_addr_a1_reg[0]} {CPU_dmem_rd_data_a5_reg[3]} U5766 DP_OP_214J1_122_1213/U27 {CPU_Xreg_value_a4_reg[24][14]} U6793 {CPU_dmem_rd_data_a5_reg[2]} U5059 {CPU_Xreg_value_a4_reg[22][15]} U6828 {CPU_dmem_rd_data_a5_reg[1]} {CPU_dmem_rd_data_a5_reg[0]} U6500 {CPU_br_tgt_pc_a3_reg[5]} {CPU_br_tgt_pc_a3_reg[4]} {CPU_br_tgt_pc_a3_reg[3]} {CPU_br_tgt_pc_a3_reg[2]} {CPU_br_tgt_pc_a3_reg[1]} {CPU_br_tgt_pc_a3_reg[0]} {CPU_Xreg_value_a5_reg[14][6]} U6517 {CPU_Xreg_value_a4_reg[27][10]} U6658 {CPU_Xreg_value_a5_reg[14][3]} U5774 {CPU_Xreg_value_a5_reg[14][2]} DP_OP_214J1_122_1213/U19 {CPU_Xreg_value_a4_reg[16][14]} U6801 {CPU_Xreg_value_a5_reg[14][1]} U5082 U6851 {CPU_Xreg_value_a5_reg[14][0]} {CPU_Xreg_value_a4_reg[31][31]} U5816 U6482 {CPU_Xreg_value_a4_reg[31][30]} U6648 {CPU_Xreg_value_a4_reg[31][29]} {CPU_Xreg_value_a4_reg[11][9]} U6615 {CPU_Xreg_value_a4_reg[31][28]} {CPU_Xreg_value_a4_reg[12][8]} U6582 U5446 {CPU_Xreg_value_a4_reg[31][6]} U6519 {CPU_Xreg_value_a4_reg[25][10]} U6660 {CPU_Xreg_value_a4_reg[31][3]} U5776 {CPU_Xreg_value_a4_reg[31][2]} DP_OP_214J1_122_1213/U17 {CPU_src1_value_a3_reg[14]} U6803 {CPU_Xreg_value_a4_reg[31][1]} {CPU_Xreg_value_a4_reg[31][0]} {CPU_Xreg_value_a4_reg[30][31]} U5817 U6483 {CPU_Xreg_value_a4_reg[30][30]} {CPU_Xreg_value_a4_reg[30][29]} {CPU_Xreg_value_a4_reg[12][9]} U6616 {CPU_Xreg_value_a4_reg[30][28]} {CPU_Xreg_value_a4_reg[13][8]} U6583 U5447 {CPU_Xreg_value_a4_reg[30][6]} U6520 {CPU_Xreg_value_a4_reg[24][10]} U6661 {CPU_Xreg_value_a4_reg[30][3]} U5777 {CPU_Xreg_value_a4_reg[30][2]} DP_OP_214J1_122_1213/U16 {CPU_Xreg_value_a4_reg[1][15]} U6804 {CPU_Xreg_value_a4_reg[30][1]} U5084 {CPU_Xreg_value_a4_reg[30][0]} {CPU_Xreg_value_a4_reg[29][31]} U5818 U6484 {CPU_Xreg_value_a4_reg[29][30]} {CPU_Xreg_value_a4_reg[29][29]} {CPU_Xreg_value_a4_reg[13][9]} U6617 {CPU_Xreg_value_a4_reg[29][28]} {CPU_Xreg_value_a4_reg[14][8]} U6584 U5448 {CPU_Xreg_value_a4_reg[29][6]} U6521 {CPU_Xreg_value_a4_reg[23][10]} U6662 {CPU_Xreg_value_a4_reg[29][3]} U5778 {CPU_Xreg_value_a4_reg[29][2]} {CPU_Xreg_value_a4_reg[29][1]} U5068 {CPU_Xreg_value_a4_reg[1][16]} U6837 {CPU_Xreg_value_a4_reg[29][0]} {CPU_Xreg_value_a4_reg[28][31]} U5819 U6485 {CPU_Xreg_value_a4_reg[28][30]} {CPU_Xreg_value_a4_reg[28][29]} {CPU_Xreg_value_a4_reg[14][9]} U6618 {CPU_Xreg_value_a4_reg[28][28]} {CPU_Xreg_value_a5_reg[14][8]} U6585 U5449 {CPU_Xreg_value_a4_reg[28][6]} U6522 {CPU_Xreg_value_a4_reg[22][10]} U6663 {CPU_Xreg_value_a4_reg[28][3]} U5779 U6445 {CPU_Xreg_value_a4_reg[28][2]} {CPU_Xreg_value_a4_reg[28][1]} U5085 {CPU_Xreg_value_a4_reg[28][0]} {CPU_Xreg_value_a4_reg[27][31]} U5820 U6486 {CPU_Xreg_value_a4_reg[27][30]} {CPU_Xreg_value_a4_reg[27][29]} {CPU_Xreg_value_a5_reg[14][9]} U6619 {CPU_Xreg_value_a4_reg[27][28]} {CPU_Xreg_value_a4_reg[15][8]} U6586 U5450 {CPU_Xreg_value_a4_reg[27][6]} U6523 {CPU_Xreg_value_a4_reg[21][10]} U6664 {CPU_Xreg_value_a4_reg[27][3]} U5780 U6446 {CPU_Xreg_value_a4_reg[27][2]} DP_OP_214J1_122_1213/U15 {CPU_Xreg_value_a4_reg[2][15]} U6805 {CPU_Xreg_value_a4_reg[27][1]} U5069 {CPU_Xreg_value_a4_reg[2][16]} U6838 {CPU_Xreg_value_a4_reg[27][0]} {CPU_Xreg_value_a4_reg[26][31]} U5821 U6487 {CPU_Xreg_value_a4_reg[26][30]} {CPU_Xreg_value_a4_reg[26][29]} {CPU_Xreg_value_a4_reg[15][9]} U6620 {CPU_Xreg_value_a4_reg[26][28]} {CPU_Xreg_value_a4_reg[31][8]} U6587 U5451 {CPU_Xreg_value_a4_reg[26][6]} U6524 {CPU_Xreg_value_a4_reg[20][10]} U6665 {CPU_Xreg_value_a4_reg[26][3]} U5781 U6447 {CPU_Xreg_value_a4_reg[26][2]} DP_OP_214J1_122_1213/U14 {CPU_Xreg_value_a4_reg[3][15]} U6806 {CPU_Xreg_value_a4_reg[26][1]} U5086 {CPU_Xreg_value_a4_reg[26][0]} {CPU_Xreg_value_a4_reg[25][31]} U5822 U6488 {CPU_Xreg_value_a4_reg[25][30]} {CPU_Xreg_value_a4_reg[25][29]} {CPU_Xreg_value_a4_reg[31][9]} U6621 {CPU_Xreg_value_a4_reg[25][28]} {CPU_Xreg_value_a4_reg[30][8]} U6588 U5452 {CPU_Xreg_value_a4_reg[31][22]} {CPU_Xreg_value_a4_reg[25][19]} {CPU_Xreg_value_a4_reg[31][18]} {CPU_Xreg_value_a4_reg[25][15]} CPU_reset_a3_reg U6825 {CPU_Xreg_value_a4_reg[31][17]} {CPU_Xreg_value_a4_reg[31][16]} {CPU_Xreg_value_a4_reg[25][13]} U6759 {CPU_Xreg_value_a4_reg[31][12]} U6720 {CPU_Xreg_value_a4_reg[25][9]} {CPU_Xreg_value_a4_reg[19][29]} U6627 {CPU_Xreg_value_a4_reg[25][6]} U6525 {CPU_Xreg_value_a4_reg[19][10]} U6666 {CPU_Xreg_value_a4_reg[25][3]} U5782 U6448 U5056 {CPU_Xreg_value_a4_reg[31][14]} U6786 {CPU_Xreg_value_a4_reg[25][2]} {CPU_Xreg_value_a4_reg[25][1]} U5070 {CPU_Xreg_value_a4_reg[3][16]} U6839 {CPU_Xreg_value_a4_reg[25][0]} {CPU_Xreg_value_a4_reg[24][31]} U5823 U6489 {CPU_Xreg_value_a4_reg[24][30]} {CPU_Xreg_value_a4_reg[24][29]} {CPU_Xreg_value_a4_reg[30][9]} U6622 {CPU_Xreg_value_a4_reg[24][28]} {CPU_Xreg_value_a4_reg[29][8]} U6589 U5453 {CPU_Xreg_value_a4_reg[30][22]} {CPU_Xreg_value_a4_reg[24][19]} {CPU_Xreg_value_a4_reg[30][18]} {CPU_Xreg_value_a4_reg[24][15]} U5057 U6826 {CPU_Xreg_value_a4_reg[30][17]} {CPU_Xreg_value_a4_reg[30][16]} {CPU_Xreg_value_a4_reg[24][13]} U6760 {CPU_Xreg_value_a4_reg[30][12]} U6721 {CPU_Xreg_value_a4_reg[24][9]} {CPU_Xreg_value_a4_reg[18][29]} U6628 {CPU_Xreg_value_a4_reg[31][11]} U6687 {CPU_Xreg_value_a4_reg[24][8]} {CPU_Xreg_value_a4_reg[19][28]} U6594 {CPU_Xreg_value_a4_reg[24][6]} U6526 {CPU_Xreg_value_a4_reg[18][10]} U6667 {CPU_Xreg_value_a4_reg[24][3]} U5783 U6449 DP_OP_214J1_122_1213/U33 {CPU_Xreg_value_a4_reg[30][14]} U6787 {CPU_Xreg_value_a4_reg[24][2]} {CPU_Xreg_value_a4_reg[24][1]} U5087 {CPU_Xreg_value_a4_reg[24][0]} {CPU_Xreg_value_a4_reg[23][31]} U5824 U6490 {CPU_Xreg_value_a4_reg[23][30]} {CPU_Xreg_value_a4_reg[23][29]} {CPU_Xreg_value_a4_reg[29][9]} U6623 {CPU_Xreg_value_a4_reg[23][28]} {CPU_Xreg_value_a4_reg[28][8]} U6590 U5454 {CPU_Xreg_value_a4_reg[29][22]} {CPU_Xreg_value_a4_reg[23][19]} {CPU_Xreg_value_a4_reg[29][18]} {CPU_Xreg_value_a4_reg[29][17]} {CPU_Xreg_value_a4_reg[23][14]} DP_OP_214J1_122_1213/U26 U6794 {CPU_Xreg_value_a4_reg[29][16]} {CPU_Xreg_value_a4_reg[23][13]} U6761 {CPU_src2_value_a3_reg[7]} U6569 {CPU_Xreg_value_a4_reg[29][12]} U6722 {CPU_Xreg_value_a4_reg[23][9]} {CPU_Xreg_value_a4_reg[17][29]} U6629 {CPU_Xreg_value_a4_reg[30][11]} U6688 {CPU_Xreg_value_a4_reg[23][8]} {CPU_Xreg_value_a4_reg[18][28]} U6595 {CPU_Xreg_value_a4_reg[31][10]} U6654 {CPU_Xreg_value_a4_reg[23][7]} U6561 {CPU_Xreg_value_a4_reg[23][6]} U6527 {CPU_Xreg_value_a4_reg[17][10]} U6668 {CPU_Xreg_value_a4_reg[23][3]} U5791 U6457 {CPU_Xreg_value_a4_reg[11][12]} U6715 {CPU_Xreg_value_a4_reg[11][11]} U6682 {CPU_Xreg_value_a4_reg[28][7]} U6556 {CPU_Xreg_value_a4_reg[11][10]} U6649 {CPU_Xreg_value_a4_reg[11][2]} {CPU_Xreg_value_a4_reg[31][20]} {CPU_Xreg_value_a4_reg[10][23]} {CPU_Xreg_value_a4_reg[31][19]} {CPU_Xreg_value_a4_reg[10][22]} {CPU_Xreg_value_a4_reg[11][6]} U6513 {CPU_Xreg_value_a4_reg[10][19]} {CPU_Xreg_value_a4_reg[31][15]} U6819 {CPU_Xreg_value_a4_reg[10][18]} {CPU_Xreg_value_a4_reg[10][17]} {CPU_Xreg_value_a4_reg[31][13]} U6753 {CPU_Xreg_value_a4_reg[10][16]} {CPU_Xreg_value_a4_reg[10][12]} U6714 {CPU_Xreg_value_a4_reg[10][11]} U6681 {CPU_Xreg_value_a4_reg[29][7]} U6555 {CPU_Xreg_value_a4_reg[10][10]} {CPU_Xreg_value_a4_reg[10][3]} U5769 {CPU_Xreg_value_a4_reg[10][2]} U5444 U5079 U6848 {CPU_Xreg_value_a4_reg[10][0]} {CPU_Xreg_value_a4_reg[10][6]} U6512 {CPU_Xreg_value_a4_reg[9][19]} {CPU_Xreg_value_a4_reg[23][18]} {CPU_Xreg_value_a4_reg[17][15]} U5064 U6833 {CPU_Xreg_value_a4_reg[23][17]} {CPU_Xreg_value_a4_reg[17][14]} DP_OP_214J1_122_1213/U20 U6800 {CPU_Xreg_value_a4_reg[23][16]} {CPU_Xreg_value_a4_reg[17][13]} U6767 {CPU_Xreg_value_a4_reg[9][13]} U6746 {CPU_Xreg_value_a4_reg[23][12]} U6728 {CPU_Xreg_value_a4_reg[17][9]} {CPU_Xreg_value_a4_reg[3][30]} U6635 {CPU_Xreg_value_a4_reg[9][11]} U6680 {CPU_Xreg_value_a4_reg[23][11]} U6695 {CPU_Xreg_value_a4_reg[16][8]} {CPU_Xreg_value_a4_reg[3][29]} U6602 {CPU_Xreg_value_a4_reg[30][7]} U6554 {CPU_Xreg_value_a4_reg[9][10]} {CPU_Xreg_value_a4_reg[9][3]} U5768 {CPU_Xreg_value_a4_reg[9][2]} U5443 DP_OP_214J1_122_1213/U5 {CPU_Xreg_value_a4_reg[12][15]} U6815 {CPU_Xreg_value_a4_reg[9][1]} U7021 {CPU_Xreg_value_a4_reg[15][28]} U5478 {CPU_Xreg_value_a4_reg[9][6]} U6511 {CPU_Xreg_value_a4_reg[8][19]} {CPU_Xreg_value_a4_reg[24][18]} {CPU_Xreg_value_a4_reg[18][15]} U5063 U6832 {CPU_Xreg_value_a4_reg[24][17]} {CPU_Xreg_value_a4_reg[18][14]} DP_OP_214J1_122_1213/U21 U6799 {CPU_Xreg_value_a4_reg[24][16]} {CPU_Xreg_value_a4_reg[18][13]} U6766 {CPU_Xreg_value_a4_reg[8][13]} U6745 {CPU_Xreg_value_a4_reg[8][12]} U6712 {CPU_Xreg_value_a4_reg[24][12]} U6727 {CPU_Xreg_value_a4_reg[18][9]} {CPU_Xreg_value_a4_reg[2][30]} U6634 {CPU_Xreg_value_a4_reg[24][11]} U6694 {CPU_Xreg_value_a4_reg[17][8]} {CPU_Xreg_value_a4_reg[2][29]} U6601 {CPU_Xreg_value_a4_reg[31][7]} U6553 {CPU_Xreg_value_a4_reg[8][10]} {CPU_Xreg_value_a4_reg[16][7]} U6568 {CPU_Xreg_value_a4_reg[8][3]} U5767 {CPU_Xreg_value_a4_reg[8][2]} U5442 DP_OP_214J1_122_1213/U6 {CPU_Xreg_value_a4_reg[11][15]} U6814 {CPU_Xreg_value_a4_reg[8][1]} U7020 {CPU_Xreg_value_a4_reg[14][28]} U5477 U5078 U6847 {CPU_Xreg_value_a4_reg[8][0]} {CPU_src1_value_a3_reg[9]} {CPU_Xreg_value_a4_reg[9][7]} U6545 {CPU_Xreg_value_a4_reg[8][6]} U6510 {CPU_Xreg_value_a4_reg[7][19]} {CPU_Xreg_value_a4_reg[25][18]} {CPU_Xreg_value_a4_reg[19][15]} U5062 U6831 {CPU_Xreg_value_a4_reg[25][17]} {CPU_Xreg_value_a4_reg[19][14]} DP_OP_214J1_122_1213/U22 U6798 {CPU_Xreg_value_a4_reg[25][16]} {CPU_Xreg_value_a4_reg[19][13]} U6765 U5440 {CPU_Xreg_value_a4_reg[2][2]} {CPU_Xreg_value_a4_reg[7][13]} U6744 {CPU_Xreg_value_a4_reg[25][12]} U6726 {CPU_Xreg_value_a4_reg[19][9]} {CPU_Xreg_value_a4_reg[1][30]} U6633 {CPU_Xreg_value_a4_reg[7][11]} U6678 {CPU_Xreg_value_a4_reg[25][11]} U6693 {CPU_Xreg_value_a4_reg[18][8]} {CPU_Xreg_value_a4_reg[1][29]} U6600 {CPU_Xreg_value_a4_reg[17][7]} U6567 {CPU_Xreg_value_a4_reg[7][3]} U5790 U6456 {CPU_src2_value_a3_reg[9]} {CPU_Xreg_value_a4_reg[8][7]} U6544 {CPU_Xreg_value_a4_reg[7][6]} U6509 {CPU_src1_value_a3_reg[22]} {CPU_Xreg_value_a4_reg[6][20]} {CPU_Xreg_value_a4_reg[10][31]} U5810 U6476 {CPU_Xreg_value_a4_reg[6][19]} {CPU_Xreg_value_a4_reg[26][18]} {CPU_Xreg_value_a4_reg[20][15]} U5061 U6830 {CPU_Xreg_value_a4_reg[26][17]} {CPU_Xreg_value_a4_reg[20][14]} DP_OP_214J1_122_1213/U23 U6797 {CPU_Xreg_value_a4_reg[26][16]} {CPU_Xreg_value_a4_reg[20][13]} U6764 U5439 {CPU_Xreg_value_a4_reg[1][2]} {CPU_Xreg_value_a4_reg[6][13]} U6743 {CPU_Xreg_value_a4_reg[26][12]} U6725 {CPU_Xreg_value_a4_reg[26][11]} U6692 {CPU_Xreg_value_a5_reg[14][7]} U6551 {CPU_Xreg_value_a4_reg[6][10]} {CPU_Xreg_value_a4_reg[26][10]} U6659 {CPU_Xreg_value_a4_reg[18][7]} U6566 {CPU_Xreg_value_a4_reg[8][30]} U6640 {CPU_Xreg_value_a4_reg[15][30]} U6647 {CPU_Xreg_value_a4_reg[10][9]} {CPU_Xreg_value_a4_reg[15][29]} U6614 {CPU_Xreg_value_a4_reg[3][12]} U6707 {CPU_src2_value_a3_reg[10]} U6670 {CPU_Xreg_value_a4_reg[7][8]} U6577 {CPU_Xreg_value_a4_reg[29][10]} U6656 {CPU_Xreg_value_a4_reg[21][7]} U6563 U5290 {CPU_Xreg_value_a4_reg[3][5]} {CPU_Xreg_value_a4_reg[11][1]} {CPU_Xreg_value_a4_reg[9][0]} {CPU_Xreg_value_a4_reg[8][29]} {CPU_Xreg_value_a4_reg[3][9]} U6607 {CPU_src2_value_a3_reg[11]} U6703 {CPU_Xreg_value_a4_reg[6][9]} {CPU_Xreg_value_a4_reg[11][29]} U6610 {CPU_Xreg_value_a4_reg[11][8]} U6581 {CPU_Xreg_value_a4_reg[3][11]} U6674 {CPU_Xreg_value_a4_reg[29][11]} U6689 {CPU_Xreg_value_a4_reg[22][8]} {CPU_Xreg_value_a4_reg[17][28]} U6596 U5072 U6841 {CPU_Xreg_value_a4_reg[21][0]} {CPU_src1_value_a3_reg[17]} {CPU_Xreg_value_a4_reg[6][15]} DP_OP_214J1_122_1213/U11 U6809 {CPU_Xreg_value_a4_reg[10][14]} U6780 {CPU_Xreg_value_a4_reg[4][17]} {CPU_Xreg_value_a4_reg[28][17]} {CPU_Xreg_value_a4_reg[22][14]} DP_OP_214J1_122_1213/U25 U6795 {CPU_Xreg_value_a4_reg[5][0]} {CPU_Xreg_value_a4_reg[2][31]} U5802 U6468 {CPU_Xreg_value_a4_reg[7][2]} U5425 U5432 {CPU_Xreg_value_a4_reg[8][31]} U5808 U6474 {CPU_Xreg_value_a4_reg[4][19]} {CPU_Xreg_value_a4_reg[3][2]} U5441 U5469 U7013 {CPU_Xreg_value_a4_reg[7][28]} U5470 DP_OP_214J1_122_1213/U13 {CPU_Xreg_value_a4_reg[4][15]} U6807 {CPU_Xreg_value_a4_reg[23][1]} U5437 {CPU_Xreg_value_a4_reg[21][2]} {CPU_Xreg_value_a4_reg[4][13]} U6741 {CPU_Xreg_value_a4_reg[9][30]} U6641 {CPU_Xreg_value_a4_reg[4][12]} U6708 {CPU_Xreg_value_a4_reg[28][12]} U6723 {CPU_Xreg_value_a4_reg[22][9]} {CPU_Xreg_value_a4_reg[16][29]} U6630 {CPU_Xreg_value_a4_reg[6][31]} U5806 U6472 {CPU_Xreg_value_a4_reg[2][19]} {CPU_Xreg_value_a4_reg[9][29]} {CPU_Xreg_value_a4_reg[4][9]} U6608 {CPU_src1_value_a3_reg[11]} U6704 {CPU_Xreg_value_a4_reg[7][9]} {CPU_Xreg_value_a4_reg[12][29]} U6611 {CPU_Xreg_value_a4_reg[28][11]} U6690 {CPU_Xreg_value_a4_reg[21][8]} {CPU_Xreg_value_a4_reg[16][28]} U6597 {CPU_Xreg_value_a4_reg[8][15]} DP_OP_214J1_122_1213/U9 U6811 {CPU_Xreg_value_a4_reg[2][18]} {CPU_src1_value_a3_reg[10]} U6671 {CPU_Xreg_value_a4_reg[8][8]} U6578 {CPU_Xreg_value_a4_reg[28][10]} U6657 {CPU_Xreg_value_a4_reg[20][7]} U6564 {CPU_Xreg_value_a4_reg[27][19]} {CPU_Xreg_value_a4_reg[14][22]} {CPU_Xreg_value_a4_reg[3][6]} U6505 {CPU_Xreg_value_a4_reg[10][15]} DP_OP_214J1_122_1213/U7 U6813 {CPU_Xreg_value_a4_reg[4][18]} {CPU_Xreg_value_a4_reg[28][18]} U7015 {CPU_Xreg_value_a4_reg[9][28]} U5472 {CPU_Xreg_value_a4_reg[19][1]} {CPU_src1_value_a3_reg[16]} {CPU_Xreg_value_a4_reg[6][14]} U6776 {CPU_Xreg_value_a4_reg[10][13]} U6747 {CPU_Xreg_value_a4_reg[4][16]} {CPU_Xreg_value_a4_reg[28][16]} {CPU_Xreg_value_a4_reg[22][13]} U6762 {CPU_Xreg_value_a4_reg[1][3]} U5784 U6450 {CPU_Xreg_value_a4_reg[11][30]} U6643 {CPU_Xreg_value_a4_reg[4][30]} U6636 {CPU_Xreg_value_a4_reg[14][10]} U6652 {CPU_Xreg_value_a4_reg[8][14]} U6778 {CPU_Xreg_value_a4_reg[2][17]} {CPU_Xreg_value_a4_reg[27][15]} {CPU_result_a4_reg[4]} U6823 {CPU_Xreg_value_a4_reg[14][18]} {CPU_Xreg_value_a4_reg[27][20]} {CPU_Xreg_value_a4_reg[2][7]} U6538 U5289 {CPU_Xreg_value_a4_reg[2][5]} {CPU_Xreg_value_a4_reg[10][1]} U5461 {CPU_Xreg_value_a4_reg[7][10]} {CPU_Xreg_value_a4_reg[7][0]} {CPU_Xreg_value_a4_reg[12][10]} U6650 {CPU_Xreg_value_a4_reg[27][14]} DP_OP_214J1_122_1213/U30 U6790 {CPU_Xreg_value_a4_reg[14][17]} {CPU_Xreg_value_a4_reg[7][30]} U6639 {CPU_Xreg_value_a4_reg[9][9]} {CPU_Xreg_value_a4_reg[14][29]} U6613 {CPU_Xreg_value_a4_reg[2][12]} U6706 {CPU_Xreg_value_a4_reg[14][30]} U6646 {CPU_Xreg_value_a4_reg[1][6]} U6503 U5436 {CPU_Xreg_value_a4_reg[22][2]} {CPU_Xreg_value_a4_reg[3][13]} U6740 {CPU_Xreg_value_a4_reg[10][30]} U6642 {CPU_Xreg_value_a4_reg[27][12]} U6724 {CPU_Xreg_value_a4_reg[22][28]} {CPU_Xreg_value_a4_reg[27][8]} U6591 {CPU_Xreg_value_a4_reg[26][7]} U6558 {CPU_Xreg_value_a4_reg[13][10]} U6651 {CPU_Xreg_value_a4_reg[2][3]} U5785 U6451 U5295 {CPU_Xreg_value_a4_reg[8][5]} U5467 {CPU_Xreg_value_a4_reg[27][13]} U6757 {CPU_Xreg_value_a4_reg[14][16]} U5468 U5296 {CPU_Xreg_value_a4_reg[9][5]} {CPU_Xreg_value_a4_reg[26][15]} {CPU_result_a4_reg[3]} U6824 {CPU_Xreg_value_a4_reg[15][18]} U5294 {CPU_Xreg_value_a4_reg[7][5]} U5466 {CPU_Xreg_value_a4_reg[7][1]} U5288 {CPU_Xreg_value_a4_reg[1][5]} U5460 {CPU_Xreg_value_a4_reg[28][13]} U6756 {CPU_Xreg_value_a4_reg[13][16]} U5065 {CPU_Xreg_value_a4_reg[16][15]} U6834 {CPU_Xreg_value_a4_reg[11][0]} {CPU_Xreg_value_a4_reg[15][10]} U6653 U5071 U6840 {CPU_Xreg_value_a4_reg[23][0]} {CPU_src2_value_a3_reg[17]} {CPU_Xreg_value_a4_reg[5][15]} DP_OP_214J1_122_1213/U12 U6808 {CPU_Xreg_value_a4_reg[9][14]} U6779 {CPU_Xreg_value_a4_reg[3][17]} {CPU_Xreg_value_a4_reg[1][18]} {CPU_Xreg_value_a4_reg[7][15]} DP_OP_214J1_122_1213/U10 U6810 {CPU_Xreg_value_a4_reg[11][14]} U6781 {CPU_Xreg_value_a4_reg[5][17]} {CPU_Xreg_value_a4_reg[27][17]} {CPU_Xreg_value_a4_reg[21][14]} DP_OP_214J1_122_1213/U24 U6796 {CPU_Xreg_value_a4_reg[5][30]} U6637 {CPU_Xreg_value_a4_reg[12][30]} U6644 {CPU_Xreg_value_a4_reg[27][18]} {CPU_Xreg_value_a4_reg[21][15]} U5060 U6829 {CPU_Xreg_value_a4_reg[1][1]} U7017 {CPU_Xreg_value_a4_reg[11][28]} U5474 {CPU_Xreg_value_a4_reg[26][14]} DP_OP_214J1_122_1213/U29 U6791 {CPU_Xreg_value_a4_reg[15][17]} U7014 {CPU_Xreg_value_a4_reg[8][28]} U5471 {CPU_Xreg_value_a4_reg[22][1]} {CPU_src2_value_a3_reg[16]} {CPU_Xreg_value_a4_reg[5][14]} U6775 {CPU_Xreg_value_a4_reg[27][7]} U6557 {CPU_Xreg_value_a4_reg[28][19]} {CPU_Xreg_value_a4_reg[13][22]} {CPU_Xreg_value_a4_reg[2][6]} U6504 {CPU_Xreg_value_a4_reg[9][15]} DP_OP_214J1_122_1213/U8 U6812 {CPU_Xreg_value_a4_reg[3][18]} {CPU_Xreg_value_a4_reg[19][7]} U6565 {CPU_Xreg_value_a4_reg[6][2]} U5431 {CPU_Xreg_value_a4_reg[7][31]} U5807 U6473 {CPU_Xreg_value_a4_reg[3][19]} {CPU_Xreg_value_a4_reg[10][29]} {CPU_Xreg_value_a4_reg[5][9]} U6609 {CPU_Xreg_value_a4_reg[27][11]} U6691 {CPU_Xreg_value_a4_reg[28][20]} {CPU_Xreg_value_a4_reg[1][7]} U6537 {CPU_Xreg_value_a4_reg[11][3]} U5770 {CPU_Xreg_value_a4_reg[28][15]} U6822 {CPU_Xreg_value_a4_reg[13][18]} {CPU_Xreg_value_a4_reg[26][13]} U6758 {CPU_Xreg_value_a4_reg[15][16]} {CPU_Xreg_value_a4_reg[6][30]} U6638 {CPU_Xreg_value_a4_reg[13][30]} U6645 {CPU_Xreg_value_a4_reg[8][9]} {CPU_Xreg_value_a4_reg[13][29]} U6612 {CPU_Xreg_value_a4_reg[1][12]} U6705 U5293 {CPU_Xreg_value_a4_reg[6][5]} U5465 DP_OP_214J1_122_1213/U18 {CPU_src2_value_a3_reg[14]} U6802 {CPU_Xreg_value_a4_reg[15][1]} {CPU_Xreg_value_a4_reg[6][1]} U5459 {CPU_Xreg_value_a4_reg[6][6]} U6508 {CPU_src2_value_a3_reg[22]} {CPU_Xreg_value_a4_reg[5][20]} {CPU_Xreg_value_a4_reg[1][31]} U5801 U6467 U5075 U6844 {CPU_Xreg_value_a4_reg[2][0]} {CPU_Xreg_value_a4_reg[3][3]} U5786 U6452 {CPU_Xreg_value_a4_reg[6][7]} U6542 {CPU_Xreg_value_a4_reg[10][20]} {CPU_Xreg_value_a4_reg[4][23]} {CPU_Xreg_value_a4_reg[3][7]} U6539 {CPU_Xreg_value_a4_reg[7][20]} {CPU_Xreg_value_a4_reg[1][23]} {CPU_Xreg_value_a4_reg[26][20]} {CPU_Xreg_value_a4_reg[4][2]} U5438 {CPU_Xreg_value_a4_reg[20][2]} {CPU_Xreg_value_a4_reg[5][13]} U6742 U7016 {CPU_Xreg_value_a4_reg[10][28]} U5473 {CPU_Xreg_value_a4_reg[18][1]} {CPU_Xreg_value_a4_reg[1][17]} {CPU_Xreg_value_a4_reg[7][14]} U6777 {CPU_Xreg_value_a4_reg[11][13]} U6748 {CPU_Xreg_value_a4_reg[5][16]} {CPU_Xreg_value_a4_reg[27][16]} {CPU_Xreg_value_a4_reg[21][13]} U6763 U5433 {CPU_Xreg_value_a4_reg[12][11]} U6683 {CPU_Xreg_value_a4_reg[9][31]} U5809 U6475 {CPU_Xreg_value_a4_reg[5][19]} {CPU_Xreg_value_a4_reg[3][31]} U5803 U6469 U5076 U6845 {CPU_Xreg_value_a4_reg[4][0]} {CPU_Xreg_value_a4_reg[4][1]} U7018 {CPU_Xreg_value_a4_reg[12][28]} U5475 {CPU_Xreg_value_a4_reg[4][3]} U5787 U6453 U5464 U5292 {CPU_Xreg_value_a4_reg[5][5]} {CPU_Xreg_value_a4_reg[2][1]} U5457 U5291 {CPU_Xreg_value_a4_reg[4][5]} {CPU_Xreg_value_a4_reg[14][1]} {CPU_Xreg_value_a4_reg[26][19]} {CPU_Xreg_value_a4_reg[15][22]} {CPU_Xreg_value_a4_reg[4][6]} U6506 {CPU_Xreg_value_a4_reg[21][28]} {CPU_Xreg_value_a4_reg[26][8]} U6592 {CPU_Xreg_value_a4_reg[25][7]} U6559 {CPU_Xreg_value_a4_reg[6][29]} {CPU_Xreg_value_a4_reg[1][9]} U6605 {CPU_Xreg_value_a4_reg[9][8]} U6579 {CPU_Xreg_value_a4_reg[1][11]} U6672 {CPU_Xreg_value_a4_reg[25][8]} {CPU_Xreg_value_a4_reg[20][28]} U6593 {CPU_Xreg_value_a4_reg[15][11]} U6686 {CPU_Xreg_value_a4_reg[8][20]} {CPU_Xreg_value_a4_reg[2][23]} {CPU_Xreg_value_a4_reg[4][7]} U6540 {CPU_Xreg_value_a4_reg[5][2]} {CPU_Xreg_value_a4_reg[10][7]} U6546 {CPU_Xreg_value_a4_reg[1][10]} {CPU_Xreg_value_a4_reg[24][7]} U6560 {CPU_Xreg_value_a4_reg[1][13]} U6738 U5434 {CPU_Xreg_value_a4_reg[13][11]} U6684 {CPU_Xreg_value_a4_reg[4][29]} {CPU_src2_value_a3_reg[8]} U6603 {CPU_Xreg_value_a4_reg[4][31]} U5804 U6470 {CPU_Xreg_value_a4_reg[5][1]} U7019 {CPU_Xreg_value_a4_reg[13][28]} U5476 {CPU_Xreg_value_a4_reg[5][3]} U5788 U6454 {CPU_Xreg_value_a4_reg[1][0]} U5066 {CPU_src2_value_a3_reg[15]} U6835 {CPU_Xreg_value_a4_reg[13][0]} {CPU_Xreg_value_a4_reg[3][1]} U5458 {CPU_Xreg_value_a4_reg[5][6]} U6507 {CPU_Xreg_value_a4_reg[9][20]} {CPU_Xreg_value_a4_reg[3][23]} {CPU_Xreg_value_a4_reg[5][7]} U6541 {CPU_Xreg_value_a4_reg[7][29]} {CPU_Xreg_value_a4_reg[2][9]} U6606 {CPU_Xreg_value_a4_reg[10][8]} U6580 {CPU_Xreg_value_a4_reg[2][11]} U6673 {CPU_Xreg_value_a4_reg[11][7]} U6547 {CPU_Xreg_value_a4_reg[2][10]} {CPU_Xreg_value_a4_reg[30][10]} U6655 {CPU_Xreg_value_a4_reg[22][7]} U6562 {CPU_Xreg_value_a4_reg[2][13]} U6739 U5435 {CPU_Xreg_value_a4_reg[23][2]} {CPU_Xreg_value_a4_reg[14][11]} U6685 {CPU_Xreg_value_a4_reg[5][29]} {CPU_src1_value_a3_reg[8]} U6604 {CPU_Xreg_value_a4_reg[1][19]} {CPU_Xreg_value_a4_reg[5][31]} U5805 U6471 U5077 U6846 {CPU_Xreg_value_a4_reg[6][0]} {CPU_Xreg_value_a4_reg[6][3]} U5789 U6455 {CPU_Xreg_value_a4_reg[3][0]} {CPU_Xreg_value_a4_reg[28][14]} DP_OP_214J1_122_1213/U31 U6789 {CPU_Xreg_value_a4_reg[13][17]} U5067 {CPU_src1_value_a3_reg[15]} U6836 {CPU_Xreg_value_a4_reg[15][0]} {CPU_Xreg_value_a4_reg[5][18]} {CPU_Xreg_value_a4_reg[30][13]} U6754 {CPU_Xreg_value_a4_reg[11][16]} {CPU_Xreg_value_a4_reg[11][17]} {CPU_Xreg_value_a4_reg[30][15]} U6820 {CPU_Xreg_value_a4_reg[11][18]} {CPU_Xreg_value_a4_reg[11][19]} {CPU_Xreg_value_a4_reg[5][23]} {CPU_Xreg_value_a4_reg[11][20]} {CPU_Xreg_value_a4_reg[30][19]} {CPU_Xreg_value_a4_reg[11][22]} {CPU_Xreg_value_a4_reg[30][20]} {CPU_Xreg_value_a4_reg[11][23]} {CPU_Xreg_value_a4_reg[11][31]} U5811 U6477 U5080 U6849 {CPU_Xreg_value_a4_reg[12][0]} DP_OP_214J1_122_1213/U4 {CPU_Xreg_value_a4_reg[13][15]} U6816 {CPU_Xreg_value_a4_reg[12][1]} {CPU_Xreg_value_a4_reg[12][2]} U5426 {CPU_Xreg_value_a4_reg[12][3]} U5771 U5073 U6842 {CPU_Xreg_value_a4_reg[19][0]} {CPU_Xreg_value_a4_reg[12][6]} U6514 {CPU_Xreg_value_a4_reg[3][10]} {CPU_Xreg_value_a4_reg[12][7]} U6548 {CPU_Xreg_value_a4_reg[4][11]} U6675 {CPU_Xreg_value_a4_reg[5][12]} U6709 {CPU_Xreg_value_a4_reg[12][12]} U6716 {CPU_Xreg_value_a4_reg[6][16]} {CPU_Xreg_value_a4_reg[12][13]} U6749 {CPU_Xreg_value_a4_reg[6][17]} {CPU_Xreg_value_a4_reg[12][14]} U6782 {CPU_Xreg_value_a4_reg[6][18]} {CPU_Xreg_value_a4_reg[29][13]} U6755 {CPU_Xreg_value_a4_reg[12][16]} {CPU_Xreg_value_a4_reg[29][14]} DP_OP_214J1_122_1213/U32 U6788 {CPU_Xreg_value_a4_reg[12][17]} {CPU_Xreg_value_a4_reg[29][15]} U6821 {CPU_Xreg_value_a4_reg[12][18]} {CPU_Xreg_value_a4_reg[12][19]} {CPU_Xreg_value_a4_reg[6][23]} {CPU_Xreg_value_a4_reg[12][20]} {CPU_Xreg_value_a4_reg[29][19]} {CPU_Xreg_value_a4_reg[12][22]} {CPU_Xreg_value_a4_reg[29][20]} {CPU_Xreg_value_a4_reg[12][31]} U5812 U6478 {CPU_Xreg_value_a4_reg[13][1]} {CPU_Xreg_value_a4_reg[13][2]} U5427 {CPU_Xreg_value_a4_reg[13][3]} U5772 U5074 U6843 {CPU_Xreg_value_a4_reg[17][0]} {CPU_Xreg_value_a4_reg[13][6]} U6515 {CPU_Xreg_value_a4_reg[13][7]} U6549 {CPU_Xreg_value_a4_reg[6][12]} U6710 {CPU_Xreg_value_a4_reg[28][9]} {CPU_Xreg_value_a4_reg[22][29]} U6624 {CPU_Xreg_value_a4_reg[13][12]} U6717 {CPU_Xreg_value_a4_reg[7][16]} {CPU_Xreg_value_a4_reg[13][13]} U6750 {CPU_Xreg_value_a4_reg[7][17]} {CPU_Xreg_value_a4_reg[13][14]} U6783 {CPU_Xreg_value_a4_reg[16][13]} U6768 {CPU_Xreg_value_a4_reg[22][16]} {CPU_Xreg_value_a4_reg[7][18]} {CPU_Xreg_value_a4_reg[22][17]} {CPU_Xreg_value_a4_reg[13][19]} {CPU_Xreg_value_a4_reg[7][23]} {CPU_Xreg_value_a4_reg[13][20]} {CPU_Xreg_value_a4_reg[16][19]} {CPU_Xreg_value_a4_reg[22][22]} {CPU_Xreg_value_a4_reg[13][31]} U5813 U6479 U5081 U6850 {CPU_Xreg_value_a4_reg[14][0]} {CPU_Xreg_value_a4_reg[14][2]} U5428 {CPU_Xreg_value_a4_reg[14][3]} U5773 {CPU_Xreg_value_a4_reg[14][6]} U6516 {CPU_Xreg_value_a4_reg[14][7]} U6550 {CPU_Xreg_value_a4_reg[6][11]} U6677 {CPU_Xreg_value_a4_reg[7][12]} U6711 {CPU_Xreg_value_a4_reg[22][11]} U6696 {CPU_Xreg_value_a4_reg[27][9]} {CPU_Xreg_value_a4_reg[21][29]} U6625 {CPU_Xreg_value_a4_reg[14][12]} U6718 {CPU_Xreg_value_a4_reg[8][16]} {CPU_Xreg_value_a4_reg[14][13]} U6751 {CPU_Xreg_value_a4_reg[8][17]} {CPU_Xreg_value_a4_reg[14][14]} U6784 {CPU_src2_value_a3_reg[13]} U6769 {CPU_Xreg_value_a4_reg[21][16]} {CPU_Xreg_value_a4_reg[8][18]} {CPU_Xreg_value_a4_reg[21][17]} {CPU_Xreg_value_a4_reg[14][19]} {CPU_Xreg_value_a4_reg[8][23]} {CPU_Xreg_value_a4_reg[14][20]} {CPU_src2_value_a3_reg[19]} {CPU_Xreg_value_a4_reg[21][22]} {CPU_Xreg_value_a4_reg[14][31]} U5814 U6480 {CPU_Xreg_value_a4_reg[15][2]} {CPU_Xreg_value_a4_reg[15][3]} U5775 {CPU_Xreg_value_a4_reg[15][6]} U6518 {CPU_Xreg_value_a4_reg[15][7]} U6552 {CPU_Xreg_value_a4_reg[8][11]} U6679 {CPU_Xreg_value_a4_reg[1][8]} U6571 {CPU_Xreg_value_a4_reg[9][12]} U6713 {CPU_Xreg_value_a4_reg[20][11]} U6698 {CPU_Xreg_value_a4_reg[26][9]} {CPU_Xreg_value_a4_reg[20][29]} U6626 {CPU_Xreg_value_a4_reg[15][12]} U6719 {CPU_Xreg_value_a4_reg[9][16]} {CPU_Xreg_value_a4_reg[15][13]} U6752 {CPU_Xreg_value_a4_reg[9][17]} {CPU_Xreg_value_a4_reg[15][14]} U6785 {CPU_src1_value_a3_reg[13]} U6770 {CPU_Xreg_value_a4_reg[20][16]} {CPU_Xreg_value_a4_reg[9][18]} {CPU_Xreg_value_a4_reg[15][15]} U6818 {CPU_Xreg_value_a4_reg[20][17]} {CPU_Xreg_value_a4_reg[15][19]} {CPU_Xreg_value_a4_reg[9][23]} {CPU_Xreg_value_a4_reg[15][20]} {CPU_src1_value_a3_reg[19]} {CPU_Xreg_value_a4_reg[20][22]} U5445 {CPU_Xreg_value_a4_reg[15][31]} U5815 U6481 U5091 {CPU_Xreg_value_a4_reg[16][0]} {CPU_Xreg_value_a4_reg[16][1]} {CPU_Xreg_value_a4_reg[16][2]} {CPU_Xreg_value_a4_reg[16][3]} U5798 U6464 {CPU_Xreg_value_a4_reg[16][6]} U6534 {CPU_Xreg_value_a4_reg[7][7]} U6543 {CPU_Xreg_value_a4_reg[16][9]} {CPU_Xreg_value_a4_reg[6][8]} U6576 {CPU_Xreg_value_a4_reg[16][10]} U6669 {CPU_Xreg_value_a4_reg[16][11]} U6702 {CPU_Xreg_value_a4_reg[16][12]} U6735 {CPU_Xreg_value_a4_reg[4][14]} U6774 {CPU_Xreg_value_a4_reg[16][16]} {CPU_Xreg_value_a4_reg[16][17]} {CPU_Xreg_value_a4_reg[16][18]} {CPU_Xreg_value_a4_reg[4][20]} {CPU_Xreg_value_a4_reg[16][22]} {CPU_Xreg_value_a4_reg[16][30]} {CPU_Xreg_value_a4_reg[16][31]} U5831 U6497 {CPU_Xreg_value_a4_reg[17][1]} {CPU_Xreg_value_a4_reg[17][2]} {CPU_Xreg_value_a4_reg[17][3]} U5797 U6463 {CPU_Xreg_value_a4_reg[17][6]} U6533 {CPU_Xreg_value_a4_reg[5][8]} U6575 {CPU_Xreg_value_a4_reg[17][11]} U6701 {CPU_Xreg_value_a4_reg[17][12]} U6734 {CPU_Xreg_value_a4_reg[3][14]} U6773 {CPU_Xreg_value_a4_reg[17][16]} {CPU_Xreg_value_a4_reg[17][17]} {CPU_Xreg_value_a4_reg[17][18]} {CPU_Xreg_value_a4_reg[23][22]} {CPU_Xreg_value_a4_reg[17][19]} {CPU_Xreg_value_a4_reg[3][20]} {CPU_Xreg_value_a4_reg[17][22]} {CPU_Xreg_value_a4_reg[17][30]} {CPU_Xreg_value_a4_reg[17][31]} U5830 U6496 U5090 {CPU_Xreg_value_a4_reg[18][0]} {CPU_Xreg_value_a4_reg[18][2]} {CPU_Xreg_value_a4_reg[18][3]} U5796 U6462 {CPU_Xreg_value_a4_reg[18][6]} U6532 {CPU_Xreg_value_a4_reg[4][8]} U6574 {CPU_Xreg_value_a4_reg[18][11]} U6700 {CPU_Xreg_value_a4_reg[18][12]} U6733 {CPU_Xreg_value_a4_reg[2][14]} U6772 {CPU_Xreg_value_a4_reg[18][16]} {CPU_Xreg_value_a4_reg[18][17]} {CPU_Xreg_value_a4_reg[18][18]} {CPU_Xreg_value_a4_reg[24][22]} {CPU_Xreg_value_a4_reg[18][19]} {CPU_Xreg_value_a4_reg[2][20]} {CPU_Xreg_value_a4_reg[18][22]} {CPU_Xreg_value_a4_reg[18][30]} {CPU_Xreg_value_a4_reg[18][31]} U5829 U6495 {CPU_Xreg_value_a4_reg[19][2]} {CPU_Xreg_value_a4_reg[19][3]} U5795 U6461 {CPU_Xreg_value_a4_reg[19][6]} U6531 {CPU_Xreg_value_a4_reg[3][8]} U6573 {CPU_Xreg_value_a4_reg[19][11]} U6699 {CPU_Xreg_value_a4_reg[19][12]} U6732 {CPU_Xreg_value_a4_reg[1][14]} U6771 {CPU_Xreg_value_a4_reg[19][16]} {CPU_Xreg_value_a4_reg[19][17]} {CPU_Xreg_value_a4_reg[19][18]} {CPU_Xreg_value_a4_reg[25][22]} {CPU_Xreg_value_a4_reg[19][19]} {CPU_Xreg_value_a4_reg[1][20]} {CPU_Xreg_value_a4_reg[19][22]} {CPU_Xreg_value_a4_reg[19][30]} {CPU_Xreg_value_a4_reg[19][31]} U5828 U6494 U5089 {CPU_Xreg_value_a4_reg[20][0]} {CPU_Xreg_value_a4_reg[20][1]} {CPU_Xreg_value_a4_reg[20][3]} U5794 U6460 {CPU_Xreg_value_a4_reg[20][6]} U6530 {CPU_Xreg_value_a4_reg[2][8]} U6572 {CPU_Xreg_value_a4_reg[20][12]} U6731 {CPU_Xreg_value_a4_reg[20][18]} {CPU_Xreg_value_a4_reg[26][22]} {CPU_Xreg_value_a4_reg[20][19]} {CPU_Xreg_value_a4_reg[20][30]} {CPU_Xreg_value_a4_reg[20][31]} U5827 U6493 {CPU_Xreg_value_a4_reg[21][1]} {CPU_Xreg_value_a4_reg[21][3]} U5793 U6459 U5088 {CPU_Xreg_value_a4_reg[22][0]} {CPU_Xreg_value_a4_reg[21][6]} U6529 {CPU_Xreg_value_a4_reg[21][11]} U6697 {CPU_Xreg_value_a4_reg[21][12]} U6730 {CPU_Xreg_value_a4_reg[21][18]} {CPU_Xreg_value_a4_reg[27][22]} {CPU_Xreg_value_a4_reg[21][19]} U5456 {CPU_Xreg_value_a4_reg[21][30]} {CPU_Xreg_value_a4_reg[21][31]} U5826 U6492 {CPU_Xreg_value_a4_reg[22][3]} U5792 U6458 {CPU_Xreg_value_a4_reg[22][6]} U6528 {CPU_src1_value_a3_reg[7]} U6570 {CPU_Xreg_value_a4_reg[22][12]} U6729 {CPU_Xreg_value_a4_reg[22][18]} {CPU_Xreg_value_a4_reg[28][22]} {CPU_Xreg_value_a4_reg[22][19]} U5455 {CPU_Xreg_value_a4_reg[22][30]} {CPU_Xreg_value_a4_reg[22][31]} U5825 U6491 {CPU_Xreg_value_a4_reg[10][5]} U5297 {CPU_Xreg_value_a4_reg[11][5]} U5298 {CPU_Xreg_value_a4_reg[12][5]} U5299 {CPU_Xreg_value_a4_reg[13][5]} U5300 {CPU_Xreg_value_a4_reg[14][5]} U5301 {CPU_Xreg_value_a5_reg[14][5]} U5302 {CPU_Xreg_value_a4_reg[15][5]} U5303 {CPU_Xreg_value_a4_reg[31][5]} U5304 {CPU_Xreg_value_a4_reg[30][5]} U5305 {CPU_Xreg_value_a4_reg[29][5]} U5306 {CPU_Xreg_value_a4_reg[28][5]} U5307 {CPU_Xreg_value_a4_reg[27][5]} U5308 {CPU_Xreg_value_a4_reg[26][5]} U5309 {CPU_Xreg_value_a4_reg[25][5]} U5310 {CPU_Xreg_value_a4_reg[24][5]} U5311 {CPU_Xreg_value_a4_reg[23][5]} U5312 {CPU_Xreg_value_a4_reg[22][5]} U5313 {CPU_Xreg_value_a4_reg[21][5]} U5314 {CPU_Xreg_value_a4_reg[20][5]} U5315 {CPU_Xreg_value_a4_reg[19][5]} U5316 {CPU_Xreg_value_a4_reg[18][5]} U5317 {CPU_Xreg_value_a4_reg[17][5]} U5318 {CPU_Xreg_value_a4_reg[16][5]} U5319 {CPU_src2_value_a3_reg[5]} U5320 {CPU_result_a4_reg[5]} U5321 {CPU_Xreg_value_a4_reg[1][4]} U5322 {CPU_Xreg_value_a4_reg[2][4]} U5323 {CPU_Xreg_value_a4_reg[3][4]} U5324 {CPU_Xreg_value_a4_reg[4][4]} U5325 {CPU_Xreg_value_a4_reg[5][4]} U5326 {CPU_Xreg_value_a4_reg[6][4]} U5327 {CPU_Xreg_value_a4_reg[7][4]} U5328 {CPU_Xreg_value_a4_reg[8][4]} U5329 {CPU_Xreg_value_a4_reg[9][4]} U5330 {CPU_Xreg_value_a4_reg[10][4]} U5331 {CPU_Xreg_value_a4_reg[11][4]} U5332 {CPU_Xreg_value_a4_reg[12][4]} U5333 {CPU_Xreg_value_a4_reg[13][4]} U5334 {CPU_Xreg_value_a4_reg[14][4]} U5335 {CPU_Xreg_value_a5_reg[14][4]} U5336 {CPU_Xreg_value_a4_reg[15][4]} U5337 {CPU_Xreg_value_a4_reg[31][4]} U5338 {CPU_Xreg_value_a4_reg[30][4]} U5339 {CPU_Xreg_value_a4_reg[29][4]} U5340 {CPU_Xreg_value_a4_reg[28][4]} U5341 {CPU_Xreg_value_a4_reg[27][4]} U5342 {CPU_Xreg_value_a4_reg[26][4]} U5343 {CPU_Xreg_value_a4_reg[25][4]} U5344 {CPU_Xreg_value_a4_reg[24][4]} U5345 {CPU_Xreg_value_a4_reg[23][4]} U5346 {CPU_Xreg_value_a4_reg[22][4]} U5347 {CPU_Xreg_value_a4_reg[21][4]} U5348 {CPU_Xreg_value_a4_reg[20][4]} U5349 {CPU_Xreg_value_a4_reg[19][4]} U5350 {CPU_Xreg_value_a4_reg[18][4]} U5351 {CPU_Xreg_value_a4_reg[17][4]} U5352 {CPU_Xreg_value_a4_reg[16][4]} U5353 {CPU_src2_value_a3_reg[4]} U5354 U5355 U5356 U5357 U5358 U5359 U5360 U5361 U5362 U5363 U5364 U5365 U5366 U5367 U5368 U5369 U5370 U5371 U6037 U5372 U6038 U5373 U6039 U5374 U6040 U5375 U6041 U5376 U6042 U5377 U6043 U5378 U6044 U5379 U6045 U5380 U6046 U5381 U6047 U5382 U6048 U5383 U6049 U5384 U6050 U5385 U6051 U5386 U6052 U5387 U6053 U5388 U6054 U5389 U6055 U5390 U6056 U5391 U6057 U5392 U6058 U5393 U6059 U5394 U6060 U5395 U6061 U5396 U6062 U5397 U6063 U5398 U6064 U5399 U6065 U5400 U6066 U5401 U6067 U5402 U6068 U5403 U6069 U5404 U6070 U5405 U6071 U5406 U6072 U5407 U6073 U5408 U6074 U5409 U6075 U5410 U6076 U5411 U6077 U5412 U6078 U5413 U6079 U5414 U6080 U5415 U6081 U5416 U6082 U5417 U6083 U5418 U6084 U5419 U6085 U5420 U6086 U5421 U6087 U5422 U6088 U5423 U6089 U5424 U6090 U5479 U5480 U5481 U5482 U5483 U5484 U5485 U5486 U5487 U5488 U5489 U5490 U5491 U5492 U5493 U5494 U5495 U5496 U5497 U5498 U5499 U5500 U5501 U5502 U5503 U5504 U5505 U5506 U5507 U5508 U5509 U5510 U5511 U5512 U5513 U5514 U5515 U5516 U5517 U5518 U5519 U5520 U5521 U5522 U5523 U5524 U5525 U5526 U5527 U5528 U5529 U5530 U5531 U5532 U5533 U5534 U5535 U5536 U5537 U5538 U5539 U5540 U5541 U5542 U5543 U5544 U5545 U5546 U5547 U5548 U5549 U5550 U5551 U5552 U5553 U5554 U5555 U5556 U5557 U5558 U5559 U5560 U5561 U5562 U5563 U5564 U5565 U5566 U5567 U5568 U5569 U5570 U5571 U5572 U5573 U5574 U5575 U6241 U5576 U6242 U5577 U6243 U5578 U6244 U5579 U6245 U5580 U6246 U5581 U6247 U5582 U6248 U5583 U6249 U5584 U6250 U5585 U6251 U5586 U6252 U5587 U6253 U5588 U6254 U5589 U6255 U5590 U6256 U5591 U6257 U5592 U6258 U5593 U6259 U5594 U6260 U5595 U6261 U5596 U6262 U5597 U6263 U5598 U6264 U5599 U6265 U5600 U6266 U5601 U6267 U5602 U6268 U5603 U6269 U5604 U6270 U5605 U6271 U5606 U6272 U5607 U6273 U5608 U6274 U5609 U6275 U5610 U6276 U5611 U6277 U5612 U6278 U5613 U6279 U5614 U6280 U5615 U6281 U5616 U6282 U5617 U6283 U5618 U6284 U5619 U6285 U5620 U6286 U5621 U6287 U5622 U6288 U5623 U6289 U5624 U6290 U5625 U6291 U5626 U6292 U5627 U6293 U5628 U6294 U5629 U5630 U5631 U5632 U5633 U5634 U5635 U5636 U5637 U5638 U5639 U5640 U5641 U5642 U5643 U5644 U5645 U5646 U5647 U5648 U5649 U5650 U5651 U5652 U5653 U5654 U5655 U5656 U5657 U5658 U5659 U5660 U5661 U5662 U5663 U5664 U5665 U5666 U5667 U5668 U5669 U5670 U5671 U5672 U5673 U5674 U5675 U5676 U5677 U5678 U5679 U5680 U5681 U5682 U5683 U5684 U5685 U5686 U5687 U5688 U5689 U5690 U5691 U5692 U5693 U5694 U5695 U5696 U5697 U5698 U5699 U5700 U5701 U5702 U5703 U5704 U5705 U5706 U5707 U5708 U5709 U5710 U5711 U5712 U5713 U5714 U5715 U5716 U5717 U5718 U5719 U5720 U5721 U5722 U5723 U5724 U5725 U5726 U5727 U5728 U5729 U5730 U5731 U5732 U5733 U5734 U5735 U5736 U5737 U5738 U5739 U5740 U5741 U5742 U5743 U5744 U5745 U5746 U5747 U5748 U5749 U5750 U5751 U5752 U5753 U5754 U5755 U5756 U5757 U5758 U5759 U5760 U5761 U5762 U5763 U5764 U5765 U5887 U5888 U5889 U5890 U5891 U5892 U5893 U5894 U5895 U5896 U5897 U5898 U5899 U5900 U5901 U5902 U5903 U5904 U5905 U5906 U5907 U5908 U5909 U5910 U5911 U5912 U5913 U5914 U5915 U5916 U5917 U5918 U5919 U5920 U5921 U5922 U5923 U5924 U5925 U5926 U5927 U5928 U5929 U5930 U5931 U5932 U5933 U5934 U5935 U5936 U5937 U5938 U5939 U5940 U5941 U5942 U5943 U5944 U5945 U5946 U5947 U5948 U5949 U5950 U5951 U5952 U5953 U5954 U5955 U5956 U5957 U5958 U5959 U5960 U5961 U5962 U5963 U5964 U5965 U5966 U5967 U5968 U5969 U5970 U5971 U5972 U5973 U5974 U5975 U5976 U5977 U5978 U5979 U5980 U5981 U5982 U5983 U5984 U5985 U5986 U5987 U5988 U5989 U5990 U5991 U5992 U5993 U5994 U5995 U5996 U5997 U5998 U5999 U6000 U6001 U6002 U6003 U6004 U6005 U6006 U6007 U6008 U6009 U6010 U6011 U6012 U6013 U6014 U6015 U6016 U6017 U6018 U6019 U6020 U6021 U6022 U6023 U6024 U6025 U6026 U6027 U6028 U6029 U6030 U6031 U6032 U6033 U6034 U6035 U6036 U6091 U6092 U6093 U6094 U6095 U6096 U6097 U6098 U6099 U6100 U6101 U6102 U6103 U6104 U6105 U6106 U6107 U6108 U6109 U6110 U6111 U6112 U6113 U6114 U6115 U6116 U6117 U6118 U6119 U6120 U6121 U6122 U6123 U6124 U6125 U6126 U6127 U6128 U6129 U6130 U6131 U6132 U6133 U6134 U6135 U6136 U6137 U6138 U6139 U6140 U6141 U6142 U6143 U6144 U6145 U6146 U6147 U6148 U6149 U6150 U6151 U6152 U6153 U6154 U6155 U6156 U6157 U6158 U6159 U6160 U6161 U6162 U6163 U6164 U6165 U6166 U6167 U6168 U6169 U6170 U6171 U6172 U6173 U6174 U6175 U6176 U6177 U6178 U6179 U6180 U6181 U6182 U6183 U6184 U6185 U6186 U6187 {CPU_Xreg_value_a4_reg[12][23]} U6853 U6188 {CPU_Xreg_value_a4_reg[13][23]} U6854 U6189 {CPU_Xreg_value_a4_reg[14][23]} U6855 U6190 {CPU_Xreg_value_a4_reg[15][23]} U6856 U6191 {CPU_Xreg_value_a4_reg[31][23]} U6857 U6192 {CPU_Xreg_value_a4_reg[30][23]} U6858 U6193 {CPU_Xreg_value_a4_reg[29][23]} U6859 U6194 {CPU_Xreg_value_a4_reg[28][23]} U6860 U6195 {CPU_Xreg_value_a4_reg[27][23]} U6861 U6196 {CPU_Xreg_value_a4_reg[26][23]} U6862 U6197 {CPU_Xreg_value_a4_reg[25][23]} U6863 U6198 {CPU_Xreg_value_a4_reg[24][23]} U6864 U6199 {CPU_Xreg_value_a4_reg[23][23]} U6865 U6200 {CPU_Xreg_value_a4_reg[22][23]} U6866 U6201 {CPU_Xreg_value_a4_reg[21][23]} U6867 U6202 {CPU_Xreg_value_a4_reg[20][23]} U6868 U6203 {CPU_Xreg_value_a4_reg[19][23]} U6869 U6204 {CPU_Xreg_value_a4_reg[18][23]} U6870 U6205 {CPU_Xreg_value_a4_reg[17][23]} U6871 U6206 {CPU_Xreg_value_a4_reg[16][23]} U6872 U6207 {CPU_src2_value_a3_reg[23]} U6873 U6208 {CPU_src1_value_a3_reg[23]} U6874 U6209 {CPU_Xreg_value_a4_reg[1][24]} U6875 U6210 {CPU_Xreg_value_a4_reg[2][24]} U6876 U6211 {CPU_Xreg_value_a4_reg[3][24]} U6877 U6212 {CPU_Xreg_value_a4_reg[4][24]} U6878 U6213 {CPU_Xreg_value_a4_reg[5][24]} U6879 U6214 {CPU_Xreg_value_a4_reg[6][24]} U6880 U6215 {CPU_Xreg_value_a4_reg[7][24]} U6881 U6216 {CPU_Xreg_value_a4_reg[8][24]} U6882 U6217 {CPU_Xreg_value_a4_reg[9][24]} U6883 U6218 {CPU_Xreg_value_a4_reg[10][24]} U6884 U6219 {CPU_Xreg_value_a4_reg[11][24]} U6885 U6220 {CPU_Xreg_value_a4_reg[12][24]} U6886 U6221 {CPU_Xreg_value_a4_reg[13][24]} U6887 U6222 {CPU_Xreg_value_a4_reg[14][24]} U6888 U6223 {CPU_Xreg_value_a4_reg[15][24]} U6889 U6224 {CPU_Xreg_value_a4_reg[31][24]} U6890 U6225 {CPU_Xreg_value_a4_reg[30][24]} U6891 U6226 {CPU_Xreg_value_a4_reg[29][24]} U6892 U6227 {CPU_Xreg_value_a4_reg[28][24]} U6893 U6228 {CPU_Xreg_value_a4_reg[27][24]} U6894 U6229 {CPU_Xreg_value_a4_reg[26][24]} U6895 U6230 {CPU_Xreg_value_a4_reg[25][24]} U6896 U6231 {CPU_Xreg_value_a4_reg[24][24]} U6897 U6232 {CPU_Xreg_value_a4_reg[23][24]} U6898 U6233 {CPU_Xreg_value_a4_reg[22][24]} U6899 U6234 {CPU_Xreg_value_a4_reg[21][24]} U6900 U6235 {CPU_Xreg_value_a4_reg[20][24]} U6901 U6236 {CPU_Xreg_value_a4_reg[19][24]} U6902 U6237 {CPU_Xreg_value_a4_reg[18][24]} U6903 U6238 {CPU_Xreg_value_a4_reg[17][24]} U6904 U6239 {CPU_Xreg_value_a4_reg[16][24]} U6905 U6240 {CPU_src2_value_a3_reg[24]} U6906 U6295 U6296 U6297 U6298 U6299 U6300 U6301 U6302 U6303 U6304 U6305 U6306 U6307 U6308 U6309 U6310 U6311 U6312 U6313 U6314 U6315 U6316 U6317 U6318 U6319 U6320 U6321 U6322 U6323 U6324 U6325 U6326 U6327 U6328 U6329 U6330 U6331 U6332 U6333 U6334 U6335 U6336 U6337 U6338 U6339 U6340 U6341 U6342 U6343 U6344 U6345 U6346 U6347 U6348 U6349 U6350 U6351 U6352 U6353 U6354 U6355 U6356 U6357 U6358 U6359 U6360 U6361 U6362 U6363 U6364 U6365 U6366 U6367 U6368 U6369 U6370 U6371 U6372 U6373 U6374 U6375 U6376 U6377 U6378 U6379 U6380 U6381 U6382 U6383 U6384 U6385 U6386 U6387 U6388 U6389 U6390 U6391 U6392 U6393 U6394 U6395 U6396 U6397 U6398 U6399 U6400 U6401 U6402 U6403 U6404 U6405 U6406 U6407 U6408 U6409 U6410 U6411 U6412 U6413 U6414 U6415 U6416 U6417 U6418 U6419 U6420 U6421 U6422 U6423 U6424 U6425 U6426 U6427 U6428 U6429 U6430 U6431 U6432 U6433 U6434 U6435 U6436 U6437 U6438 U6439 U6440 U6441 U6442 U6443 U6444 {CPU_src1_value_a3_reg[24]} U6907 {CPU_Xreg_value_a4_reg[1][25]} U6908 {CPU_Xreg_value_a4_reg[2][25]} U6909 {CPU_Xreg_value_a4_reg[3][25]} U6910 {CPU_Xreg_value_a4_reg[4][25]} U6911 {CPU_Xreg_value_a4_reg[5][25]} U6912 {CPU_Xreg_value_a4_reg[6][25]} U6913 {CPU_Xreg_value_a4_reg[7][25]} U6914 {CPU_Xreg_value_a4_reg[8][25]} U6915 {CPU_Xreg_value_a4_reg[9][25]} U6916 {CPU_Xreg_value_a4_reg[10][25]} U6917 {CPU_Xreg_value_a4_reg[11][25]} U6918 {CPU_Xreg_value_a4_reg[12][25]} U6919 {CPU_Xreg_value_a4_reg[13][25]} U6920 {CPU_Xreg_value_a4_reg[14][25]} U6921 {CPU_Xreg_value_a4_reg[15][25]} U6922 {CPU_Xreg_value_a4_reg[31][25]} U6923 {CPU_Xreg_value_a4_reg[30][25]} U6924 {CPU_Xreg_value_a4_reg[29][25]} U6925 {CPU_Xreg_value_a4_reg[28][25]} U6926 {CPU_Xreg_value_a4_reg[27][25]} U6927 {CPU_Xreg_value_a4_reg[26][25]} U6928 {CPU_Xreg_value_a4_reg[25][25]} U6929 {CPU_Xreg_value_a4_reg[24][25]} U6930 {CPU_Xreg_value_a4_reg[23][25]} U6931 {CPU_Xreg_value_a4_reg[22][25]} U6932 {CPU_Xreg_value_a4_reg[21][25]} U6933 {CPU_Xreg_value_a4_reg[20][25]} U6934 {CPU_Xreg_value_a4_reg[19][25]} U6935 {CPU_Xreg_value_a4_reg[18][25]} U6936 {CPU_Xreg_value_a4_reg[17][25]} U6937 {CPU_Xreg_value_a4_reg[16][25]} U6938 {CPU_src2_value_a3_reg[25]} U6939 {CPU_src1_value_a3_reg[25]} U6940 {CPU_Xreg_value_a4_reg[1][26]} U6941 {CPU_Xreg_value_a4_reg[2][26]} U6942 {CPU_Xreg_value_a4_reg[3][26]} U6943 {CPU_Xreg_value_a4_reg[4][26]} U6944 {CPU_Xreg_value_a4_reg[5][26]} U6945 {CPU_Xreg_value_a4_reg[6][26]} U6946 {CPU_Xreg_value_a4_reg[7][26]} U6947 {CPU_Xreg_value_a4_reg[8][26]} U6948 {CPU_Xreg_value_a4_reg[9][26]} U6949 {CPU_Xreg_value_a4_reg[10][26]} U6950 {CPU_Xreg_value_a4_reg[11][26]} U6951 {CPU_Xreg_value_a4_reg[12][26]} U6952 {CPU_Xreg_value_a4_reg[13][26]} U6953 {CPU_Xreg_value_a4_reg[14][26]} U6954 {CPU_Xreg_value_a4_reg[15][26]} U6955 {CPU_Xreg_value_a4_reg[31][26]} U6956 {CPU_Xreg_value_a4_reg[30][26]} U6957 {CPU_Xreg_value_a4_reg[29][26]} U6958 {CPU_Xreg_value_a4_reg[28][26]} U6959 {CPU_Xreg_value_a4_reg[27][26]} U6960 {CPU_Xreg_value_a4_reg[26][26]} U6961 {CPU_Xreg_value_a4_reg[25][26]} U6962 {CPU_Xreg_value_a4_reg[24][26]} U6963 {CPU_Xreg_value_a4_reg[23][26]} U6964 {CPU_Xreg_value_a4_reg[22][26]} U6965 {CPU_Xreg_value_a4_reg[21][26]} U6966 {CPU_Xreg_value_a4_reg[20][26]} U6967 {CPU_Xreg_value_a4_reg[19][26]} U6968 {CPU_Xreg_value_a4_reg[18][26]} U6969 {CPU_Xreg_value_a4_reg[17][26]} U6970 {CPU_Xreg_value_a4_reg[16][26]} U6971 {CPU_src2_value_a3_reg[26]} U6972 {CPU_src1_value_a3_reg[26]} U6973 {CPU_Xreg_value_a4_reg[1][27]} U6974 {CPU_Xreg_value_a4_reg[2][27]} U6975 {CPU_Xreg_value_a4_reg[3][27]} U6976 {CPU_Xreg_value_a4_reg[4][27]} U6977 {CPU_Xreg_value_a4_reg[5][27]} U6978 {CPU_Xreg_value_a4_reg[6][27]} U6979 {CPU_Xreg_value_a4_reg[7][27]} U6980 {CPU_Xreg_value_a4_reg[8][27]} U6981 {CPU_Xreg_value_a4_reg[9][27]} U6982 {CPU_Xreg_value_a4_reg[10][27]} U6983 {CPU_Xreg_value_a4_reg[11][27]} U6984 {CPU_Xreg_value_a4_reg[12][27]} U6985 {CPU_Xreg_value_a4_reg[13][27]} U6986 {CPU_Xreg_value_a4_reg[14][27]} U6987 {CPU_Xreg_value_a4_reg[15][27]} U6988 {CPU_Xreg_value_a4_reg[31][27]} U6989 {CPU_Xreg_value_a4_reg[30][27]} U6990 {CPU_Xreg_value_a4_reg[29][27]} U6991 {CPU_Xreg_value_a4_reg[28][27]} U6992 {CPU_Xreg_value_a4_reg[27][27]} U6993 {CPU_Xreg_value_a4_reg[26][27]} U6994 {CPU_Xreg_value_a4_reg[25][27]} U6995 {CPU_Xreg_value_a4_reg[24][27]} U6996 {CPU_Xreg_value_a4_reg[23][27]} U6997 {CPU_Xreg_value_a4_reg[22][27]} U6998 {CPU_Xreg_value_a4_reg[21][27]} U6999 {CPU_Xreg_value_a4_reg[20][27]} U7000 {CPU_Xreg_value_a4_reg[19][27]} U7001 {CPU_Xreg_value_a4_reg[18][27]} U7002 {CPU_Xreg_value_a4_reg[17][27]} U7003 {CPU_Xreg_value_a4_reg[16][27]} U7004 {CPU_src2_value_a3_reg[27]} U7005 {CPU_src1_value_a3_reg[27]} U7006 {CPU_Xreg_value_a4_reg[1][28]} U7007 {CPU_Xreg_value_a4_reg[2][28]} U7008 {CPU_Xreg_value_a4_reg[3][28]} U7009 {CPU_Xreg_value_a4_reg[4][28]} U7010 {CPU_Xreg_value_a4_reg[5][28]} U7011 {CPU_Xreg_value_a4_reg[6][28]} U7012}]

eval create_placement -effort high -timing_driven -congestion
report_placement    -physical_hierarchy_violations all    -wirelength all -hard_macro_overlap    -verbose high > $REPORTS_DIR_PLACEMENT/report_placement.rpt

# write out macro preferred locations based on latest placement
# If this file exists on subsequent runs it will be used to drive the macro placement
if [sizeof_collection [get_cells -hier -filter is_hard_macro==true -quiet]] {
   file delete -force $OUTPUTS_DIR/preferred_macro_locations.tcl
   set all_macros [get_cells -hier -filter is_hard_macro==true]
   derive_preferred_macro_locations $all_macros -file $OUTPUTS_DIR/preferred_macro_locations.tcl
}

####################################
# Fix all shaped blocks and macros
####################################
if [sizeof_collection [get_cells -hier -filter is_hard_macro==true -quiet]] {
   set_attribute -quiet [get_cells -hierarchical -filter is_hard_macro==true] status fixed
}

save_block -hier -force   -label ${PLACEMENT_LABEL_NAME}
save_lib -all

####################################
# Create Power
####################################
if {[file exists $TCL_PNS_FILE]} {
   puts "RM-info : Sourcing TCL_PNS_FILE ($TCL_PNS_FILE)"
   source -echo $TCL_PNS_FILE
}

if {$PNS_CHARACTERIZE_FLOW == "true" && $TCL_COMPILE_PG_FILE != ""} {
   puts "RM-info : RUNNING PNS CHARACTERIZATION FLOW because \$PNS_CHARACTERIZE_FLOW == true"
   characterize_block_pg -output block_pg -compile_pg_script $TCL_COMPILE_PG_FILE
   set_constraint_mapping_file ./block_pg/pg_mapfile
   # run_block_compile_pg will honor the set_editability settings by default
   if {$DISTRIBUTED} { 
      set HOST_OPTIONS "-host_options block_script"
   } else {
      set HOST_OPTIONS ""
   }
   puts "RM-info : Running run_block_compile_pg $HOST_OPTIONS"
   eval run_block_compile_pg ${HOST_OPTIONS}

} else {
   if {$TCL_COMPILE_PG_FILE != ""} {
      source $TCL_COMPILE_PG_FILE
   } else {
      puts "RM-info : No Power Networks Implemented as TCL_COMPILE_PG_FILE does not exist"
   }
}

check_pg_connectivity -check_std_cell_pins none
# Create error report for PG ignoring std cells because they are not legalized
check_pg_drc -ignore_std_cells
# check_mv_design -erc_mode and -power_connectivity
redirect -file $REPORTS_DIR_CREATE_POWER/check_mv_design.erc_mode {check_mv_design -erc_mode}
redirect -file $REPORTS_DIR_CREATE_POWER/check_mv_design.power_connectivity {check_mv_design -power_connectivity}

save_block -hier -force   -label ${CREATE_POWER_LABEL_NAME}
save_lib -all

####################################
# Pin Placement
####################################
if {[file exists [which $TCL_PIN_CONSTRAINT_FILE]] && !$PLACEMENT_PIN_CONSTRAINT_AWARE} {
   source -echo $TCL_PIN_CONSTRAINT_FILE
}
set_app_options -as_user_default -list {route.global.timing_driven true}

if {$CHECK_DESIGN} {
   redirect -file ${REPORTS_DIR_PLACE_PINS}/check_design.pre_pin_placement     {check_design -ems_database check_design.pre_pin_placement.ems -checks dp_pre_pin_placement}
}

if {$PLACE_PINS_SELF} {
   place_pins -self
}

if {$PLACE_PINS_SELF} {
   # Write top-level port constraint file based on actual port locations in the design for reuse during incremental run.
   write_pin_constraints -self       -file_name $OUTPUTS_DIR/preferred_port_locations.tcl       -physical_pin_constraint {side | offset | layer}       -from_existing_pins

   # Verify Top-level Port Placement Results
   check_pin_placement -self -pre_route true -pin_spacing true -sides true -layers true -stacking true

   # Generate Top-level Port Placement Report
   report_pin_placement -self > $REPORTS_DIR_PLACE_PINS/report_port_placement.rpt
}

save_block -hier -force   -label ${PLACE_PINS_LABEL_NAME}
save_lib -all

####################################
# Timing estimation
####################################
estimate_timing
redirect -file $REPORTS_DIR_TIMING_ESTIMATION/${DESIGN_NAME}.post_estimated_timing.rpt     {report_timing -corner estimated_corner -mode [all_modes]}
redirect -file $REPORTS_DIR_TIMING_ESTIMATION/${DESIGN_NAME}.post_estimated_timing.qor     {report_qor    -corner estimated_corner}
redirect -file $REPORTS_DIR_TIMING_ESTIMATION/${DESIGN_NAME}.post_estimated_timing.qor.sum {report_qor    -summary}

save_block -hier -force   -label ${TIMING_ESTIMATION_LABEL_NAME}
save_lib -all

set path_dir [file normalize ${WORK_DIR_WRITE_DATA}]
set write_block_data_script /home/devipriya/rvmyth_45nm/icc2_workshop_collaterals/standaloneFlow/write_block_data.tcl
source ${write_block_data_script}

####################################
# Place, CTS, Route
####################################
set_host_options -max_cores 8
remove_corners [get_corners estimated_corner]
set_app_options -name place.coarse.continue_on_missing_scandef -value true
place_opt
clock_opt
route_auto -max_detail_route_iterations 5
set FILLER_CELLS [get_object_name [sort_collection -descending [get_lib_cells NangateOpenCellLibrary/FILL*] area]]
create_stdcell_fillers -lib_cells $FILLER_CELLS

save_block -hier -force   -label post_route
save_lib -all
```


## start_gui

Once the ```top.tcl``` file is run, type ```start_gui``` in ```icc2_shell``` and you will observe the following:

![2  vsdbabysoc start_gui - 1](https://user-images.githubusercontent.com/83152452/190424850-339c4701-06c4-43d2-8480-655b33861ff9.png)

The FINCELLs are shown below:

![2  vsdbabysoc start_gui - 3](https://user-images.githubusercontent.com/83152452/190424940-3a5d3ec4-a138-447e-ba76-d0aaed741a82.png)

![2  vsdbabysoc start_gui - 4](https://user-images.githubusercontent.com/83152452/190424992-112418d1-bc3a-48ec-9fad-820e17a4e348.png)

![2  vsdbabysoc start_gui - 10](https://user-images.githubusercontent.com/83152452/190425041-ac3b750f-4629-491c-a4ab-d51744146c3c.png)


## RVMYTH core in VSDBabySoC

Here are the pictures showing the standard cells placed :

![2  vsdbabysoc start_gui - 6](https://user-images.githubusercontent.com/83152452/190425274-d929e99b-e86a-4e1c-b998-a4edbc3b03d8.png)

![2  vsdbabysoc start_gui - 9](https://user-images.githubusercontent.com/83152452/190425309-473ea634-b697-499a-8752-3a344d4c89f3.png)


# Outputs generated

1. Type ``` set_propagated_clock [all_clocks] ``` in ```icc2_shell``` as shown below:

![set_propagated_clocks command - 1](https://user-images.githubusercontent.com/83152452/190433662-ca7d10b3-42a0-4989-a9ea-2d8e19113c06.png)

2. Type ``` report_timing ``` in ```icc2_shell``` and you will notice that the slack time is met as shown below:

![report_timing-timing estimation](https://user-images.githubusercontent.com/83152452/190433246-d8d090ad-952b-4a5c-bfdd-4d3493a0255a.png)

3. Type ``` estimate_timing ``` in ```icc2_shell``` and the report generated is shown below:

```
 Startpoint: reset (input port clocked by MYCLK)
  Endpoint: core/CPU_reset_a1_reg (rising edge-triggered flip-flop clocked by MYCLK)
  Mode: func1
  Corner: estimated_corner
  Scenario: func1::estimated_corner
  Path Group: **in2reg_default**
  Path Type: max

  Point                                            Incr      Path       Delta Incr     Analysis
  ----------------------------------------------------------------------------------------------------
  clock MYCLK (rise edge)                          0.00      0.00
  clock network delay (ideal)                      0.00      0.00
  input external delay                             5.00      5.00 f
  reset (in)                                       0.00      5.00 f      0.00
  core/CPU_reset_a1_reg/D (DFF_X1)                 0.01 e    5.01 f      0.00
  data arrival time                                          5.01        0.00        Delta arrival

  clock MYCLK (rise edge)                         10.00     10.00
  clock network delay (ideal)                      0.00     10.00
  core/CPU_reset_a1_reg/CK (DFF_X1)                0.00     10.00 r      0.00
  clock uncertainty                               -0.50      9.50
  library setup time                              -0.04      9.46
  data required time                                         9.46
  ----------------------------------------------------------------------------------------------------
  data required time                                         9.46
  data arrival time                                         -5.01
  ----------------------------------------------------------------------------------------------------
  slack (MET)                                                4.45


1
```


# Violations and errors

1. Type the following command in ```icc2_shell``` once the layout is generated:

``` report_constraints -all_violators -nosplit -verbose -significant_digits 4 > violators.rpt ```

![3  report constraints command - 1](https://user-images.githubusercontent.com/83152452/190427636-1a0e989a-6e45-4b87-8eba-2e0e799316aa.png)

2. To view the reports type:

``` vim violators.rpt ```

![3  report constraints command vim rpt- 2](https://user-images.githubusercontent.com/83152452/190427645-d3af80ba-f8a7-46e9-82a6-7f184ecd1ded.png)

One such violation is shown below:

```
Information: Timer using 'CRPR'. (TIM-050)

  Startpoint: core/CPU_imm_a2_reg[31] (rising edge-triggered flip-flop clocked by MYCLK)
  Endpoint: core/CPU_imm_a3_reg[31] (rising edge-triggered flip-flop clocked by MYCLK)
  Mode: func1
  Corner: func1
  Scenario: func1
  Path Group: MYCLK
  Path Type: min

  Point                                            Incr       Path  
  --------------------------------------------------------------------------
  clock MYCLK (rise edge)                          0.0000    0.0000
  clock network delay (propagated)                 0.1474    0.1474

  core/CPU_imm_a2_reg[31]/CK (DFF_X1)              0.0000    0.1474 r
  core/CPU_imm_a2_reg[31]/Q (DFF_X1)               0.1038    0.2512 r
  core/CPU_imm_a3_reg[31]/D (DFF_X1)               0.0004    0.2516 r
  data arrival time                                          0.2516

  clock MYCLK (rise edge)                          0.0000    0.0000
  clock network delay (propagated)                 0.1631    0.1631
  clock reconvergence pessimism                   -0.0035    0.1596
  core/CPU_imm_a3_reg[31]/CK (DFF_X1)              0.0000    0.1596 r
  clock uncertainty                                0.1000    0.2596
  library hold time                                0.0195    0.2791
  data required time                                         0.2791
  --------------------------------------------------------------------------
  data required time                                         0.2791
  data arrival time                                         -0.2516
  --------------------------------------------------------------------------
  slack (VIOLATED)                                          -0.0275

```

* Here the setup time is met but the hold time is not met and is violated. 
* The hold time has to be set if the IP has to go for tapeout or physical implementation.


3. Here are some of the other violations snapshots shown below:

This path shows that the regular buffer in clock path due to inavailability of clock buffer in PDK

![violations-1](https://user-images.githubusercontent.com/83152452/190431132-f5b92aec-0294-482f-bcbe-a276d5d60138.jpeg)

![violations-2](https://user-images.githubusercontent.com/83152452/190431152-a0119713-c5ca-43f8-92ea-463d6f099fe5.jpeg)



# Acknowledgements
- [Kunal Ghosh](https://github.com/kunalg123), Co-founder, VSD Corp. Pvt. Ltd.
- [VSDBabySoC](https://github.com/manili/VSDBabySoC.git).
- Skandha, T.A.


# Author
- [A Devipriya](https://github.com/Devipriya1921), B.E (Electronics and Communication Engineering), Bangalore - adevipriya1900@gmail.com


