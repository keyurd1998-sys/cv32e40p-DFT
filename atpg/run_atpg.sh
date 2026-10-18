#!/usr/bin/env bash
set -e

MODE="${1:-stuck_at}"

mkdir -p "$MODE/reports" "$MODE/logs" "$MODE/testresults"
cd "$MODE"

ATPG_MODE="$MODE" modus -file ../runmodus.atpg.tcl -log "logs/runmodus_${MODE}.log"
