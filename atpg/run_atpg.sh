#!/usr/bin/env bash
# ==============================================================================
# Modus ATPG Runner
# Initializes directory structure for stuck_at or delay to store results separately,
# then executes the pure Modus ATPG command script.
#
# Usage:
#   ./run_atpg.sh stuck_at    (or: ./run_atpg.sh)
#   ./run_atpg.sh delay
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="${1:-stuck_at}"

case "$MODE" in
    stuck|stuck_at|stuckat)
        MODE="stuck_at"
        ;;
    delay|transition)
        MODE="delay"
        ;;
    -h|--help|help)
        echo "Usage: $0 [stuck_at | delay]"
        echo ""
        echo "Options:"
        echo "  stuck_at   Run Stuck-At ATPG (default)"
        echo "  delay      Run Transition Delay ATPG"
        exit 0
        ;;
    *)
        echo "ERROR: Unknown mode '$MODE'. Valid modes: stuck_at, delay."
        exit 1
        ;;
esac

# ------------------------------------------------------------------------------
# 1. Initialize Directory Structure for Selected Mode
# ------------------------------------------------------------------------------
MODE_DIR="${SCRIPT_DIR}/${MODE}"
mkdir -p "${MODE_DIR}/reports" "${MODE_DIR}/logs" "${MODE_DIR}/testresults"

echo "=================================================================="
echo " Initialized Workspace: ${MODE_DIR}"
echo "   Reports:  ${MODE_DIR}/reports/"
echo "   Logs:     ${MODE_DIR}/logs/"
echo "   Vectors:  ${MODE_DIR}/testresults/"
echo "=================================================================="

# ------------------------------------------------------------------------------
# 2. Run Modus Inside Mode Directory
# ------------------------------------------------------------------------------
cd "${MODE_DIR}"
echo "==> Executing Modus ATPG for mode: ${MODE}..."
ATPG_MODE="${MODE}" modus -file "${SCRIPT_DIR}/runmodus.atpg.tcl" -log "logs/runmodus_${MODE}.log"

echo "=================================================================="
echo " ATPG Execution Finished for ${MODE}!"
echo " Reports: ${MODE_DIR}/reports/"
echo " Logs:    ${MODE_DIR}/logs/"
echo " Vectors: ${MODE_DIR}/testresults/"
echo "=================================================================="
