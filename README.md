# CV32E40P Core - Advanced DFT Flow (Cadence Genus & Modus)

Complete, automated Design-for-Test (DFT) flow for the standalone OpenHW Group **CV32E40P** 32-bit RISC-V core (`cv32e40p_core`).

---

## Architecture Overview

1. **IEEE 1500 Test Wrapper Architecture:**
   - Wrapper Serial Control (WSC) ports: `SERIAL_WRCK`, `ShiftWR`, `UpdateWR`, `WIR_SEL`, `WRSTN`, `WSI`, `WSO`, `WIR_TEST`.
   - Internal decoded instructions: `WINT` (internal test), `WEXT` (external test), `SERIAL`, `BYPASS`.
   - Dedicated Wrapper Cells (DWC) on 359 functional core boundary pins.
   - Separate dedicated wrapper scan chain (`wrap_chain`) stitched from `WSI` to `WSO`.

2. **On-Chip Clock Generation (OCC / OPCG):**
   - Spliced at clock input buffer (`BUFX12` on `clk_i`).
   - Generates at-speed launch-off-capture (LOC) and launch-off-shift (LOS) double pulses for transition delay testing.
   - Separate test clocks: `scan_clk` (shift clock) and `opcg_load_clk`.

3. **Modus ATPG-Guided Test Point Insertion (TPI):**
   - Modus fault analysis identifies up to 100 control and observe test points.
   - Inserted prior to compression to resolve random-pattern resistant faults.

4. **Scan Compression:**
   - Cadence broadcast decompressor and XOR compressor with Ratio 70.
   - Dedicated compression on internal core logic (`chain0`), keeping IEEE 1500 wrapper chain uncompressed.

5. **Timing & ATPG Export:**
   - Post-DFT QoR and path slack timing reports.
   - Exported compressed gate-level Verilog netlist (`netlists/cv32e40p_core_compressed.v`).
   - Auto-generated Modus Stuck-At (`atpg/stuck_at`) and Transition Delay (`atpg/delay`) workspaces.

---

## Repository Structure

```
cv32e40p-DFT/
├── get_sources.sh                  # Clones and verifies CV32E40P RTL from OpenHW Group
├── run_step.sh                     # Step runner for Genus DFT flow (steps 1-8 or all)
├── filelists/
│   └── cv32e40p_core.flist         # RTL filelist and include directories
├── constraints/
│   └── cv32e40p_core.sdc           # Timing constraints
├── scripts/
│   ├── 00_setup_env.tcl            # Environment paths and library configurations
│   ├── 01_elaborate.tcl            # Step 1: RTL elaboration and health check
│   ├── 02_dft_setup_tdrc.tcl       # Step 2: Test clocks, IEEE 1500 WIR setup & pre-DFT TDRC
│   ├── 03_scan_mapping.tcl         # Step 3: Generic synthesis and scan flop mapping
│   ├── 04_insert_opcg.tcl          # Step 4: On-chip clock generation (OCC/OPCG) insertion
│   ├── 05_insert_dedicated_wrapper.tcl # Step 5: Dedicated wrapper cells (359 DWCs)
│   ├── 06_test_point_insertion.tcl # Step 6: Modus ATPG-guided test point insertion
│   ├── 07_insert_compression.tcl   # Step 7: Ratio 70 scan compression insertion
│   └── 08_timing_and_atpg_export.tcl # Step 8: Post-DFT timing & Modus ATPG script export
├── rtl_src/                        # Cloned RTL sources (downloaded via get_sources.sh)
├── dbs/                            # Saved Genus checkpoint databases (01 through 07)
├── logs/                           # Execution logs for each step
├── reports/                        # TDRC, gate count, scan chain, and timing reports
├── netlists/                       # Gate-level netlists
└── atpg/                           # Modus ATPG workspaces (stuck-at and transition delay)
```

---

## Quick Start Guide

### Step 1: Fetch RTL Sources
Run the automated source fetcher script to clone the official CV32E40P repository from OpenHW Group:
```bash
./get_sources.sh
```

### Step 2: Run the DFT Flow
Run all steps from Elaboration to ATPG export:
```bash
./run_step.sh all
```
Or execute individual steps sequentially:
```bash
./run_step.sh 1    # Elaboration & Checkpoint 01_elaborated.db
./run_step.sh 2    # DFT Setup, IEEE 1500 WIR & TDRC
./run_step.sh 3    # Generic Synthesis & Scan Mapping
./run_step.sh 4    # OPCG / OCC Insertion
./run_step.sh 5    # IEEE 1500 Dedicated Wrapper Cell (DWC) Insertion
./run_step.sh 6    # Modus Test Point Insertion (TPI)
./run_step.sh 7    # Ratio 70 Scan Compression
./run_step.sh 8    # Timing Analysis & Modus ATPG Export
```

### Step 3: Run ATPG in Cadence Modus
Once Step 8 completes:
```bash
# Run Stuck-At ATPG:
cd atpg/stuck_at && modus -file runmodus.atpg.tcl

# Run Transition Delay (At-Speed OCC) ATPG:
cd atpg/delay && modus -file runmodus.atpg.tcl
```
