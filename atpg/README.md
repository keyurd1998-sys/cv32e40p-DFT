# Modus ATPG for CV32E40P Core (COMPRESSION Mode)

This directory contains the step-by-step Automatic Test Pattern Generation (ATPG) flow using Cadence Modus for the post-scan compressed `cv32e40p_core`.

---

## Directory Structure

- `stuck_at/`: Stuck-At ATPG workspace containing netlist, pinassign, and 4-step scripts.
- `delay/`: Transition Delay ATPG workspace containing netlist, pinassign, and 4-step scripts.
- `run_atpg.sh`: Top-level runner to execute stuck-at and delay ATPG steps.

---

## 4-Step ATPG Flow Architecture

All scripts run strictly in **COMPRESSION** mode using the standard library:
`set TECH_LIB "/home/admin/DFT/Library/atpg/stdcell.v"`

| Step | Script | Modus Command | Description |
| :---: | :--- | :--- | :--- |
| **1** | `01_build_model.tcl` | `build_model` | Reads the gate netlist and `stdcell.v` to build the Boolean logic model. Resets `tbdata/`. |
| **2** | `02_verify_structures.tcl` | `build_testmode`, `verify_test_structures` | Loads `.COMPRESSION.pinassign`, configures compression mode, and checks scan chain DRC (TSV rules). |
| **3** | `03_run_atpg.tcl` | `build_faultmodel`, `create_logic_tests` (or `create_logic_delay_tests`), `write_toggle_gram` | Builds fault universe, generates compressed ATPG patterns, and calculates switching activity. |
| **4** | `04_write_vectors.tcl` | `write_vectors`, `commit_tests` | Exports serial Verilog test patterns and commits patterns to the master test database. |

---

## Execution Guide

### 1. Using the Top-Level Runner (`run_atpg.sh`)

```bash
# Run all 4 steps for Stuck-At ATPG:
./run_atpg.sh stuck_at

# Run all 4 steps for Transition Delay ATPG:
./run_atpg.sh delay

# Run all steps for both Stuck-At and Delay:
./run_atpg.sh all

# Run an individual step (e.g. Step 1 or Step 3):
./run_atpg.sh stuck_at 1
./run_atpg.sh stuck_at 3
```

### 2. Running Directly Inside Subdirectories

You can also run directly inside `stuck_at/` or `delay/`:

```bash
cd stuck_at

# Run all steps:
./run_step.sh all

# Or run steps one by one:
./run_step.sh 1    # 01_build_model.tcl
./run_step.sh 2    # 02_verify_structures.tcl
./run_step.sh 3    # 03_run_atpg.tcl
./run_step.sh 4    # 04_write_vectors.tcl

# Or run directly with modus:
modus -file 01_build_model.tcl -log 01_build_model.log
```
