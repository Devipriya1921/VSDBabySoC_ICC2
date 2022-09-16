# VSDBabySoC

VSDBabySoC is a small SoC including PLL, DAC, and a RISCV-based processor named RVMYTH.

# Table of Contents
- [Introduction to VSDBabySoC](#introduction-to-vsdbabysoc)
  - [SoC](#soc)
  - [RVMYTH](#rvmyth)
  - [PLL](#pll)
  - [DAC](#dac)
- [VSDBabySoC Modeling](#vsdbabysoc-modeling)
- [RVMYTH Modeling](#rvmyth-modeling)
- [DAC Modeling](#dac-modeling)
- [PLL Modeling](pll-modeling)
- [Getting Started with VSDBabySoC](getting-started-with-vsdbabysoc)
- [IC Compiler II](ic-compiler-ii)
  - [ICC Design Planning Overview](icc-design-planning-overview)
     - [Design planning](#design-planning)
     - [Milkyway Reference Libraries](milkyway-reference-libraries)
     - [Technology File](#technology-file)
     - [Design Flow](#design-flow)
     - [Hierarchical Design Planning Flow](#hierarchical-design-planning-flow)
        - [Design Partitioning](#design-partitioning)
        - [Deciding on the Physical Partitions](#deciding-on-the-physical-partitions)
  - [Design Planning at Multiple Levels of Physical Hierarchy](#design-planning-at-multiple-levels-of-physical-hierarchy)
     - [Data Model](#data-model)
     - [Block Shaping](#block-shaping)
     - [Cell and Macro Placement](#cell-and-macro-placement)
     - [Power Planning](#power-planning)
     - [Pin Placement](#pin-planning)
     - [Timing Budgeting](#timing-budgeting)
  - [Design Validation During Design Planning](#design-validation-during-design-planning)
- [RVMYTH CORE](#rvmyth-core)
  - [Synthesis](#synthesis)
  - [Schematic](#schematic)
  - [Performing Physical Design](#performing-physical-design)
  - [Start gui](#start-gui)
  - [RVMYTH core in VSDBabySoC](#rvmyth-core-in-vsdbabysoc)
- [Outputs generated](#outputs-generated)
- [Violations and Future Work](#violations-and-future-work)
- [Acknowledgements](#acknowledgements)
- [Author](#author)



# Introduction to VSDBabySoC

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

### Design planning 

IC Compiler II tool provides the following features for developing hierarchical and flat designs, such as :

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


### Technology File 

Tech File(.tf file) is unique to each technology.

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


### Design Flow

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

The ```top.tcl``` script file that is run in the ```icc2_shell``` that generates the Final Layout. The script is present in the files provided.

The steps includes:

```

###---NDM Library creation---###

###---Read Synthesized Verilog---###

## Technology setup for routing layer direction, offset, site default, and site symmetry.

###---Routing settings---###

####################################
# Check Design: Pre-Floorplanning
####################################

####################################
# Floorplanning
####################################

####################################
## PG Pin connections
#####################################

####################################
### Place IO
######################################

####################################
### Memory Placement
######################################

####################################
# Configure placement
####################################

########################################
## Read parasitic files
########################################

########################################
## Read constraints
########################################

####################################
# Fix all shaped blocks and macros
####################################

####################################
# Create Power
####################################

####################################
# Pin Placement
####################################

####################################
# Timing estimation
####################################

####################################
# Place, CTS, Route
####################################

## Start gui
```

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


# Violations and Future Work

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
* NOTE : The hold time has to be met if the IP has to go for tapeout or physical implementation.


3. Here are some of the other violations snapshots shown below:

This path shows that the regular buffer in clock path due to inavailability of clock buffer in PDK

![violations-1](https://user-images.githubusercontent.com/83152452/190431132-f5b92aec-0294-482f-bcbe-a276d5d60138.jpeg)

![violations-2](https://user-images.githubusercontent.com/83152452/190431152-a0119713-c5ca-43f8-92ea-463d6f099fe5.jpeg)

4. Future work would be to integrate the RVMYTH Digital block to PLL and DAC Analog blocks using the LEF Files.

5. The above mentioned violations in point number 1,2 and 3 has be corrected before going for Physical Implementation.


# Acknowledgements
- [Kunal Ghosh](https://github.com/kunalg123), Co-founder, VSD Corp. Pvt. Ltd.
- [VSDBabySoC](https://github.com/manili/VSDBabySoC.git).
- Skandha, T.A.


# Author
- [A Devipriya](https://github.com/Devipriya1921), B.E (Electronics and Communication Engineering), Bangalore - adevipriya1900@gmail.com


