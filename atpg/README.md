# Modus ATPG for CV32E40P Core

This directory contains the Automatic Test Pattern Generation (ATPG) flow using Cadence Modus for the post-scan compressed `cv32e40p_core`.

---

## Directory Structure
- `stuck_at/`: Stuck-At ATPG workspace containing exported netlist, pinassign, and database (`tbdata/`).
- `delay/`: Transition Delay ATPG workspace containing exported netlist, pinassign, and database.
- `scripts/`: Modular, step-by-step Modus ATPG Tcl scripts (`00` through `08`).
- `run_atpg_step.sh`: Interactive step-by-step ATPG runner.

---

## Step-by-Step ATPG Flow Architecture

Each step performs a focused, verifiable stage of ATPG, sharing the persistent `tbdata/` database:

| Step | Script | Command | Purpose |
| :---: | :--- | :--- | :--- |
| **1** | `01_build_model.tcl` | `build_model` | Translates gate netlist & `stdcell.v` into Modus Boolean simulation model |
| **2** | `02_build_testmode.tcl` | `build_testmode` | Loads `.pinassign` and configures test mode (`COMPRESSION` or `FULLSCAN`) |
| **3** | `03_verify_structures.tcl` | `verify_test_structures` | Runs TSV structural DRC check & reports scan chain architecture |
| **4** | `04_build_faultmodel.tcl` | `build_faultmodel` | Seeds target fault universe (`stuck_at` or `delay`) and reports initial faults |
| **5** | `05_create_tests.tcl` | `create_logic_tests` | Generates deterministic patterns, compacts, and reports test coverage |
| **6** | `06_analyze_power.tcl` | `write_toggle_gram` | Analyzes scan shift and capture switching activity to prevent IR drop |
| **7** | `07_write_vectors.tcl` | `write_vectors` | Exports serial and parallel Verilog simulation testbenches |
| **8** | `08_commit_tests.tcl` | `commit_tests` | Commits generated patterns to master database (`tbdata/`) |

---

## Usage Guide

### 1. Running Stuck-At ATPG (Default)
```bash
# Run all 8 steps end-to-end:
./run_atpg_step.sh all

# Or run individual steps sequentially:
./run_atpg_step.sh 1    # Step 1: Build Logic Model
./run_atpg_step.sh 2    # Step 2: Build Test Mode
./run_atpg_step.sh 3    # Step 3: Verify Test Structures
./run_atpg_step.sh 4    # Step 4: Build Fault Model
./run_atpg_step.sh 5    # Step 5: Generate Patterns & Report Coverage
./run_atpg_step.sh 6    # Step 6: Switching Activity Analysis
./run_atpg_step.sh 7    # Step 7: Export Verilog Testbenches
./run_atpg_step.sh 8    # Step 8: Commit to Master Database
```

### 2. Running Transition Delay ATPG
```bash
# Run all steps for Transition Delay:
./run_atpg_step.sh -m delay all

# Or run individual steps:
./run_atpg_step.sh -m delay 1
./run_atpg_step.sh -m delay 4 5
```

### 3. Testing Bypass (Fullscan) Mode
```bash
# Run uncompressed bypass scan patterns:
./run_atpg_step.sh -t FULLSCAN all
```
