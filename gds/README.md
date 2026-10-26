# GDSII Generation — Keypad Door-Lock Controller

## 1. Overview

GDSII (Graphic Data System II) is a standard file format used to represent the physical layout of an integrated circuit. It contains layout geometry, cell structures, and layer information required for physical design inspection and manufacturing-related workflows.

This project documents the intended GDSII generation flow for the Verilog-based Keypad Door-Lock Controller using the SkyWater SKY130 technology platform.

## 2. Design Information

| Parameter | Description |
|---|---|
| Project | Keypad Door-Lock Controller |
| Design type | Digital control circuit |
| HDL | Verilog |
| Target technology | SkyWater SKY130 |
| Synthesis tool | Yosys |
| Physical design flow | OpenLane / OpenROAD |
| Layout inspection | KLayout |
| Expected output | `keypad_lock.gds` |

## 3. GDSII Generation Flow

The following stages are required to generate the final layout:

1. **RTL Preparation:** Prepare and verify the Verilog design.
2. **Logic Synthesis:** Generate a gate-level netlist.
3. **Technology Configuration:** Configure the SKY130 PDK and standard-cell libraries.
4. **Floorplanning:** Define the core area and pin locations.
5. **Placement:** Position standard cells.
6. **Clock Tree Synthesis:** Build the clock network if required.
7. **Routing:** Complete the physical interconnections.
8. **Physical Verification:** Perform applicable timing, design-rule, and connectivity checks.
9. **GDSII Export:** Export the final physical layout.
10. **Layout Inspection:** Open the generated GDSII file in KLayout for visual inspection.

## 4. Tools Required

- **OpenLane:** Automated RTL-to-GDSII implementation flow
- **OpenROAD:** Placement, clock-tree synthesis, routing, and related physical-design operations
- **SkyWater SKY130 PDK:** Technology files and standard-cell libraries
- **KLayout:** GDSII visualization and inspection
- **Yosys:** RTL synthesis

## 5. Illustrative Reference Parameters

The following are example planning values, not measured results from this project.

| Parameter | Example reference |
|---|---|
| Technology node | 130 nm |
| Nominal supply voltage | 1.8 V |
| Example clock period | 20 ns |
| Corresponding clock frequency | 50 MHz |
| Core utilization target | 30–40% |
| GDSII output filename | `keypad_lock.gds` |

Actual design dimensions, cell count, routing area, timing slack, and power depend on the implementation configuration and must be obtained from the completed physical-design flow.

## 6. Expected Output Structure

After a successful physical-design run, the project may contain:

```text
gds/
├── README.md
└── keypad_lock.gds
```

The GDSII file should be added only after it has actually been generated.

## 7. Verification Checklist

- [ ] GDSII file generated successfully
- [ ] Correct SKY130 technology configuration used
- [ ] Layout opened and inspected in KLayout
- [ ] Design Rule Checking completed
- [ ] Connectivity checks completed
- [ ] Timing reports reviewed
- [ ] Final layout and reports archived

## 8. Current Documentation Status

This document describes the GDSII generation methodology, expected deliverables, and verification requirements for the Keypad Door-Lock Controller. The final GDSII file and physical verification results must be produced by running the physical-design flow; the reference values above are illustrative only.

## 9. Related Project Files

- [Main Project README](../README.md)
- [RTL Source](../keypad_lock.v)
- [Synthesized Netlist](../keypad_lock_mapped.v)
- [Physical Design Documentation](../physical_design/README.md)

## 10. Conclusion

GDSII generation is the final layout-export stage of the RTL-to-GDSII flow. Completing the required implementation and verification stages will allow the Keypad Door-Lock Controller to progress from its synthesized digital design to a physical layout suitable for further inspection.
