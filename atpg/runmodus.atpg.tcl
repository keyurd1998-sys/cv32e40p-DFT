# ==============================================================================
# Cadence Modus ATPG Script (COMPRESSION Mode Only)
# Target Design: cv32e40p_core
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. ATPG Mode Selection: "stuck_at", "delay", or "both"
# ------------------------------------------------------------------------------
set ATPG_MODE "both"
if {[info exists ::env(ATPG_MODE)]} {
    set ATPG_MODE $::env(ATPG_MODE)
}

# ------------------------------------------------------------------------------
# 2. Initialize Variables & Work Directory
# ------------------------------------------------------------------------------
set DESIGN   "cv32e40p_core"
set TECH_LIB "/home/admin/DFT/Library/atpg/stdcell.v"

set_db workdir .
set WORKDIR [get_db workdir]

# Netlist referenced directly from scan directory
set NETLIST   "$WORKDIR/../scan/netlists/cv32e40p_core_compressed.v"
set PINASSIGN "$WORKDIR/${DESIGN}.COMPRESSION.pinassign"

set_option stdout summary
set ::env(CDS_LIC_REPORT) yes
set_db stop_on_severity error

set REPORTS_DIR     "$WORKDIR/reports"
set LOGS_DIR        "$WORKDIR/logs"
set TESTRESULTS_DIR "$WORKDIR/testresults"

file mkdir $REPORTS_DIR $LOGS_DIR $TESTRESULTS_DIR

# Clean previous database for fresh execution
file delete -force "$WORKDIR/tbdata"
file delete -force "$WORKDIR/testresults"

puts "=================================================================="
puts " Starting Modus ATPG for $DESIGN (COMPRESSION Mode)"
puts "   Selected ATPG Mode: $ATPG_MODE"
puts "   Technology Library: $TECH_LIB"
puts "   Design Netlist:     $NETLIST"
puts "   Pin Assignment:     $PINASSIGN"
puts "   Reports Directory:  $REPORTS_DIR"
puts "   Results Directory:  $TESTRESULTS_DIR"
puts "=================================================================="

# ------------------------------------------------------------------------------
# 3. Build Logic Simulation Model
# ------------------------------------------------------------------------------
puts "INFO: Building Boolean logic simulation model..."
build_model \
    -cell $DESIGN \
    -techlib $TECH_LIB \
    -designsource $NETLIST \
    -allowmissingmodules yes \
    -messagecounteach 100

# ------------------------------------------------------------------------------
# 4. Build Test Mode (COMPRESSION Only)
# ------------------------------------------------------------------------------
puts "INFO: Building COMPRESSION test mode..."
build_testmode \
    -testmode COMPRESSION \
    -assignfile $PINASSIGN \
    -modedef COMPRESSION

# ------------------------------------------------------------------------------
# 5. Report & Verify Test Structures (TSV Rules)
# ------------------------------------------------------------------------------
puts "INFO: Reporting test structures to $REPORTS_DIR/test_structures.rpt..."
report_test_structures \
    -testmode COMPRESSION \
    -reportscanchain all \
    -reportchannelio yes \
    -reportchannelmaskscanchain yes \
    -reportchannelmaskstate yes \
    > "$REPORTS_DIR/test_structures.rpt"

puts "INFO: Verifying test structures (TSV structural DRC check)..."
verify_test_structures \
    -messagecount TSV-016=10,TSV-024=10,TSV-315=10,TSV-027=10 \
    -testmode COMPRESSION

