# Scan Synthesis and Compression Flow

![Tool](https://img.shields.io/badge/Tool-Cadence%20Genus-007ACC)
![Scan Cells](https://img.shields.io/badge/Scan%20Cells-2%2C336-blue)
![Compression](https://img.shields.io/badge/Compression-80x-orange)
![Channels](https://img.shields.io/badge/Channels-2-informational)

## Overview
The scan flow performs logic synthesis, testability design rule check (TDRC) violation repair, scan flop replacement, ATPG-guided test point insertion (TPI), XOR scan compression insertion, and timing optimization for the CV32E40P RISC-V core using Cadence Genus.

## Flow Steps

- Step 1 (01_elaborate.tcl): RTL elaboration and library loading
- Step 2 (02_dft_setup_tdrc.tcl): Test clocks and test control signal definitions, pre-DFT DRC check
- Step 3 (03_scan_mapping.tcl): Generic synthesis and scan flip-flop mapping
- Step 4 (04_pre_tpi_compression_analysis.tcl): Baseline scan compressibility analysis (ratios 70 & 80)
- Step 5 (05_test_point_insertion.tcl): Modus ATPG-guided test point insertion and post-TPI logic optimization
- Step 6 (06_post_tpi_compression_analysis.tcl): Post-TPI compressibility analysis verifying coverage gains
- Step 7 (07_insert_compression.tcl): Scan chain stitching and 80x compression insertion with incremental timing optimization
- Step 8 (08_export.tcl): Netlist, SDC constraints, SCANDEF, and ATPG workspace export

## Execution Commands

Run all 8 steps in sequence:
```bash
./run_step.sh all
```

Run specific steps individually:
```bash
./run_step.sh 1
./run_step.sh 2 3
./run_step.sh 7 8
```

## Results Snippet

From post-DFT synthesis report (cv32e40p_core_qor.rpt):

```text
Instance Count:
    Leaf Instances:                 24,522
    Sequential Instances:            2,310
    Combinational Instances:        22,212
    Hierarchical Instances:            259

Area:
    Total Cell Area:             50,571.26
    Total Area (Cell+Net):      366,264.09

Scan Compression:
    Scan Channels:                       2 (scan_in_0/1, scan_out_0/1)
    Compression Ratio:                  80
    Architecture:        XOR compactor with wide-1 channel masking
    Total Scan Cells:                2,336 (including TPI control & observe flops)
```
