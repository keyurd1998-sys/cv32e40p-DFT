# Modus ATPG for CV32E40P Core (COMPRESSION Mode)

This directory contains the step-by-step Automatic Test Pattern Generation (ATPG) flow using Cadence Modus for the post-scan compressed `cv32e40p_core`.

A single set of scripts in `scripts/` handles both Stuck-At and Transition Delay fault models without code duplication.

---

## Directory Structure

- `scripts/`: Step-by-step Modus ATPG Tcl scripts (`00` to `08`).
- `stuck_at/`: Workspace for Stuck-At ATPG execution (contains `test_netlist.v` and `.COMPRESSION.pinassign`).
- `delay/`: Workspace for Transition Delay ATPG execution (contains `test_netlist.v` and `.COMPRESSION.pinassign`).
- `run_atpg_step.sh`: Interactive step-by-step runner script.

---

## Configuration

- **Technology Library**: Strictly fixed to:
  ```tcl
  set TECH_LIB "/home/admin/DFT/Library/atpg/stdcell.v"
  ```
- **Test Mode**: Exclusively **COMPRESSION** mode (`cv32e40p_core.COMPRESSION.pinassign`). Fullscan bypass mode is removed.

---

## Step-by-Step ATPG Flow

The scripts in `scripts/` use the shared test database (`tbdata/`):

| Step | Script | Command | Purpose |
| :---: | :--- | :--- | :--- |
| **0** | `00_setup_env.tcl` | - | Sets design names, fixed `TECH_LIB`, `COMPRESSION` mode, and workspace paths |
| **1** | `01_build_model.tcl` | `build_model` | Builds flattened Boolean simulation model from netlist and `stdcell.v` |
| **2** | `02_build_testmode.tcl` | `build_testmode` | Loads `.COMPRESSION.pinassign` and initializes compression test mode |
| **3** | `03_verify_structures.tcl` | `verify_test_structures` | Checks TSV structural DRC rules and reports scan chain & masking structures |
| **4** | `04_build_faultmodel.tcl` | `build_faultmodel` | Initializes fault universe (Stuck-At or Delay based on `-m` mode) |
| **5** | `05_create_tests.tcl` | `create_logic_tests` | Generates deterministic compressed test patterns and reports test coverage |
| **6** | `06_analyze_power.tcl` | `write_toggle_gram` | Analyzes scan shift and capture switching activity to prevent IR drop |
| **7** | `07_write_vectors.tcl` | `write_vectors` | Exports serial and parallel Verilog simulation testbenches |
| **8** | `08_commit_tests.tcl` | `commit_tests` | Commits generated patterns to master database (`tbdata/`) |

---

## Usage Guide

### 1. Stuck-At ATPG (Default)

```bash
# Run all steps end-to-end:
./run_atpg_step.sh all

# Or run individual steps sequentially:
./run_atpg_step.sh 1    # Step 1: Build Logic Model
./run_atpg_step.sh 2    # Step 2: Build Test Mode
./run_atpg_step.sh 3    # Step 3: Verify Test Structures
./run_atpg_step.sh 4    # Step 4: Build Fault Model
./run_atpg_step.sh 5    # Step 5: Generate Patterns & Coverage
./run_atpg_step.sh 6    # Step 6: Power / Switching Activity
./run_atpg_step.sh 7    # Step 7: Export Verilog Vectors
./run_atpg_step.sh 8    # Step 8: Commit to Master Database
```

### 2. Transition Delay ATPG

The same scripts are used for Transition Delay ATPG by passing `-m delay`:

```bash
# Run all steps for Transition Delay:
./run_atpg_step.sh -m delay all

# Or run individual steps:
./run_atpg_step.sh -m delay 4 5
```
