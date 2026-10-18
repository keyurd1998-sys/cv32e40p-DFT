# CV32E40P DFT Implementation and Verification

![Synthesis](https://img.shields.io/badge/Synthesis-Cadence%20Genus-007ACC)
![ATPG](https://img.shields.io/badge/ATPG-Cadence%20Modus-007ACC)
![GLS](https://img.shields.io/badge/GLS-Cadence%20Xcelium-007ACC)
![Stuck-At Coverage](https://img.shields.io/badge/Stuck--At%20Coverage-95.80%25-brightgreen)
![Delay Coverage](https://img.shields.io/badge/Delay%20Coverage-87.73%25-green)
![GLS Verification](https://img.shields.io/badge/GLS%20Status-100%25%20Passed-brightgreen)
![Compression](https://img.shields.io/badge/Compression-80x-orange)
![Channels](https://img.shields.io/badge/Channels-2-informational)

## Overview
This project implements an end-to-end Design-for-Test (DFT) flow for the CV32E40P RISC-V 32-bit core. The flow covers RTL elaboration, testability design rule check (TDRC) repair, scan flip-flop mapping, ATPG-guided test point insertion (TPI), XOR-based scan compression, ATPG pattern generation, and gate-level pattern simulation using Cadence tools.

## Tools Used
- Synthesis & DFT: Cadence Genus 25.10
- ATPG: Cadence Modus 25.10
- Simulation: Cadence Xcelium (xrun) 25.09
- Library: Standard Cell 45nm / Generic DFT Library

## Execution Flow

1. Scan Synthesis and Compression:
```bash
cd scan
./run_step.sh all
```

2. ATPG Pattern Generation:
```bash
cd ../atpg
./run_atpg.sh stuck_at
./run_atpg.sh delay
```

3. Gate-Level Pattern Simulation:
```bash
cd ../gls
./run_gls.sh parallel
./run_gls.sh delay parallel
```

## Key Results Summary

### Synthesis and DFT Quality of Results
- Sequential Instances: 2,310 core flip-flops (2,336 total scan cells with TPI registers)
- Total Leaf Instances: 24,522 gates
- Scan Compression Architecture: 2 scan channels, 80x compression ratio, XOR compactor with wide-1 channel masking
- Design Rule Violations: 0 testability violations

### ATPG Coverage Results
- Stuck-At Test Coverage: 95.80% (Fault Coverage: 95.62%, ATPG Effectiveness: 95.82%)
- Stuck-At Tested Faults: 170,318 out of 178,060 testmode faults (998 tests)
- Transition Delay Dynamic Test Coverage: 87.73% (Static Test Coverage: 98.54%, Dynamic ATPG Effectiveness: 97.44%)
- Transition Delay Tested Faults: 147,866 dynamic faults (2,599 logic delay tests)

### Gate-Level Simulation Verification
- Stuck-At Pattern Simulation: 998 tests passed, 0 failed, 2,400,222 compares, 0 miscompares (100% pass)
- Transition Delay Pattern Simulation: 2,599 tests passed, 0 failed, 5,595,647 compares, 0 miscompares (100% pass)
