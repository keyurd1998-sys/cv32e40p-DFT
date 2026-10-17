# CV32E40P Core - Scan Compression & Test Point Insertion (Cadence Genus & Modus)

Complete, fully self-contained Design-for-Test (DFT) flow for the standalone OpenHW Group **CV32E40P** 32-bit RISC-V core (`cv32e40p_core`).

The architecture focuses exclusively on **Scan Compression** and **ATPG-Guided Test Point Insertion (TPI)**, featuring full pre-TPI and post-TPI compression analysis.

---

## Architecture Overview

1. **Standard Full-Scan Architecture:**
   - Scan flop replacement during technology mapping (`syn_map`).
   - Shared functional reset (`rst_ni`) and clock gating test control (`scan_cg_en_i`).
   - Dedicated primary test shift enable (`SCAN_ENABLE`).

2. **Pre-TPI Compression Analysis:**
   - Structural preview via `compress_scan_chains -preview` across compression ratios 50, 60, 70, 80.
   - ATPG-guided scan compressibility evaluation (`analyze_scan_compressibility`) measuring baseline coverage and test data volume reduction (TDVR).

3. **Modus ATPG-Guided Test Point Insertion (TPI):**
   - Modus fault analysis identifies up to 100 control and observe test points.
   - Inserted into the mapped netlist to resolve random-pattern resistant faults and eliminate compression bottlenecks.

4. **Post-TPI Compression Analysis:**
   - Evaluates compression configurations (ratios 50, 60, 70, 80) on the design with test points inserted.
   - Quantifies the test coverage boost, pattern count reduction, and compression scalability achieved by TPI.

5. **Final Scan Compression Insertion:**
   - Single scan-in (`scan_in`) and scan-out (`scan_out`) external channel.
   - Broadcast decompressor and XOR compressor with wide1 channel masking.
   - Configured with target ratio (default 70).

6. **Timing & ATPG Export:**
   - Post-DFT QoR and slack timing reports.
   - Exported compressed gate-level Verilog netlist (`netlists/cv32e40p_core_compressed.v`).
   - Automated export of Modus Compressed ATPG workspace (`atpg/compressed_atpg`).

---

## Repository Structure

```
cv32e40p-DFT/
├── run_step.sh                             # Step runner for Genus DFT flow (steps 1-8 or all)
├── filelists/
│   └── cv32e40p_core.flist                 # RTL filelist and include directories
├── constraints/
│   └── cv32e40p_core.sdc                   # Timing constraints
├── rtl/                                    # Self-contained core RTL files + include/ packages
│   └── include/                            # cv32e40p packages & fpnew_pkg.sv
├── bhv/                                    # Simulation clock gating cell (cv32e40p_sim_clock_gate.sv)
├── scripts/
│   ├── 00_setup_env.tcl                    # Environment paths and library configurations
│   ├── 01_elaborate.tcl                    # Step 1: RTL elaboration and health check
│   ├── 02_dft_setup_tdrc.tcl               # Step 2: Test clocks, scan enable & pre-DFT TDRC
│   ├── 03_scan_mapping.tcl                 # Step 3: Generic synthesis and scan flop mapping
│   ├── 04_pre_tpi_compression_analysis.tcl # Step 4: Pre-TPI compression preview & analysis (ratios 50-80)
│   ├── 05_test_point_insertion.tcl         # Step 5: Modus ATPG-guided test point insertion (max 100 TPs)
│   ├── 06_post_tpi_compression_analysis.tcl# Step 6: Post-TPI compression preview & analysis (ratios 50-80)
│   ├── 07_insert_compression.tcl           # Step 7: Scan compression insertion (Ratio 70)
│   └── 08_export.tcl                       # Step 8: Export reports, SDC, netlist, SCANDEF & ATPG
├── dbs/                                    # Saved Genus checkpoint databases (01 through 07)
├── logs/                                   # Execution logs for each step
├── reports/                                # TDRC, gate count, scan chain, preview, and timing reports
├── netlists/                               # Gate-level netlists
└── atpg/                                   # Modus ATPG workspaces
```

---

## Quick Start Guide

### Step 1: Run the DFT Flow in Genus
Run all steps from Elaboration to ATPG export:
```bash
./run_step.sh all
```
Or execute individual steps sequentially:
```bash
./run_step.sh 1    # Elaboration & Checkpoint 01_elaborated.db
./run_step.sh 2    # DFT Setup & Pre-DFT TDRC
./run_step.sh 3    # Generic Synthesis & Scan Mapping
./run_step.sh 4    # Pre-TPI Compression Analysis (Ratios 50, 60, 70, 80)
./run_step.sh 5    # Modus Test Point Insertion (TPI)
./run_step.sh 6    # Post-TPI Compression Analysis (Ratios 50, 60, 70, 80)
./run_step.sh 7    # Scan Compression Insertion (Ratio 70)
./run_step.sh 8    # Export Netlist, SDC, SCANDEF, Reports & Modus ATPG
```

### Step 2: Run ATPG in Cadence Modus
Once Step 8 completes:
```bash
# 1. Run Stuck-At ATPG:
cd atpg/stuck_at && modus -file runmodus.atpg.tcl

# 2. Run Transition Delay ATPG:
cd atpg/delay && modus -file runmodus.atpg.tcl
```
