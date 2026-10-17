#!/usr/bin/env bash
# ==============================================================================
# Step-by-Step DFT Runner for cv32e40p_core
# Usage:
#   ./run_step.sh 1
#   ./run_step.sh 1 2 3
#   ./run_step.sh all
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

export CADENCE_DFT_LIB="/home/admin/DFT/Library"
mkdir -p logs reports dbs netlists atpg

if [ $# -eq 0 ] || [ "$1" = "help" ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: $0 <step_number(s) | all>"
    echo "Steps: 1 to 8"
    exit 0
fi

if ! command -v genus &> /dev/null; then
    echo "ERROR: 'genus' binary not found in PATH."
    exit 1
fi

run_step() {
    local step="$1"
    local script=""
    local desc=""

    case "$step" in
        1) script="01_elaborate.tcl";                     desc="Elaboration & Health Check" ;;
        2) script="02_dft_setup_tdrc.tcl";               desc="DFT Setup & Pre-DFT DRC" ;;
        3) script="03_scan_mapping.tcl";                 desc="Generic Synthesis & Scan Mapping" ;;
        4) script="04_pre_tpi_compression_analysis.tcl"; desc="Pre-TPI Compression Analysis (Ratios 50-80)" ;;
        5) script="05_test_point_insertion.tcl";         desc="Modus Test Point Insertion (TPI)" ;;
        6) script="06_post_tpi_compression_analysis.tcl";desc="Post-TPI Compression Analysis (Ratios 50-80)" ;;
        7) script="07_insert_compression.tcl";           desc="Scan Compression Insertion" ;;
        8) script="08_timing_and_atpg_export.tcl";       desc="Timing Analysis & ATPG Script Export" ;;
        *)
            echo "ERROR: Invalid step '$step'. Valid steps are 1 through 8, or 'all'."
            exit 1
            ;;
    esac

    local log="logs/${script%.tcl}.log"
    rm -f "${log}"* "${log%.log}.cmd"*

    echo "==> Step $step: $desc"
    genus -overwrite -f "scripts/$script" -log "$log"
    echo "==> Step $step completed. Log: $log"
}

for arg in "$@"; do
    if [ "$arg" = "all" ]; then
        for s in {1..8}; do
            run_step "$s"
        done
    else
        run_step "$arg"
    fi
done
