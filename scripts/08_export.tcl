set SCRIPT_DIR [file dirname [file normalize [info script]]]
source "$SCRIPT_DIR/00_setup_env.tcl"

set STEP_RPT_DIR [file normalize "$REPORTS_DIR/08_export"]
set ATPG_WORK    [file normalize "$ATPG_DIR/compressed_atpg"]

file mkdir $STEP_RPT_DIR
file mkdir $ATPG_WORK
file mkdir $NETLISTS_DIR
file mkdir $DBS_DIR
file mkdir [file normalize "$BLOCK_DIR/constraints"]

read_db "$DBS_DIR/07_compressed.db"

# ==============================================================================
# 1. Export All Required Reports
# ==============================================================================
puts "INFO: Generating comprehensive post-DFT reports..."

# 1.1 Timing & QoR Reports
check_timing_intent              > "$STEP_RPT_DIR/${DESIGN}_check_timing_intent.rpt"
report_timing -path_type summary > "$STEP_RPT_DIR/${DESIGN}_timing_summary.rpt"
report_timing -max_paths 50      > "$STEP_RPT_DIR/${DESIGN}_timing_paths.rpt"
report_timing -unconstrained     > "$STEP_RPT_DIR/${DESIGN}_timing_unconstrained.rpt"
report_qor                       > "$STEP_RPT_DIR/${DESIGN}_qor.rpt"

# 1.2 Area & Gate Breakdown Reports
report_area                      > "$STEP_RPT_DIR/${DESIGN}_area.rpt"
report_gates                     > "$STEP_RPT_DIR/${DESIGN}_gates.rpt"

# 1.3 Power Analysis Report
report_power                     > "$STEP_RPT_DIR/${DESIGN}_power.rpt"

# 1.4 Scan Chain & Compression Reports
report_scan_chains               > "$STEP_RPT_DIR/${DESIGN}_scan_chains.rpt"
report_scan_registers            > "$STEP_RPT_DIR/${DESIGN}_scan_registers.rpt"

# 1.5 DFT DRC Rules & Violations
check_dft_rules                  > "$STEP_RPT_DIR/${DESIGN}_dft_rules.rpt"
report_dft_violations            > "$STEP_RPT_DIR/${DESIGN}_dft_violations.rpt"

puts "=================================================================="
puts " Post-DFT QoR & Timing Summary:"
puts "=================================================================="
report_qor

# ==============================================================================
# 2. Export Post-DFT SDC Constraints
# ==============================================================================
set EXPORT_SDC [file normalize "$BLOCK_DIR/constraints/${DESIGN}_post_dft.sdc"]
write_sdc > $EXPORT_SDC
puts "INFO: Exported post-DFT SDC constraints: $EXPORT_SDC"

# ==============================================================================
# 3. Export Final Gate-Level Verilog Netlist
# ==============================================================================
set FINAL_NETLIST [file normalize "$NETLISTS_DIR/${DESIGN}_compressed.v"]
write_hdl > $FINAL_NETLIST
puts "INFO: Exported compressed netlist: $FINAL_NETLIST"

# ==============================================================================
# 4. Export SCANDEF for Physical Design (P&R)
# ==============================================================================
set SCANDEF_FILE [file normalize "$NETLISTS_DIR/${DESIGN}_compressed.scandef"]
write_scandef > $SCANDEF_FILE
puts "INFO: Exported SCANDEF file: $SCANDEF_FILE"

# ==============================================================================
# 5. Export Modus Compressed ATPG Workspace & Scripts
# ==============================================================================
puts "INFO: Generating Modus Compressed ATPG workspace and run scripts..."
write_dft_atpg \
    -directory $ATPG_WORK \
    -library $ATPG_LIB \
    -compression \
    -build_model_options "-allowmissingmodules yes" \
    -run_from_directory \
    -force

puts "INFO: Modus ATPG run script exported to: $ATPG_WORK/runmodus.atpg.tcl"

# ==============================================================================
# 6. Save Final Checkpoint Database
# ==============================================================================
set FINAL_DB [file normalize "$DBS_DIR/08_final.db"]
write_db -all_root_attributes -to_file $FINAL_DB
puts "INFO: Final post-export database saved: $FINAL_DB"

puts "=================================================================="
puts " Step 8 Export Completed Successfully!"
puts " Deliverables summary:"
puts "   - Reports:    $STEP_RPT_DIR/"
puts "   - SDC:        $EXPORT_SDC"
puts "   - Netlist:    $FINAL_NETLIST"
puts "   - SCANDEF:    $SCANDEF_FILE"
puts "   - ATPG:       $ATPG_WORK/runmodus.atpg.tcl"
puts "   - Checkpoint: $FINAL_DB"
puts "=================================================================="
exit
