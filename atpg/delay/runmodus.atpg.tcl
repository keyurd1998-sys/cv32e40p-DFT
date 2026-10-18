# ==============================================================================
# Cadence Modus ATPG Script - Transition Delay (COMPRESSION Mode Only)
# Target: cv32e40p_core
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Initialize Variables & Directories
# ------------------------------------------------------------------------------
set DESIGN   "cv32e40p_core"
set TECH_LIB "/home/admin/DFT/Library/atpg/stdcell.v"

set_db workdir .
set WORKDIR [get_db workdir]

set_option stdout summary
set ::env(CDS_LIC_REPORT) yes
set_db stop_on_severity error

set REPORTS_DIR     "$WORKDIR/reports"
set LOGS_DIR        "$WORKDIR/logs"
set TESTRESULTS_DIR "$WORKDIR/testresults"

file mkdir $REPORTS_DIR $LOGS_DIR $TESTRESULTS_DIR

# Safely back up existing test database if present
if {[file exists "$WORKDIR/tbdata"]} {
    file delete -force "$WORKDIR/tbdata.bak"
    file copy "$WORKDIR/tbdata" "$WORKDIR/tbdata.bak"
    puts "INFO: Previous database backed up to $WORKDIR/tbdata.bak"
}
file delete -force "$WORKDIR/tbdata"
file delete -force "$WORKDIR/testresults"

# ------------------------------------------------------------------------------
# 2. Build Logic Simulation Model
# ------------------------------------------------------------------------------
puts "INFO: Building logic simulation model..."
build_model \
    -cell $DESIGN \
    -techlib $TECH_LIB \
    -designsource "$WORKDIR/${DESIGN}.test_netlist.v" \
    -allowmissingmodules yes \
    -messagecounteach 100

# ------------------------------------------------------------------------------
# 3. Build Test Mode (COMPRESSION Only)
# ------------------------------------------------------------------------------
puts "INFO: Building COMPRESSION test mode..."
build_testmode \
    -testmode COMPRESSION \
    -assignfile "$WORKDIR/${DESIGN}.COMPRESSION.pinassign" \
    -modedef COMPRESSION

# ------------------------------------------------------------------------------
# 4. Report & Verify Test Structures (TSV Rules)
# ------------------------------------------------------------------------------
puts "INFO: Reporting test structures to $REPORTS_DIR/test_structures.rpt..."
report_test_structures \
    -testmode COMPRESSION \
    -reportscanchain all \
    -reportchannelio yes \
    -reportchannelmaskscanchain yes \
    -reportchannelmaskstate yes \
    > "$REPORTS_DIR/test_structures.rpt"

puts "INFO: Verifying test structures (TSV DRC check)..."
verify_test_structures \
    -messagecount TSV-016=10,TSV-024=10,TSV-315=10,TSV-027=10 \
    -testmode COMPRESSION

# ------------------------------------------------------------------------------
# 5. Build Fault Model (Transition Delay)
# ------------------------------------------------------------------------------
puts "INFO: Building Transition Delay fault model (-includedynamic yes)..."
build_faultmodel \
    -includedynamic yes

puts "INFO: Writing initial fault summary to $REPORTS_DIR/initial_faults.rpt..."
report_faults -summary > "$REPORTS_DIR/initial_faults.rpt"

# ------------------------------------------------------------------------------
# 6. ATPG - Transition Delay Test Generation (COMPRESSION)
# ------------------------------------------------------------------------------
puts "INFO: Generating Transition Delay ATPG patterns (LOC/LOS)..."
create_logic_delay_tests \
    -experiment cv32e40p_core_compression \
    -testmode COMPRESSION

puts "INFO: Generating supplementary logic tests for remaining faults..."
create_logic_tests \
    -experiment cv32e40p_core_compression \
    -append yes \
    -testmode COMPRESSION \
    -testscan no

# ------------------------------------------------------------------------------
# 7. Export Coverage & Test Summary Reports
# ------------------------------------------------------------------------------
puts "INFO: Writing test summary and fault coverage reports..."
report_tests \
    -experiment cv32e40p_core_compression \
    -testmode COMPRESSION \
    > "$REPORTS_DIR/test_summary.rpt"

report_faults -summary >> "$REPORTS_DIR/test_summary.rpt"

report_faults \
    -experiment cv32e40p_core_compression \
    -testmode COMPRESSION \
    > "$REPORTS_DIR/fault_coverage.rpt"

# ------------------------------------------------------------------------------
# 8. Switching Activity Analysis (Toggle-Gram / Power)
# ------------------------------------------------------------------------------
puts "INFO: Writing scan and capture switching activity report..."
write_toggle_gram \
    -experiment cv32e40p_core_compression \
    -testmode COMPRESSION \
    > "$REPORTS_DIR/toggle_gram.rpt"

# ------------------------------------------------------------------------------
# 9. Export Verilog Vectors for SERIAL Simulation
# ------------------------------------------------------------------------------
puts "INFO: Exporting serial Verilog simulation vectors to $TESTRESULTS_DIR/verilog..."
write_vectors \
    -inexperiment cv32e40p_core_compression \
    -testmode COMPRESSION \
    -language verilog \
    -scanformat serial \
    -exportdir "$TESTRESULTS_DIR/verilog"

# ------------------------------------------------------------------------------
# 10. Commit Tests to Master Database
# ------------------------------------------------------------------------------
puts "INFO: Committing experiment cv32e40p_core_compression to master database..."
commit_tests \
    -inexperiment cv32e40p_core_compression \
    -testmode COMPRESSION

# ------------------------------------------------------------------------------
# 11. Export Verilog Vectors for PARALLEL Simulation
# ------------------------------------------------------------------------------
puts "INFO: Exporting parallel Verilog simulation vectors to $TESTRESULTS_DIR/verilog_parallel..."
write_vectors \
    -inexperiment cv32e40p_core_compression \
    -testmode COMPRESSION \
    -language verilog \
    -scanformat parallel \
    -exportdir "$TESTRESULTS_DIR/verilog_parallel"

puts "=================================================================="
puts " Transition Delay ATPG Completed Successfully!"
puts " Reports: $REPORTS_DIR/"
puts " Serial Vectors:   $TESTRESULTS_DIR/verilog/"
puts " Parallel Vectors: $TESTRESULTS_DIR/verilog_parallel/"
puts "=================================================================="

exit
