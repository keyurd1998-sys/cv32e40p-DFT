# Modus ATPG Flow

![Tool](https://img.shields.io/badge/Tool-Cadence%20Modus-007ACC)
![Stuck-At Test Coverage](https://img.shields.io/badge/Stuck--At%20Coverage-95.80%25-brightgreen)
![Dynamic Delay Coverage](https://img.shields.io/badge/Delay%20Coverage-87.73%25-green)
![ATPG Effectiveness](https://img.shields.io/badge/Effectiveness-98.61%25-brightgreen)
![Total Patterns](https://img.shields.io/badge/Total%20Patterns-4%2C147-blue)

## Overview
This directory contains the Cadence Modus ATPG flow for generating Stuck-At and Transition Delay test patterns targeting the compressed gate-level netlist of the CV32E40P core. The flow runs structural test verification (TSV rules), builds fault models, generates compact test patterns, and exports simulation testbenches and vectors.

## Execution Commands

Run Stuck-At ATPG:
```bash
./run_atpg.sh stuck_at
```

Run Transition Delay ATPG:
```bash
./run_atpg.sh delay
```

Run both ATPG modes:
```bash
./run_atpg.sh all
```

## Results Snippets

### 1. Stuck-At ATPG (stuck_at_fault_summary.rpt)
```text
Testmode Fault Statistics (COMPRESSION):
    Total Static Faults:            178,060
    Tested Faults:                  170,318
    Redundant Faults:                   279
    Untested Faults:                  7,463

Coverage Metrics:
    Static Test Coverage:            95.80%
    Static Fault Coverage:           95.62%
    Static ATPG Effectiveness:       95.82%

Pattern Summary:
    Total Test Sequences:               998
```

### 2. Transition Delay ATPG (delay_fault_summary.rpt)
```text
Testmode Dynamic Fault Statistics (COMPRESSION):
    Total Dynamic Faults:           168,668
    Tested Dynamic Faults:          147,866
    Redundant Faults:                   113
    Untested Faults:                 20,689

Coverage Metrics:
    Dynamic Test Coverage:           87.73%
    Dynamic Fault Coverage:          83.08%
    Dynamic ATPG Effectiveness:      97.44%
    Static Test Coverage:            98.54%

Pattern Summary:
    Total Test Sequences:             3,149
```

## Generated Outputs
- reports/: Detailed coverage tables, untested fault lists, and cycle statistics
- patterns/verilog_serial/: Serial cycle-by-cycle Verilog testbench and vectors
- patterns/verilog_parallel/: Parallel broadside Verilog testbench and vectors
