# Modus ATPG for CV32E40P Core (COMPRESSION Mode)

This directory contains the Automatic Test Pattern Generation (ATPG) flow using Cadence Modus for `cv32e40p_core`.

---

## Architecture & Responsibilities

- **Shell Runner (`run_atpg.sh`)**:
  - Initializes directory structure (`stuck_at/` or `delay/`).
  - Sets up isolated subdirectories (`reports/`, `logs/`, `testresults/`).
  - Executes Modus inside the mode directory so that all outputs, databases (`tbdata/`), reports, and test vectors are stored separately.
- **Tcl Script (`runmodus.atpg.tcl`)**:
  - Contains strictly EDA ATPG command execution.
  - Zero directory creation or OS environment setup logic.

---

## Directory Structure

```text
atpg/
├── run_atpg.sh                      # Runner script: initializes mode workspace & runs Modus
├── runmodus.atpg.tcl                # Pure command execution ATPG script
├── cv32e40p_core.COMPRESSION.pinassign
├── stuck_at/                        # Isolated workspace for Stuck-At ATPG
│   ├── reports/
│   ├── logs/
│   ├── testresults/
│   │   ├── verilog_serial/
│   │   └── verilog_parallel/
│   └── tbdata/
└── delay/                           # Isolated workspace for Transition Delay ATPG
    ├── reports/
    ├── logs/
    ├── testresults/
    │   ├── verilog_serial/
    │   └── verilog_parallel/
    └── tbdata/
```

---

## Configuration

- **Technology Library**: Fixed standard cell Verilog model:
  ```tcl
  set TECH_LIB "/home/admin/DFT/Library/atpg/stdcell.v"
  ```
- **Netlist Source**: Directly uses the synthesized scan compressed netlist from the `scan/` directory:
  ```tcl
  set NETLIST "../../scan/netlists/cv32e40p_core_compressed.v"
  ```
- **Test Mode**: Exclusively **COMPRESSION** mode (`cv32e40p_core.COMPRESSION.pinassign`).

---

## How to Run

Execute from `atpg/`:

```bash
cd /home/vlsi/keyurd1998-sys/cv32e40p-DFT/atpg

# Run Stuck-At ATPG (default):
./run_atpg.sh stuck_at
# or simply:
./run_atpg.sh

# Run Transition Delay ATPG:
./run_atpg.sh delay
```

---

## Generated Reports & Outputs (Inside `stuck_at/` or `delay/`)

| Report / Artifact | File Location | Description |
| :--- | :--- | :--- |
| **Scan Structures** | `reports/test_structures.rpt` | Scan chains, compression channels, & masking |
| **Initial Faults** | `reports/<mode>_initial_faults.rpt` | Initial collapsed/uncollapsed fault universe |
| **Test Summary** | `reports/<mode>_test_summary.rpt` | Pattern count, cycle count, & efficiency |
| **Fault Coverage** | `reports/<mode>_fault_coverage.rpt` | Test coverage & fault classification breakdown |
| **Switching Activity** | `reports/<mode>_toggle_gram.rpt` | Scan shift and capture toggle rates |
| **Serial Vectors** | `testresults/verilog_serial/` | Tester-ready serial shift Verilog testbench |
| **Parallel Vectors** | `testresults/verilog_parallel/` | Fast register deposit Verilog testbench |
| **Execution Log** | `logs/runmodus_<mode>.log` | Complete Modus ATPG run log |
