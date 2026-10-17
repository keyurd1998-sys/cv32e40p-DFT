set DESIGN "cv32e40p_core"

set SCRIPTS_DIR  [file dirname [file normalize [info script]]]
set BLOCK_DIR    [file normalize "$SCRIPTS_DIR/.."]

set DBS_DIR      "$BLOCK_DIR/dbs"
set REPORTS_DIR  "$BLOCK_DIR/reports"
set NETLISTS_DIR "$BLOCK_DIR/netlists"
set LOGS_DIR     "$BLOCK_DIR/logs"
set ATPG_DIR     "$BLOCK_DIR/atpg"

set LIB_DIR "/home/admin/DFT/Library"
set TIMING_LIB "$LIB_DIR/timing/slow.lib"
set LEF_FILE   "$LIB_DIR/lef/all.lef"
set ATPG_LIB   "$LIB_DIR/atpg/stdcell.v"

set FLIST    "$BLOCK_DIR/filelists/cv32e40p_core.flist"
set SDC_FILE "$BLOCK_DIR/constraints/cv32e40p_core.sdc"

set RTL_DIR  "$BLOCK_DIR/rtl"
set BHV_DIR  "$BLOCK_DIR/bhv"

if {![file exists "$RTL_DIR/cv32e40p_core.sv"]} {
    puts "ERROR: CV32E40P RTL source files not found under $RTL_DIR."
    exit 1
}

# ------------------------------------------------------------------------------
# User-Configurable Compression & Scan Channel Parameters
# Can be overridden at execution time via shell environment variables:
#   COMPRESSION_RATIO=80 NUM_SCAN_CHANNELS=2 ./run_step.sh 7
# ------------------------------------------------------------------------------
if {[info exists ::env(COMPRESSION_RATIO)]} {
    set COMPRESSION_RATIO $::env(COMPRESSION_RATIO)
} else {
    set COMPRESSION_RATIO 70
}

if {[info exists ::env(NUM_SCAN_CHANNELS)]} {
    set NUM_SCAN_CHANNELS $::env(NUM_SCAN_CHANNELS)
} else {
    set NUM_SCAN_CHANNELS 1
}

set NUM_SCAN_INS  $NUM_SCAN_CHANNELS
set NUM_SCAN_OUTS $NUM_SCAN_CHANNELS

puts "=================================================================="
puts " DFT Configuration Parameters:"
puts "   Target Design:     $DESIGN"
puts "   Compression Ratio: $COMPRESSION_RATIO"
puts "   Scan In Channels:  $NUM_SCAN_INS"
puts "   Scan Out Channels: $NUM_SCAN_OUTS"
puts "=================================================================="
