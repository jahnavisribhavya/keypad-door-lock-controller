# Keypad Door-Lock Controller with Brute-Force Lockout

## Project Overview
A Verilog HDL implementation of a keypad-based door-lock controller. The design checks a four-digit password, unlocks when the correct password is entered, and protects against repeated incorrect attempts.

## Features
- Four-digit password verification
- Finite State Machine (FSM) based design
- Automatic relocking
- Lockout after three incorrect password attempts
- Automatic recovery after lockout
- Password programming interface in the RTL

## Project Files
| File | Description |
|---|---|
| `keypad_lock.v` | Main RTL design |
| `tb_keypad_lock.v` | Simulation testbench |
| `dump.vcd` | Simulation waveform |
| `synthesis_report.txt` | Synthesis report |
| `sky130_synthesis.log` | Sky130 mapping log |
| `keypad_lock_mapped.v` | Mapped Verilog netlist |

## Verification
The testbench checks:
1. Reset behavior
2. Correct-password unlocking
3. Automatic relocking
4. Lockout after three incorrect attempts
5. Lockout expiration and recovery

## Synthesis and Physical Design
The RTL has been synthesized, and a standard-cell-mapped netlist has been generated using a Sky130 standard-cell timing library.

The complete physical-design flow—including floorplanning, placement, clock-tree synthesis, routing, and GDS generation—has not yet been completed or verified.

## Tools
- Verilog HDL
- Icarus Verilog
- GTKWave
- Yosys
- Sky130 standard-cell library
- OpenLane

## Future Work
- Complete the RTL-to-GDS physical-design flow
- Review timing and area reports
- Inspect and verify the final GDS layout
