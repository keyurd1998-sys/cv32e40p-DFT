#!/usr/bin/env bash
# ==============================================================================
# Gate-Level Simulation (GLS) Pattern Runner for cv32e40p_core (cv32e40p-DFT)
# Usage:
#   ./run_gls.sh                 # Default: Stuck-At, Parallel
#   ./run_gls.sh parallel        # Stuck-At, Parallel
#   ./run_gls.sh serial          # Stuck-At, Serial
#   ./run_gls.sh delay parallel  # Transition Delay, Parallel
#   ./run_gls.sh delay serial    # Transition Delay, Serial
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "$SCRIPT_DIR"

mkdir -p logs waves

# Parse arguments: mode (stuck_at / delay) and format (parallel / serial)
ATPG_MODE="stuck_at"
FORMAT="parallel"

for arg in "$@"; do
    case "$arg" in
        stuck_at) ATPG_MODE="stuck_at" ;;
        delay)    ATPG_MODE="delay" ;;
        parallel) FORMAT="parallel" ;;
        serial)   FORMAT="serial" ;;
        help|-h|--help)
            echo "Usage: $0 [stuck_at|delay] [parallel|serial]"
            echo "Defaults: stuck_at parallel"
            exit 0
            ;;
        *)
            echo "ERROR: Unknown option '$arg'."
            echo "Usage: $0 [stuck_at|delay] [parallel|serial]"
            exit 1
            ;;
    esac
done

NETLIST="${ROOT_DIR}/scan/netlists/cv32e40p_core_compressed.v"

if [ -n "${CADENCE_DFT_LIB:-}" ] && [ -f "${CADENCE_DFT_LIB}/atpg/stdcell.v" ]; then
    STDCELL_LIB="${CADENCE_DFT_LIB}/atpg/stdcell.v"
elif [ -f "/home/admin/DFT/Library/atpg/stdcell.v" ]; then
    STDCELL_LIB="/home/admin/DFT/Library/atpg/stdcell.v"
else
    echo "ERROR: Standard cell library stdcell.v not found."
    exit 1
fi

PAT_DIR="${ROOT_DIR}/atpg/${ATPG_MODE}/patterns/verilog_${FORMAT}"

if [ ! -d "$PAT_DIR" ]; then
    echo "ERROR: Pattern directory not found: $PAT_DIR"
    echo "Please run ATPG for $ATPG_MODE first."
    exit 1
fi

# Locate Modus mainsim testbench and testfiles
TB="$(ls "${PAT_DIR}"/VER.COMPRESSION.*.mainsim.v 2>/dev/null | head -n 1)"
TS1="$(ls "${PAT_DIR}"/VER.COMPRESSION.*.data.scan.*.verilog 2>/dev/null | head -n 1)"
TS2="$(ls "${PAT_DIR}"/VER.COMPRESSION.*.data.logic.*.verilog 2>/dev/null | head -n 1)"

if [ -z "$TB" ] || [ -z "$TS1" ] || [ -z "$TS2" ]; then
    echo "ERROR: Required pattern files not found in $PAT_DIR."
    exit 1
fi

LOG_FILE="logs/gls_${ATPG_MODE}_${FORMAT}.log"

echo "=================================================================="
echo " Starting Gate-Level Pattern Simulation (Cadence Xcelium)"
echo "   Mode:        $ATPG_MODE"
echo "   Format:      $FORMAT"
echo "   Netlist:     $NETLIST"
echo "   Stdcell:     $STDCELL_LIB"
echo "   Testbench:   $TB"
echo "   Log:         $LOG_FILE"
echo "=================================================================="

xrun \
  +access+rwc \
  +xm64bit \
  +xmtimescale+1ns/1ps \
  +xmoverride_timescale \
  +xmseq_udp_delay+2ps \
  +HEARTBEAT \
  +FAILSET \
  "+TESTFILE1=$TS1" \
  "+TESTFILE2=$TS2" \
  -v "$STDCELL_LIB" \
  "$NETLIST" \
  "$TB" \
  -l "$LOG_FILE"

echo "=================================================================="
echo " Simulation Finished! Review log: $LOG_FILE"
echo "=================================================================="
