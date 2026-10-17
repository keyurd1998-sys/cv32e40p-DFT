#!/usr/bin/env bash
# ==============================================================================
# Modus ATPG Runner for cv32e40p_core
# Usage:
#   ./run_atpg.sh stuck_at   # Run Stuck-At ATPG (runmodus.atpg.tcl)
#   ./run_atpg.sh delay      # Run Transition Delay ATPG (runmodus.atpg.tcl)
#   ./run_atpg.sh all        # Run both Stuck-At and Delay ATPG
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

mkdir -p logs reports

if [ $# -eq 0 ] || [ "$1" = "help" ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: $0 <stuck_at | delay | all>"
    echo ""
    echo "Runs Modus ATPG using scripts exported by Genus step 08_export.tcl"
    exit 0
fi

if ! command -v modus &> /dev/null; then
    echo "ERROR: 'modus' binary not found in PATH."
    exit 1
fi

run_atpg() {
    local mode="$1"
    local dir="$SCRIPT_DIR/$mode"
    local script="$dir/runmodus.atpg.tcl"
    local log="$SCRIPT_DIR/logs/${mode}.log"

    if [ ! -f "$script" ]; then
        echo "ERROR: ATPG script not found: $script"
        echo "Please run Genus DFT step 8 (08_export.tcl) first to generate the ATPG workspace."
        exit 1
    fi

    echo "==> Running Modus ATPG for $mode..."
    (cd "$dir" && modus -file runmodus.atpg.tcl -log "$log")
    echo "==> Completed Modus ATPG for $mode. Log: $log"
}

case "$1" in
    stuck_at)
        run_atpg stuck_at
        ;;
    delay)
        run_atpg delay
        ;;
    all)
        run_atpg stuck_at
        run_atpg delay
        ;;
    *)
        echo "ERROR: Unknown mode '$1'. Valid modes: stuck_at, delay, all."
        exit 1
        ;;
esac
