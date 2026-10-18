#!/usr/bin/env bash
set -e

MODE="${1:-stuck_at}"

rm -rf "$MODE/logs" "$MODE/reports" "$MODE/patterns" "$MODE/testresults" "$MODE/tbdata"
mkdir -p "$MODE/reports" "$MODE/logs" "$MODE/patterns" "$MODE/testresults"
cd "$MODE"

ATPG_MODE="$MODE" modus -file ../atpg.tcl -log "logs/runmodus_${MODE}.log"
