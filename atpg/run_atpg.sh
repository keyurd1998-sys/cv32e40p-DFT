#!/usr/bin/env bash
# ==============================================================================
# Modus ATPG Runner
# Select ATPG mode at execution time from the command line:
#   ./run_atpg.sh stuck_at    (or: ./run_atpg.sh)
#   ./run_atpg.sh delay
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

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
        echo "  stuck_at   Run Stuck-At ATPG (COMPRESSION mode, default)"
        echo "  delay      Run Transition Delay ATPG (COMPRESSION mode)"
        exit 0
        ;;
    *)
        echo "ERROR: Unknown mode '$MODE'. Valid modes are: stuck_at, delay."
        exit 1
        ;;
esac

echo "=================================================================="
echo " Executing Modus ATPG (Mode: $MODE)"
echo "=================================================================="

ATPG_MODE="$MODE" modus -file runmodus.atpg.tcl -log "runmodus_${MODE}.log"
