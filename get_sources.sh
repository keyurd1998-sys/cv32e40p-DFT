#!/usr/bin/env bash
# ==============================================================================
# Script: get_sources.sh
# Purpose: Fetch ONLY required RTL source files for CV32E40P core from GitHub
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_URL="https://github.com/openhwfoundation/cv32e40p.git"

RTL_DIR="${SCRIPT_DIR}/rtl"
INC_DIR="${SCRIPT_DIR}/rtl/include"
BHV_DIR="${SCRIPT_DIR}/bhv"

# Exact list of required files
REQUIRED_PACKAGES=(
    "cv32e40p_pkg.sv"
    "cv32e40p_apu_core_pkg.sv"
    "cv32e40p_fpu_pkg.sv"
    "fpnew_pkg.sv"
)

REQUIRED_CORE_RTL=(
    "cv32e40p_alu.sv"
    "cv32e40p_alu_div.sv"
    "cv32e40p_aligner.sv"
    "cv32e40p_compressed_decoder.sv"
    "cv32e40p_controller.sv"
    "cv32e40p_cs_registers.sv"
    "cv32e40p_decoder.sv"
    "cv32e40p_int_controller.sv"
    "cv32e40p_ex_stage.sv"
    "cv32e40p_fifo.sv"
    "cv32e40p_hwloop_regs.sv"
    "cv32e40p_id_stage.sv"
    "cv32e40p_if_stage.sv"
    "cv32e40p_load_store_unit.sv"
    "cv32e40p_mult.sv"
    "cv32e40p_prefetch_buffer.sv"
    "cv32e40p_prefetch_controller.sv"
    "cv32e40p_obi_interface.sv"
    "cv32e40p_apu_disp.sv"
    "cv32e40p_popcnt.sv"
    "cv32e40p_ff_one.sv"
    "cv32e40p_sleep_unit.sv"
    "cv32e40p_register_file_ff.sv"
    "cv32e40p_core.sv"
)

REQUIRED_BHV=(
    "cv32e40p_sim_clock_gate.sv"
)

verify_sources() {
    local missing=0
    for f in "${REQUIRED_PACKAGES[@]}"; do
        if [ ! -f "${INC_DIR}/$f" ]; then
            echo "MISSING: ${INC_DIR}/$f"
            missing=1
        fi
    done
    for f in "${REQUIRED_CORE_RTL[@]}"; do
        if [ ! -f "${RTL_DIR}/$f" ]; then
            echo "MISSING: ${RTL_DIR}/$f"
            missing=1
        fi
    done
    for f in "${REQUIRED_BHV[@]}"; do
        if [ ! -f "${BHV_DIR}/$f" ]; then
            echo "MISSING: ${BHV_DIR}/$f"
            missing=1
        fi
    done
    return $missing
}

# If --check is given, only verify
if [ "${1:-}" = "--check" ]; then
    echo "==> Verifying existing RTL files..."
    if verify_sources; then
        echo "==> All required 29 RTL files are present and verified."
        exit 0
    else
        echo "ERROR: Some required files are missing. Run './get_sources.sh' to download them."
        exit 1
    fi
fi

echo "==> Fetching required CV32E40P RTL files from ${REPO_URL}..."

TMP_DIR="$(mktemp -d /tmp/cv32e40p_fetch_XXXXXX)"
trap 'rm -rf "${TMP_DIR}"' EXIT

git clone --depth 1 "${REPO_URL}" "${TMP_DIR}"

mkdir -p "${INC_DIR}" "${BHV_DIR}"

# 1. Copy required packages
cp "${TMP_DIR}/rtl/include/cv32e40p_pkg.sv" "${INC_DIR}/"
cp "${TMP_DIR}/rtl/include/cv32e40p_apu_core_pkg.sv" "${INC_DIR}/"
cp "${TMP_DIR}/rtl/include/cv32e40p_fpu_pkg.sv" "${INC_DIR}/"
cp "${TMP_DIR}/rtl/vendor/pulp_platform_fpnew/src/fpnew_pkg.sv" "${INC_DIR}/"

# 2. Copy required core RTL files
for f in "${REQUIRED_CORE_RTL[@]}"; do
    cp "${TMP_DIR}/rtl/$f" "${RTL_DIR}/"
done

# 3. Copy required clock gating simulation cell
for f in "${REQUIRED_BHV[@]}"; do
    cp "${TMP_DIR}/bhv/$f" "${BHV_DIR}/"
done

# Clean up any leftover rtl_src from previous clone
rm -rf "${SCRIPT_DIR}/rtl_src"

echo "==> Verifying copied files..."
if verify_sources; then
    total_files=$((${#REQUIRED_PACKAGES[@]} + ${#REQUIRED_CORE_RTL[@]} + ${#REQUIRED_BHV[@]}))
    total_size=$(du -ch "${INC_DIR}"/*.sv "${RTL_DIR}"/*.sv "${BHV_DIR}"/*.sv | tail -n 1 | awk '{print $1}')
    echo "==> Success: Retrieved all ${total_files} required files (${total_size} total). No extra repo files."
else
    echo "ERROR: Failed to retrieve all required files."
    exit 1
fi
