# Modus ATPG for CV32E40P Core (COMPRESSION Mode)

This directory contains the Automatic Test Pattern Generation (ATPG) flow using Cadence Modus for `cv32e40p_core`.

---

## Directory Structure

```text
atpg/
├── runmodus.atpg.tcl                # Unified ATPG script (Stuck-At & Delay, COMPRESSION)
├── cv32e40p_core.COMPRESSION.pinassign
├── logs/                            # Execution logs
└── reports/                         # Summary & coverage reports
```

---

## Configuration

- **Technology Library**: Fixed standard cell Verilog model:
  ```tcl
  set TECH_LIB "/home/admin/DFT/Library/atpg/stdcell.v"
  ```
- **Netlist Source**: Directly uses the synthesized scan compressed netlist from the `scan/` directory:
  ```tcl
  set NETLIST "$WORKDIR/../scan/netlists/cv32e40p_core_compressed.v"
  ```
- **Test Mode**: Exclusively **COMPRESSION** mode (`cv32e40p_core.COMPRESSION.pinassign`).

---

## Unified ATPG Flow Execution

Running `runmodus.atpg.tcl` executes both **Stuck-At** and **Transition Delay** ATPG in a single run:

1. **Model Build**: Reads standard cells and scan netlist into Boolean logic model.
2. **Test Mode**: Loads compression pin assignments and verifies TSV structural DRC rules.
3. **Part A (Stuck-At ATPG)**:
   - Builds static fault universe (`build_faultmodel -includedynamic no`).
   - Generates deterministic compressed test patterns (`create_logic_tests`).
   - Analyzes switching activity (`write_toggle_gram`).
   - Exports serial and parallel Verilog vectors.
   - Commits tests to the database.
4. **Part B (Transition Delay ATPG)**:
   - Builds dynamic transition fault universe (`build_faultmodel -includedynamic yes`).
   - Generates at-speed transition test patterns (`create_logic_delay_tests`).
   - Generates supplementary logic tests (`create_logic_tests -append yes -testscan no`).
   - Analyzes switching activity (`write_toggle_gram`).
   - Exports serial and parallel Verilog vectors.
   - Commits tests to the database.

---

## Generated Reports & Artifacts

| Category | Report / Artifact | File Location | Description |
| :--- | :--- | :--- | :--- |
| **Structure** | Scan Structures | `reports/test_structures.rpt` | Scan chains, compression channels, & masking |
| **Stuck-At** | Initial Faults | `reports/stuck_at_initial_faults.rpt` | Collapsed/uncollapsed static fault universe |
| **Stuck-At** | Test Summary | `reports/stuck_at_test_summary.rpt` | Pattern count, cycle count, & efficiency |
| **Stuck-At** | Fault Coverage | `reports/stuck_at_fault_coverage.rpt` | Test coverage & fault classification breakdown |
| **Stuck-At** | Switching Activity | `reports/stuck_at_toggle_gram.rpt` | Scan shift and capture toggle rates |
| **Stuck-At** | Serial Vectors | `testresults/stuck_at/verilog_serial/` | Tester-ready serial shift Verilog testbench |
| **Stuck-At** | Parallel Vectors | `testresults/stuck_at/verilog_parallel/`| Fast register deposit Verilog testbench |
| **Delay** | Initial Faults | `reports/delay_initial_faults.rpt` | Dynamic transition fault universe |
| **Delay** | Test Summary | `reports/delay_test_summary.rpt` | Pattern count, cycle count, & efficiency |
| **Delay** | Fault Coverage | `reports/delay_fault_coverage.rpt` | Test coverage & fault classification breakdown |
| **Delay** | Switching Activity | `reports/delay_toggle_gram.rpt` | Scan shift and capture toggle rates |
| **Delay** | Serial Vectors | `testresults/delay/verilog_serial/` | Tester-ready serial shift Verilog testbench |
| **Delay** | Parallel Vectors | `testresults/delay/verilog_parallel/` | Fast register deposit Verilog testbench |

---

## How to Run

```bash
cd /home/vlsi/keyurd1998-sys/cv32e40p-DFT/atpg

# Run ATPG for both Stuck-At and Transition Delay:
modus -file runmodus.atpg.tcl -log runmodus.log
```
