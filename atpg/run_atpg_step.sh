#!/usr/bin/env bash
# ==============================================================================
# Step-by-Step Modus ATPG Runner for cv32e40p_core (COMPRESSION Mode)
# Usage:
#   ./run_atpg_step.sh [options] <step_number(s) | all>
#
# Options:
#   -m, --mode <stuck_at | delay>       Fault model (default: stuck_at)
#   -h, --help                          Show usage help
#
# Examples:
#   ./run_atpg_step.sh 1                # Step 1: Build Logic Model
#   ./run_atpg_step.sh 1 2 3            # Steps 1 to 3
#   ./run_atpg_step.sh all              # All steps 1 to 8 (Stuck-At)
#   ./run_atpg_step.sh -m delay all     # All steps 1 to 8 (Transition Delay)
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="${SCRIPT_DIR}/scripts"

FAULT_MODE="stuck_at"
TESTMODE="COMPRESSION"
STEPS=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        -m|--mode)
            FAULT_MODE="$2"
            shift 2
            ;;
        -h|--help|help)
            echo "Usage: $0 [options] <step_number(s) | all>"
            echo ""
            echo "Options:"
            echo "  -m, --mode <stuck_at | delay>       Fault model (default: stuck_at)"
            echo ""
            echo "Steps:"
            echo "  1: Build Logic Model (build_model)"
            echo "  2: Build Test Mode (build_testmode - COMPRESSION)"
            echo "  3: Verify Test Structures & TSV DRC (verify_test_structures)"
            echo "  4: Build Fault Model (build_faultmodel - Stuck-At or Delay)"
            echo "  5: Generate ATPG Test Patterns (create_logic_tests)"
            echo "  6: Toggle & Switching Activity Analysis (write_toggle_gram)"
            echo "  7: Export Test Vectors & Verilog Testbenches (write_vectors)"
            echo "  8: Commit Tests to Database (commit_tests)"
            echo ""
            echo "Examples:"
            echo "  $0 1"
            echo "  $0 1 2 3"
            echo "  $0 all"
            echo "  $0 -m delay all"
            exit 0
            ;;
        *)
            STEPS+=("$1")
            shift
            ;;
    esac
done

if [ ${#STEPS[@]} -eq 0 ]; then
    echo "ERROR: No step specified. Run '$0 --help' for usage."
    exit 1
fi

if ! command -v modus &> /dev/null; then
    echo "ERROR: 'modus' binary not found in PATH."
    exit 1
fi

WORK_DIR="${SCRIPT_DIR}/${FAULT_MODE}"
if [ ! -d "$WORK_DIR" ]; then
    echo "ERROR: Working directory not found: $WORK_DIR"
    exit 1
fi

mkdir -p "$WORK_DIR/logs" "$WORK_DIR/reports" "$WORK_DIR/testresults"

export MODUS_FAULT_TYPE="$FAULT_MODE"
export MODUS_TESTMODE="$TESTMODE"

echo "=================================================================="
echo " Starting Step-by-Step Modus ATPG"
echo " Target Design:    cv32e40p_core"
echo " Fault Mode:       $FAULT_MODE"
echo " Test Mode:        $TESTMODE"
echo " Working Dir:      $WORK_DIR"
echo "=================================================================="

run_single_step() {
    local step="$1"
    local script=""
    local desc=""

    case "$step" in
        1) script="01_build_model.tcl";        desc="Build Logic Model" ;;
        2) script="02_build_testmode.tcl";     desc="Build Test Mode ($TESTMODE)" ;;
        3) script="03_verify_structures.tcl";  desc="Verify Test Structures & TDRC" ;;
        4) script="04_build_faultmodel.tcl";   desc="Build Fault Model ($FAULT_MODE)" ;;
        5) script="05_create_tests.tcl";       desc="Generate Test Patterns" ;;
        6) script="06_analyze_power.tcl";      desc="Toggle & Switching Activity Analysis" ;;
        7) script="07_write_vectors.tcl";      desc="Export Serial & Parallel Vectors" ;;
        8) script="08_commit_tests.tcl";       desc="Commit Tests to Master Database" ;;
        *)
            echo "ERROR: Invalid step '$step'. Valid steps are 1 through 8, or 'all'."
            exit 1
            ;;
    esac

    local tcl_file="${SCRIPTS_DIR}/${script}"
    local log_file="${WORK_DIR}/logs/${script%.tcl}.log"
    rm -f "${log_file}"*

    echo "==> Step $step: $desc"
    (cd "$WORK_DIR" && modus -file "$tcl_file" -log "$log_file")
    echo "==> Step $step completed. Log: $log_file"
}

for arg in "${STEPS[@]}"; do
    if [ "$arg" = "all" ]; then
        for s in {1..8}; do
            run_single_step "$s"
        done
    else
        run_single_step "$arg"
    fi
done

echo "=================================================================="
echo " ATPG Execution Finished Successfully!"
echo " Reports: $WORK_DIR/reports/"
echo " Logs:    $WORK_DIR/logs/"
echo " Vectors: $WORK_DIR/testresults/verilog/"
echo "=================================================================="
