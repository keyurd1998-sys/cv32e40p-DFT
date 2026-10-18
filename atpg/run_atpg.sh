#!/usr/bin/env bash
# ==============================================================================
# Modus ATPG Runner
# Select ATPG mode at execution time from the command line:
#   ./run_atpg.sh stuck_at    (or: ./run_atpg.sh stuck)
#   ./run_atpg.sh delay       (or: ./run_atpg.sh transition)
#   ./run_atpg.sh both        (or: ./run_atpg.sh)
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

MODE="${1:-both}"

case "$MODE" in
    stuck|stuck_at|stuckat)
        MODE="stuck_at"
        ;;
    delay|transition)
        MODE="delay"
        ;;
    both|all)
        MODE="both"
        ;;
    -h|--help|help)
        echo "Usage: $0 [stuck_at | delay | both]"
        echo ""
        echo "Options:"
        echo "  stuck_at   Run only Stuck-At ATPG (COMPRESSION mode)"
        echo "  delay      Run only Transition Delay ATPG (COMPRESSION mode)"
        echo "  both       Run both Stuck-At and Transition Delay ATPG (default)"
        exit 0
        ;;
    *)
        echo "ERROR: Unknown mode '$MODE'. Valid modes are: stuck_at, delay, both."
        exit 1
        ;;
esac

echo "=================================================================="
echo " Executing Modus ATPG (Mode: $MODE)"
echo "=================================================================="

ATPG_MODE="$MODE" modus -file runmodus.atpg.tcl -log "runmodus_${MODE}.log"
