#!/usr/bin/env bash
# ==============================================================================
# Step-by-Step Genus DFT Runner for cv32e40p_core (Scan Insertion & Compression)
# Usage:
#   ./run_step.sh 1
#   ./run_step.sh 1 2 3
#   ./run_step.sh all
#
# Custom runtime configuration:
#   COMPRESSION_RATIO=80 NUM_SCAN_CHANNELS=2 ./run_step.sh all
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "$SCRIPT_DIR"

export CADENCE_DFT_LIB="/home/admin/DFT/Library"
export COMPRESSION_RATIO="${COMPRESSION_RATIO:-70}"
export NUM_SCAN_CHANNELS="${NUM_SCAN_CHANNELS:-1}"

mkdir -p logs reports dbs netlists "${ROOT_DIR}/atpg" "${ROOT_DIR}/gls"

if [ $# -eq 0 ] || [ "$1" = "help" ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: $0 <step_number(s) | all>"
    echo "Steps: 1 to 8"
    echo ""
    echo "Runtime options (set via environment variables):"
    echo "  COMPRESSION_RATIO   Target compression ratio (default: 70)"
    echo "  NUM_SCAN_CHANNELS   Number of scan-in and scan-out channels (default: 1)"
    echo ""
    echo "Examples:"
    echo "  ./run_step.sh all"
    echo "  COMPRESSION_RATIO=80 NUM_SCAN_CHANNELS=2 ./run_step.sh all"
    echo "  COMPRESSION_RATIO=60 ./run_step.sh 7"
    exit 0
fi

if ! command -v genus &> /dev/null; then
    echo "ERROR: 'genus' binary not found in PATH."
    exit 1
fi

echo "=================================================================="
echo " Starting CV32E40P Scan Synthesis Flow (Genus)"
echo " Configuration:"
echo "   - Compression Ratio: ${COMPRESSION_RATIO}"
echo "   - Scan Channels:     ${NUM_SCAN_CHANNELS} (Scan-in/out)"
echo "=================================================================="

run_step() {
    local step="$1"
    local script=""
    local desc=""

    case "$step" in
        1) script="01_elaborate.tcl";                     desc="Elaboration & Health Check" ;;
        2) script="02_dft_setup_tdrc.tcl";               desc="DFT Setup & Pre-DFT DRC" ;;
        3) script="03_scan_mapping.tcl";                 desc="Generic Synthesis & Scan Mapping" ;;
        4) script="04_pre_tpi_compression_analysis.tcl"; desc="Pre-TPI Compression Analysis" ;;
        5) script="05_test_point_insertion.tcl";         desc="Modus Test Point Insertion (TPI)" ;;
        6) script="06_post_tpi_compression_analysis.tcl";desc="Post-TPI Compression Analysis" ;;
        7) script="07_insert_compression.tcl";           desc="Scan Compression Insertion" ;;
        8) script="08_export.tcl";                       desc="Export Netlist, SDC, SCANDEF, Reports & ATPG" ;;
        *)
            echo "ERROR: Invalid step '$step'. Valid steps are 1 through 8, or 'all'."
            exit 1
            ;;
    esac

    local log="logs/${script%.tcl}.log"
    rm -f "${log}"* "${log%.log}.cmd"*

    echo "==> Step $step: $desc"
    genus -overwrite -f "$script" -log "$log"
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
