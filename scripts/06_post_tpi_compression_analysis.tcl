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

# Define temporary scan chain for compression preview and analysis (including TPI flops)
define_scan_chain -name chain0 -sdi scan_in -sdo scan_out -create_ports -shift_enable scan_en
connect_scan_chains -auto_create_chains

# ------------------------------------------------------------------------------
# 1. Structural Compression Architecture Preview (Ratios 50, 60, 70, 80)
# ------------------------------------------------------------------------------
puts "=================================================================="
puts " Post-TPI Compression Previews (Ratios 50, 60, 70, 80):"
puts "=================================================================="
set rpt_fp [open "$STEP_RPT_DIR/${DESIGN}_post_tpi_preview.rpt" w]
foreach ratio {50 60 70 80} {
    puts "--- Ratio $ratio Preview ---"
    puts $rpt_fp "=================================================================="
    puts $rpt_fp " Post-TPI Compression Preview (Ratio $ratio):"
    puts $rpt_fp "=================================================================="
    compress_scan_chains \
        -chains [get_db actual_scan_chains chain0] \
        -ratio $ratio \
        -compressor xor \
        -decompressor broadcast \
        -mask wide1 \
        -auto_create \
        -preview
}
close $rpt_fp

# ------------------------------------------------------------------------------
# 2. ATPG-Guided Scan Compressibility Analysis (Coverage & TDVR with TPI)
# ------------------------------------------------------------------------------
puts "INFO: Running Post-TPI scan compressibility analysis across ratios 50, 60, 70, 80..."
analyze_scan_compressibility \
    -library $ATPG_LIB \
    -ratios "50 60 70 80" \
    -compression_method compress_scan_chains \
    -compressor xor \
    -decompressor broadcast \
    -mask wide1 \
    -directory $MODUS_WORK \
    -build_model_options "-allowmissingmodules yes" \
    -verbose

# Save checkpoint database
set DB_FILE [file normalize "$DBS_DIR/06_post_tpi_analyzed.db"]
write_db -all_root_attributes -to_file $DB_FILE

puts "INFO: Step 6 Post-TPI compression analysis completed. Checkpoint saved: $DB_FILE"
exit
