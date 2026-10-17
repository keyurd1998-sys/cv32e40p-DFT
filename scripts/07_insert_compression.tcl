set SCRIPT_DIR [file dirname [file normalize [info script]]]
source "$SCRIPT_DIR/00_setup_env.tcl"

set STEP_RPT_DIR [file normalize "$REPORTS_DIR/07_compression"]
file mkdir $STEP_RPT_DIR
file mkdir $DBS_DIR

# Compression ratio setting (default 70, can be overridden by env variable)
if {[info exists ::env(COMPRESSION_RATIO)]} {
    set COMP_RATIO $::env(COMPRESSION_RATIO)
} else {
    set COMP_RATIO 70
}

read_db "$DBS_DIR/05_tpi.db"

# Configure test mode and scan chain attributes
define_test_mode -name test_mode -active high -create_port test_mode
set_db [current_design] .dft_mix_clock_edges_in_scan_chains true
set_db [current_design] .dft_lockup_element_type preferred_level_sensitive

# 1. Define Core Scan Chain (1 scan-in, 1 scan-out channel)
define_scan_chain -name chain0 -sdi scan_in -sdo scan_out -create_ports -shift_enable scan_en

# 2. Stitch scan chain
connect_scan_chains -auto_create_chains

# 3. Insert Scan Compression (Ratio $COMP_RATIO)
puts "INFO: Inserting Scan Compression on core chain0 (Ratio $COMP_RATIO)..."
compress_scan_chains \
    -chains [get_db actual_scan_chains chain0] \
    -ratio $COMP_RATIO \
    -compressor xor \
    -decompressor broadcast \
    -mask wide1 \
    -auto_create

# Post-compression DFT DRC and scan chain reports
check_dft_rules    > "$STEP_RPT_DIR/${DESIGN}_dft_rules.rpt"
report_scan_chains > "$STEP_RPT_DIR/${DESIGN}_scan_chains.rpt"

# Save checkpoint database
set DB_FILE [file normalize "$DBS_DIR/07_compressed.db"]
write_db -all_root_attributes -to_file $DB_FILE

puts "INFO: Step 7 compression insertion (Ratio $COMP_RATIO) completed. Checkpoint saved: $DB_FILE"
exit
