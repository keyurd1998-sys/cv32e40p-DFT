#!/usr/bin/env bash
# ==============================================================================
# Gate-Level Simulation (GLS) Runner for cv32e40p_core
# Usage:
#   ./run_gls.sh [testbench.v]
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "$SCRIPT_DIR"

mkdir -p logs waves

NETLIST="${ROOT_DIR}/scan/netlists/cv32e40p_core_compressed.v"
STDCELL_LIB="/home/admin/DFT/Library/atpg/stdcell.v"

if [ ! -f "$NETLIST" ]; then
    echo "ERROR: Post-scan compressed netlist not found: $NETLIST"
    echo "Please run the scan synthesis flow (scan/08_export.tcl) first."
    exit 1
fi

TB="${1:-tb/cv32e40p_core_tb.v}"

echo "=================================================================="
echo " Starting Gate-Level Simulation (GLS)"
echo " Netlist:     $NETLIST"
echo " Stdcell Lib: $STDCELL_LIB"
echo " Testbench:   $TB"
echo "=================================================================="

if command -v xrun &> /dev/null; then
    echo "INFO: Running simulation with Cadence Xcelium (xrun)..."
    xrun -64bit -v "$STDCELL_LIB" "$NETLIST" "$TB" \
         -timescale 1ns/1ps \
         -access +rwc \
         -log logs/xrun_gls.log
elif command -v vcs &> /dev/null; then
    echo "INFO: Running simulation with Synopsys VCS..."
    vcs -full64 -sverilog -v "$STDCELL_LIB" "$NETLIST" "$TB" -l logs/vcs_gls.log -o simv
    ./simv
elif command -v iverilog &> /dev/null; then
    echo "INFO: Running simulation with Icarus Verilog..."
    iverilog -g2012 -o gls_sim "$STDCELL_LIB" "$NETLIST" "$TB"
    vvp gls_sim -l logs/iverilog_gls.log
else
    echo "NOTE: No Verilog simulator (xrun, vcs, or iverilog) found in PATH."
    echo "Please ensure Cadence Xcelium (xrun) is loaded in your environment."
    exit 1
fi

echo "==> GLS simulation finished."
