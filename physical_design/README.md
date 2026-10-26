# Physical Design — Keypad Door-Lock Controller

## 1. Project Overview

The Keypad Door-Lock Controller is a digital security system designed using Verilog HDL. It supports password verification, access control, automatic relocking, and incorrect-password lockout.

The project follows an RTL-to-GDSII implementation methodology targeting the SkyWater SKY130 standard-cell technology.

## 2. Tools and Technologies

- Verilog HDL
- Yosys — Logic Synthesis
- OpenLane — RTL-to-GDSII Flow
- OpenROAD — Physical Design
- SkyWater SKY130 PDK
- KLayout — Layout Visualization

## 3. RTL-to-GDSII Flow

### 3.1 RTL Design and Verification

The controller is implemented in Verilog HDL using a finite-state machine. Functional scenarios include password validation, access granting, automatic relocking, and lockout after repeated incorrect attempts.

### 3.2 Logic Synthesis

Logic synthesis converts the RTL design into a gate-level netlist using standard cells from the target technology library.

### 3.3 Floorplanning

The floorplanning stage defines the core area, die area, placement boundaries, and locations for the design's input and output pins.

### 3.4 Power Planning

A power distribution network is planned to supply power and ground to the standard cells.

### 3.5 Placement

Standard cells are positioned within the floorplan while considering timing, congestion, and interconnect length.

### 3.6 Clock Tree Synthesis

Clock Tree Synthesis constructs a clock distribution network when required by the design and flow configuration.

### 3.7 Routing

The routing stage connects the placed standard cells through the available metal layers.

### 3.8 Timing and Physical Verification

Static Timing Analysis evaluates setup and hold timing against the configured constraints. Design Rule Checking and connectivity checks are required to assess layout correctness.

### 3.9 GDSII Export

The final layout is exported in GDSII format for layout inspection and subsequent manufacturing-related checks.

## 4. Illustrative SKY130 Reference Values

The following are **example reference values for planning only**. They are not measured results from this project.

| Parameter | Illustrative value |
|---|---:|
| Technology node | 130 nm |
| Nominal core utilization target | 30–40% |
| Nominal supply voltage | 1.8 V |
| Clock period example | 20 ns |
| Corresponding clock frequency | 50 MHz |
| Metal routing layers | Technology- and configuration-dependent |

Actual core area, cell count, signal-metal usage, timing slack, power consumption, and DRC results depend on the synthesized design, constraints, PDK version, and implementation configuration.

## 5. Expected Physical Design Outputs

A completed RTL-to-GDSII run should produce the applicable outputs below:

- Synthesized gate-level netlist
- Floorplan and placement database
- Clock-tree synthesis results, if required
- Routed design database
- Static Timing Analysis reports
- Design Rule Checking and connectivity reports
- Final GDSII layout file

## 6. Project Files

- [RTL Source](../keypad_lock.v)
- [Synthesized Netlist](../keypad_lock_mapped.v)
- [Testbench](../tb_keypad_lock.v)
- [Synthesis Report](../synthesis_report.txt)
- [STA Script](../sta_check.tcl)
- [STA Report](../sta_report.txt)

## 7. Conclusion

The Keypad Door-Lock Controller demonstrates the RTL design and synthesis stages of a digital hardware security system. The documented physical-design methodology outlines the subsequent steps required to progress from a synthesized netlist to a verified GDSII layout.

The illustrative values in this document are reference assumptions, not project-specific physical-design measurements. Final implementation metrics and sign-off status must be established from an actual physical-design run.

## 8. Related Documentation

- [Main Project README](../README.md)
- [GDSII Documentation](../gds/README.md)
 
