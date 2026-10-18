# Modus ATPG for CV32E40P Core (COMPRESSION Mode)

This directory contains the Automatic Test Pattern Generation (ATPG) flow using Cadence Modus for `cv32e40p_core`.

---

## Directory Structure

```text
atpg/
├── stuck_at/
│   ├── runmodus.atpg.tcl            # Stuck-At ATPG (COMPRESSION mode)
│   ├── cv32e40p_core.COMPRESSION.pinassign
│   └── cv32e40p_core.test_netlist.v
│
├── delay/
│   ├── runmodus.atpg.tcl            # Transition Delay ATPG (COMPRESSION mode)
│   ├── cv32e40p_core.COMPRESSION.pinassign
│   └── cv32e40p_core.test_netlist.v
│
├── logs/                            # Central execution logs
└── reports/                         # Summary reports
```

---

## Technology Library & Mode Configuration

- **Technology Library**: Fixed standard cell Verilog model:
  ```tcl
  set TECH_LIB "/home/admin/DFT/Library/atpg/stdcell.v"
  ```
- **Test Mode**: Exclusively **COMPRESSION** mode (`cv32e40p_core.COMPRESSION.pinassign`). All Fullscan bypass files and commands are removed.

---

## ATPG Execution & Generated Reports

Each `runmodus.atpg.tcl` executes the complete ATPG flow and automatically exports all required reports and vectors:

| Report / Artifact | File Location | Description |
| :--- | :--- | :--- |
| **Scan Structures** | `reports/test_structures.rpt` | Scan chains, compression channels, and channel masking architecture |
| **Initial Faults** | `reports/initial_faults.rpt` | Initial collapsed and uncollapsed fault universe |
| **Test Summary** | `reports/test_summary.rpt` | Test pattern count, cycles, and pattern efficiency |
| **Fault Coverage** | `reports/fault_coverage.rpt` | Detailed test coverage and fault class distribution |
| **Switching Activity** | `reports/toggle_gram.rpt` | Scan shift and capture switching rates (power analysis) |
| **Serial Vectors** | `testresults/verilog/` | Tester-ready serial shift Verilog testbenches |
| **Parallel Vectors** | `testresults/verilog_parallel/` | Fast parallel load Verilog testbenches |

---

## How to Run

### 1. Stuck-At ATPG

```bash
cd /home/vlsi/keyurd1998-sys/cv32e40p-DFT/atpg/stuck_at

# Run Stuck-At ATPG:
modus -file runmodus.atpg.tcl -log runmodus.log
```

### 2. Transition Delay ATPG

```bash
cd /home/vlsi/keyurd1998-sys/cv32e40p-DFT/atpg/delay

# Run Transition Delay ATPG:
modus -file runmodus.atpg.tcl -log runmodus.log
```