# ==============================================================================
# 6. PART A: STUCK-AT ATPG & VECTOR GENERATION
# ==============================================================================
if {$ATPG_MODE == "stuck_at" || $ATPG_MODE == "both"} {
    puts "\n=================================================================="
    puts " Starting Part A: Stuck-At ATPG"
    puts "=================================================================="

    # 6.1 Build Stuck-At Fault Model
    puts "INFO: Building Stuck-At fault model..."
    build_faultmodel \
        -includedynamic no

    puts "INFO: Writing initial Stuck-At fault summary..."
    report_faults -summary > "$REPORTS_DIR/stuck_at_initial_faults.rpt"

    # 6.2 Generate Deterministic Stuck-At Patterns
    puts "INFO: Generating Stuck-At ATPG test patterns..."
    create_logic_tests \
        -experiment cv32e40p_core_stuck_at \
        -testmode COMPRESSION

    # 6.3 Export Stuck-At Test Summary & Fault Coverage Reports
    puts "INFO: Writing Stuck-At test summary and coverage reports..."
    report_tests \
        -experiment cv32e40p_core_stuck_at \
        -testmode COMPRESSION \
        > "$REPORTS_DIR/stuck_at_test_summary.rpt"

    report_faults -summary >> "$REPORTS_DIR/stuck_at_test_summary.rpt"

    report_faults \
        -experiment cv32e40p_core_stuck_at \
        -testmode COMPRESSION \
        > "$REPORTS_DIR/stuck_at_fault_coverage.rpt"

    # 6.4 Scan and Capture Switching Activity (Power Analysis)
    puts "INFO: Writing Stuck-At switching activity (toggle-gram) report..."
    write_toggle_gram \
        -experiment cv32e40p_core_stuck_at \
        -testmode COMPRESSION \
        > "$REPORTS_DIR/stuck_at_toggle_gram.rpt"

    # 6.5 Export Serial Verilog Test Vectors
    puts "INFO: Exporting serial Verilog vectors for Stuck-At..."
    write_vectors \
        -inexperiment cv32e40p_core_stuck_at \
        -testmode COMPRESSION \
        -language verilog \
        -scanformat serial \
        -exportdir "$TESTRESULTS_DIR/stuck_at/verilog_serial"

    # 6.6 Export Parallel Verilog Test Vectors
    puts "INFO: Exporting parallel Verilog vectors for Stuck-At..."
    write_vectors \
        -inexperiment cv32e40p_core_stuck_at \
        -testmode COMPRESSION \
        -language verilog \
        -scanformat parallel \
        -exportdir "$TESTRESULTS_DIR/stuck_at/verilog_parallel"

    # 6.7 Commit Stuck-At Tests to Master Database
    puts "INFO: Committing Stuck-At experiment to master database..."
    commit_tests \
        -inexperiment cv32e40p_core_stuck_at \
        -testmode COMPRESSION
}

# ==============================================================================
# 7. PART B: TRANSITION DELAY ATPG & VECTOR GENERATION
# ==============================================================================
if {$ATPG_MODE == "delay" || $ATPG_MODE == "both"} {
    puts "\n=================================================================="
    puts " Starting Part B: Transition Delay ATPG"
    puts "=================================================================="

    # 7.1 Build Transition Delay Fault Model
    puts "INFO: Building Transition Delay fault model (-includedynamic yes)..."
    build_faultmodel \
        -includedynamic yes \
        -overwrite yes

    puts "INFO: Writing initial Transition Delay fault summary..."
    report_faults -summary > "$REPORTS_DIR/delay_initial_faults.rpt"

    # 7.2 Generate At-Speed Transition Delay Patterns (LOC/LOS)
    puts "INFO: Generating Transition Delay ATPG patterns (LOC/LOS)..."
    create_logic_delay_tests \
        -experiment cv32e40p_core_delay \
        -testmode COMPRESSION

    # 7.3 Supplementary Tests to Catch Remaining Faults
    puts "INFO: Generating supplementary logic tests..."
    create_logic_tests \
        -experiment cv32e40p_core_delay \
        -append yes \
        -testmode COMPRESSION \
        -testscan no

    # 7.4 Export Delay Test Summary & Fault Coverage Reports
    puts "INFO: Writing Transition Delay test summary and coverage reports..."
    report_tests \
        -experiment cv32e40p_core_delay \
        -testmode COMPRESSION \
        > "$REPORTS_DIR/delay_test_summary.rpt"

    report_faults -summary >> "$REPORTS_DIR/delay_test_summary.rpt"

    report_faults \
        -experiment cv32e40p_core_delay \
        -testmode COMPRESSION \
        > "$REPORTS_DIR/delay_fault_coverage.rpt"

    # 7.5 Scan and Capture Switching Activity (Power Analysis)
    puts "INFO: Writing Transition Delay switching activity (toggle-gram) report..."
    write_toggle_gram \
        -experiment cv32e40p_core_delay \
        -testmode COMPRESSION \
        > "$REPORTS_DIR/delay_toggle_gram.rpt"

    # 7.6 Export Serial Verilog Test Vectors
    puts "INFO: Exporting serial Verilog vectors for Transition Delay..."
    write_vectors \
        -inexperiment cv32e40p_core_delay \
        -testmode COMPRESSION \
        -language verilog \
        -scanformat serial \
        -exportdir "$TESTRESULTS_DIR/delay/verilog_serial"

    # 7.7 Export Parallel Verilog Test Vectors
    puts "INFO: Exporting parallel Verilog vectors for Transition Delay..."
    write_vectors \
        -inexperiment cv32e40p_core_delay \
        -testmode COMPRESSION \
        -language verilog \
        -scanformat parallel \
        -exportdir "$TESTRESULTS_DIR/delay/verilog_parallel"

    # 7.8 Commit Delay Tests to Master Database
    puts "INFO: Committing Transition Delay experiment to master database..."
    commit_tests \
        -inexperiment cv32e40p_core_delay \
        -testmode COMPRESSION
}

puts "\n=================================================================="
puts " Modus ATPG ($ATPG_MODE) Completed Successfully!"
puts " Reports:          $REPORTS_DIR/"
puts " Results:          $TESTRESULTS_DIR/"
puts "=================================================================="

exit
