#!/usr/bin/env bash
# ==============================================================================
# Script: get_sources.sh
# Purpose: Fetch required RTL source files for CV32E40P core from GitHub
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${SCRIPT_DIR}/rtl_src/cv32e40p"
REPO_URL="https://github.com/openhwfoundation/cv32e40p.git"

echo "==> Checking CV32E40P RTL source files..."

if [ -d "${TARGET_DIR}/.git" ]; then
    echo "==> Source repository already exists at ${TARGET_DIR}."
    echo "==> Fetching latest changes..."
    git -C "${TARGET_DIR}" pull --ff-only || true
elif [ -d "${TARGET_DIR}" ]; then
    echo "==> Source directory exists at ${TARGET_DIR}."
else
    echo "==> Cloning cv32e40p from ${REPO_URL} into ${TARGET_DIR}..."
    mkdir -p "${SCRIPT_DIR}/rtl_src"
    git clone --depth 1 "${REPO_URL}" "${TARGET_DIR}"
fi

# Verify required files
REQUIRED_FILES=(
    "${TARGET_DIR}/rtl/include/cv32e40p_pkg.sv"
    "${TARGET_DIR}/rtl/include/cv32e40p_apu_core_pkg.sv"
    "${TARGET_DIR}/rtl/include/cv32e40p_fpu_pkg.sv"
    "${TARGET_DIR}/rtl/vendor/pulp_platform_fpnew/src/fpnew_pkg.sv"
    "${TARGET_DIR}/rtl/cv32e40p_core.sv"
    "${TARGET_DIR}/bhv/cv32e40p_sim_clock_gate.sv"
)

echo "==> Verifying essential RTL files..."
for f in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$f" ]; then
        echo "ERROR: Missing required file: $f"
        exit 1
    fi
done

echo "==> All required CV32E40P source files are verified and ready!"
