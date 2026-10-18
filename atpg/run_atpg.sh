#!/usr/bin/env bash
# ==============================================================================
# Modus ATPG Top-Level Runner (COMPRESSION Mode Only)
#
# Usage:
#   ./run_atpg.sh stuck_at [step | all]
#   ./run_atpg.sh delay [step | all]
#   ./run_atpg.sh all
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-help}"
STEP="${2:-all}"

print_help() {
    echo "Usage:"
    echo "  $0 stuck_at [1|2|3|4|all]   - Run Stuck-At ATPG (default: all steps)"
    echo "  $0 delay [1|2|3|4|all]      - Run Transition Delay ATPG (default: all steps)"
    echo "  $0 all                      - Run all steps for both Stuck-At and Delay"
    echo ""
    echo "4-Step Flow:"
    echo "  1: 01_build_model.tcl        - Build simulation model with fixed TECH_LIB"
    echo "  2: 02_verify_structures.tcl  - Build COMPRESSION testmode & verify scan structures"
    echo "  3: 03_run_atpg.tcl           - Build fault model, generate patterns & toggle gram"
    echo "  4: 04_write_vectors.tcl      - Export serial vectors & commit test database"
}

case "$TARGET" in
    stuck_at)
        echo "=== Running Stuck-At ATPG (COMPRESSION Mode) ==="
        (cd "$SCRIPT_DIR/stuck_at" && ./run_step.sh "$STEP")
        ;;
    delay)
        echo "=== Running Transition Delay ATPG (COMPRESSION Mode) ==="
        (cd "$SCRIPT_DIR/delay" && ./run_step.sh "$STEP")
        ;;
    all)
        echo "=== Running Stuck-At ATPG (COMPRESSION Mode) ==="
        (cd "$SCRIPT_DIR/stuck_at" && ./run_step.sh all)
        echo "=== Running Transition Delay ATPG (COMPRESSION Mode) ==="
        (cd "$SCRIPT_DIR/delay" && ./run_step.sh all)
        ;;
    help|-h|--help)
        print_help
        exit 0
        ;;
    *)
        echo "ERROR: Unknown command '$TARGET'."
        print_help
        exit 1
        ;;
esac
