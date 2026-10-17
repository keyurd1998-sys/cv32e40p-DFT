set SCRIPT_DIR [file dirname [file normalize [info script]]]
source "$SCRIPT_DIR/00_setup_env.tcl"

set STEP_RPT_DIR [file normalize "$REPORTS_DIR/08_atpg"]
set ATPG_WORK    [file normalize "$ATPG_DIR/compressed_atpg"]

file mkdir $STEP_RPT_DIR
file mkdir $ATPG_WORK
file mkdir $NETLISTS_DIR
file mkdir $DBS_DIR

read_db "$DBS_DIR/07_compressed.db"

# ------------------------------------------------------------------------------
# 1. Post-DFT Timing & QoR Analysis
# ------------------------------------------------------------------------------
set STEP_TIMING_DIR [file normalize "$REPORTS_DIR/08_timing"]
file mkdir $STEP_TIMING_DIR

puts "INFO: Running timing analysis on final compressed design..."
check_timing_intent              > "$STEP_TIMING_DIR/${DESIGN}_check_timing_intent.rpt"
report_timing -path_type summary > "$STEP_TIMING_DIR/${DESIGN}_timing_summary.rpt"
report_timing -max_paths 20      > "$STEP_TIMING_DIR/${DESIGN}_timing_paths.rpt"
report_timing -unconstrained     > "$STEP_TIMING_DIR/${DESIGN}_unconstrained.rpt"
report_qor                       > "$STEP_TIMING_DIR/${DESIGN}_qor.rpt"

puts "=================================================================="
puts " Post-DFT QoR & Timing Summary:"
puts "=================================================================="
report_qor

# ------------------------------------------------------------------------------
# 2. Export Final Compressed Gate-Level Verilog Netlist
# ------------------------------------------------------------------------------
set FINAL_NETLIST [file normalize "$NETLISTS_DIR/${DESIGN}_compressed.v"]
write_hdl > $FINAL_NETLIST
puts "INFO: Exported compressed netlist: $FINAL_NETLIST"

# ------------------------------------------------------------------------------
# 3. Export Modus Compressed ATPG Workspace
# ------------------------------------------------------------------------------
puts "INFO: Generating Modus Compressed ATPG scripts..."
write_dft_atpg \
    -directory $ATPG_WORK \
    -library $ATPG_LIB \
    -compression \
    -build_model_options "-allowmissingmodules yes" \
    -run_from_directory \
    -force

puts "INFO: Modus ATPG run script exported to: $ATPG_WORK/runmodus.atpg.tcl"
puts "INFO: To run ATPG with Modus:"
puts "INFO:   cd $ATPG_WORK && modus -file runmodus.atpg.tcl"
puts "INFO: Step 8 Timing analysis and ATPG script export completed successfully."
exit
