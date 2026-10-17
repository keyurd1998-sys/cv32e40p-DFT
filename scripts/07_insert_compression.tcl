set SCRIPT_DIR [file dirname [file normalize [info script]]]
source "$SCRIPT_DIR/00_setup_env.tcl"

set STEP_RPT_DIR [file normalize "$REPORTS_DIR/07_compression"]
file mkdir $STEP_RPT_DIR
file mkdir $DBS_DIR

read_db "$DBS_DIR/05_tpi.db"

# Configure test mode and scan chain attributes
define_test_mode -name test_mode -active high -create_port test_mode
set_db [current_design] .dft_mix_clock_edges_in_scan_chains true
set_db [current_design] .dft_lockup_element_type preferred_level_sensitive

# 1. Define Core Scan Chain(s) based on NUM_SCAN_CHANNELS
puts "INFO: Defining $NUM_SCAN_CHANNELS scan channel(s)..."
for {set i 0} {$i < $NUM_SCAN_CHANNELS} {incr i} {
    set sdi_name [expr {$NUM_SCAN_CHANNELS == 1 ? "scan_in" : "scan_in_${i}"}]
    set sdo_name [expr {$NUM_SCAN_CHANNELS == 1 ? "scan_out" : "scan_out_${i}"}]
    define_scan_chain -name "chain${i}" -sdi $sdi_name -sdo $sdo_name -create_ports -shift_enable scan_en
}

# 2. Stitch scan chain(s)
connect_scan_chains -auto_create_chains

# 3. Insert Scan Compression (Ratio $COMPRESSION_RATIO across $NUM_SCAN_CHANNELS channel(s))
puts "INFO: Inserting Scan Compression on $NUM_SCAN_CHANNELS channel(s) (Ratio $COMPRESSION_RATIO)..."
compress_scan_chains \
    -chains [get_db actual_scan_chains chain*] \
    -ratio $COMPRESSION_RATIO \
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

puts "INFO: Step 7 compression insertion (Ratio $COMPRESSION_RATIO, Channels $NUM_SCAN_CHANNELS) completed. Checkpoint saved: $DB_FILE"
exit
