#!/usr/bin/env bash
# ==============================================================================
# Step-by-Step Modus Stuck-At ATPG Runner (COMPRESSION Mode)
# Usage:
#   ./run_step.sh 1
#   ./run_step.sh 1 2
#   ./run_step.sh all
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if [ $# -eq 0 ] || [ "$1" = "help" ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: $0 <step_number(s) | all>"
    echo "Steps:"
    echo "  1: 01_build_model.tcl        - Build Logic Model"
    echo "  2: 02_verify_structures.tcl  - Build COMPRESSION Testmode & Verify Structures"
    echo "  3: 03_run_atpg.tcl           - Build Fault Model & Generate Patterns"
    echo "  4: 04_write_vectors.tcl      - Export Serial Vectors & Commit Database"
    exit 0
fi

if ! command -v modus &> /dev/null; then
    echo "ERROR: 'modus' binary not found in PATH."
    exit 1
fi

run_step() {
    local s="$1"
    local f=""
    case "$s" in
        1) f="01_build_model.tcl" ;;
        2) f="02_verify_structures.tcl" ;;
        3) f="03_run_atpg.tcl" ;;
        4) f="04_write_vectors.tcl" ;;
        *) echo "ERROR: Invalid step '$s'. Valid steps are 1 to 4, or 'all'."; exit 1 ;;
    esac

    echo "==> Running Step $s: $f..."
    modus -file "$f" -log "${f%.tcl}.log"
    echo "==> Completed Step $s. Log: ${f%.tcl}.log"
}

for arg in "$@"; do
    if [ "$arg" = "all" ]; then
        for i in {1..4}; do run_step "$i"; done
    else
        run_step "$arg"
    fi
done
