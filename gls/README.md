# Gate-Level Simulation (GLS) Flow

![Simulator](https://img.shields.io/badge/Simulator-Cadence%20Xcelium-007ACC)
![Stuck-At GLS](https://img.shields.io/badge/Stuck--At%20GLS-100%25%20Passed-brightgreen)
![Delay GLS](https://img.shields.io/badge/Delay%20GLS-100%25%20Passed-brightgreen)
![Miscompares](https://img.shields.io/badge/Miscompares-0-brightgreen)

## Overview
This directory contains the gate-level test pattern simulation flow using Cadence Xcelium (xrun). The simulation executes Modus-generated Verilog testbenches against the compressed gate-level netlist of the CV32E40P core to verify that test patterns operate correctly without unknown (X) states, timing races, or scan shifting errors.

## Simulation Modes

- Parallel Simulation: Directly forces flip-flop states via Verilog hierarchical references in 1 cycle. Runs in seconds for fast sanity checks.
- Serial Simulation: Shifts test bits through the primary scan pins cycle by cycle. Replicates exact physical ATE tester operations.

## Execution Commands

Run Stuck-At simulations:
```bash
./run_gls.sh parallel        # Fast parallel check (default)
./run_gls.sh serial          # Full serial shift simulation
```

Run Transition Delay simulations:
```bash
./run_gls.sh delay parallel  # Fast parallel check
./run_gls.sh delay serial    # Full serial shift simulation
```

## Simulation Results Snippets

From Xcelium simulation logs (gls/logs/):

### 1. Stuck-At Parallel Simulation (gls_stuck_at_parallel.log)
```text
Cumulative Results:
    Number of Files Simulated:           2
    Total Number of Cycles:          6,028
    Total Number of Tests:             998
      - Total Passed Tests:            998
      - Total Failed Tests:              0
    Total Number of Compares:    2,400,222
      - Total Good Compares:     2,400,222
      - Total Miscompares:               0

Status: 100% PASSED (0 miscompares)
Simulation Time: 6 seconds
```

### 2. Transition Delay Parallel Simulation (gls_delay_parallel.log)
```text
Cumulative Results:
    Number of Files Simulated:           2
    Total Number of Cycles:         15,580
    Total Number of Tests:           2,599
      - Total Passed Tests:          2,599
      - Total Failed Tests:              0
    Total Number of Compares:    5,595,647
      - Total Good Compares:     5,595,647
      - Total Miscompares:               0

Status: 100% PASSED (0 miscompares)
Simulation Time: 10 seconds
```
