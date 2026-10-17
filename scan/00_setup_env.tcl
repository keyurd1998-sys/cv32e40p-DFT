set DESIGN "cv32e40p_core"

set SCAN_DIR     [file dirname [file normalize [info script]]]
set ROOT_DIR     [file normalize "$SCAN_DIR/.."]
set BLOCK_DIR    $ROOT_DIR

set DBS_DIR      "$SCAN_DIR/dbs"
set REPORTS_DIR  "$SCAN_DIR/reports"
set NETLISTS_DIR "$SCAN_DIR/netlists"
set LOGS_DIR     "$SCAN_DIR/logs"

set ATPG_DIR     "$ROOT_DIR/atpg"
set GLS_DIR      "$ROOT_DIR/gls"

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
# Fixed DFT Compression & Scan Channel Parameters
# - Analysis Ratios: 70 and 80
# - Insertion Ratio:  80
# - Scan Channels:    2 (fixed: scan_in_0/1, scan_out_0/1)
# ------------------------------------------------------------------------------
set COMPRESSION_RATIO 80
set ANALYSIS_RATIOS   [list 70 80]
set NUM_SCAN_CHANNELS 2
set NUM_SCAN_INS      2
set NUM_SCAN_OUTS     2

puts "=================================================================="
puts " DFT Configuration Parameters:"
puts "   Target Design:       $DESIGN"
puts "   Scan Channels:       $NUM_SCAN_CHANNELS (Fixed)"
puts "   Insertion Ratio:     $COMPRESSION_RATIO (Fixed)"
puts "   Analysis Ratios:     $ANALYSIS_RATIOS"
puts "=================================================================="
