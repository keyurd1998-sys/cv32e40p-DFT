set SCRIPT_DIR [file dirname [file normalize [info script]]]
source "$SCRIPT_DIR/00_setup_env.tcl"

set STEP_RPT_DIR [file normalize "$REPORTS_DIR/06_post_tpi_compression"]
set MODUS_WORK   [file normalize "$STEP_RPT_DIR/modus_compressibility"]
file mkdir $STEP_RPT_DIR
file mkdir $MODUS_WORK
file mkdir $DBS_DIR

read_db "$DBS_DIR/05_tpi.db"

# Define test control mode and configure scan chain attributes
define_test_mode -name test_mode -active high -create_port test_mode
set_db [current_design] .dft_mix_clock_edges_in_scan_chains true
set_db [current_design] .dft_lockup_element_type preferred_level_sensitive

# Define 2 scan channels for Post-TPI analysis (including TPI flops)
puts "INFO: Defining 2 scan channels (chain0: scan_in_0/scan_out_0, chain1: scan_in_1/scan_out_1) for Post-TPI analysis..."
define_scan_chain -name chain0 -sdi scan_in_0 -sdo scan_out_0 -create_ports -shift_enable scan_en
define_scan_chain -name chain1 -sdi scan_in_1 -sdo scan_out_1 -create_ports -shift_enable scan_en
connect_scan_chains -auto_create_chains

# ------------------------------------------------------------------------------
# ATPG-Guided Scan Compressibility Analysis (Coverage & TDVR with TPI, Ratios 70 & 80)
# ------------------------------------------------------------------------------
puts "INFO: Running Post-TPI scan compressibility analysis across ratios 70 and 80..."
analyze_scan_compressibility \
    -library $ATPG_LIB \
    -ratios {70 80} \
    -compression_method compress_scan_chains \
    -compressor xor \
    -decompressor broadcast \
    -mask wide1 \
    -directory $MODUS_WORK \
    -build_model_options "-allowmissingmodules yes" \
    -verbose

# ------------------------------------------------------------------------------
# Reports Generation
# ------------------------------------------------------------------------------
report_scan_compressibility -directory $MODUS_WORK > "$STEP_RPT_DIR/${DESIGN}_compressibility_analysis.rpt"
check_dft_rules                                   > "$STEP_RPT_DIR/${DESIGN}_dft_rules.rpt"
report_scan_chains                                > "$STEP_RPT_DIR/${DESIGN}_scan_chains.rpt"

# Save checkpoint database
set DB_FILE [file normalize "$DBS_DIR/06_post_tpi_analyzed.db"]
write_db -all_root_attributes -to_file $DB_FILE

puts "INFO: Step 6 Post-TPI compression analysis completed. Checkpoint saved: $DB_FILE"
exit
