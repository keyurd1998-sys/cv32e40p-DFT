# ==============================================================================
# Cadence Modus ATPG Script (COMPRESSION Mode Only)
# Reusable Flow for Stuck-At and Transition Delay ATPG
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
puts "   Selected Mode:      $ATPG_MODE"
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

# ------------------------------------------------------------------------------
# 6. Reusable ATPG Execution Loop (Stuck-At / Transition Delay)
# ------------------------------------------------------------------------------
if {$ATPG_MODE == "both"} {
    set MODES {stuck_at delay}
} else {
    set MODES [list $ATPG_MODE]
}

foreach mode $MODES {
    set EXPERIMENT "${DESIGN}_${mode}"
    puts "\n=================================================================="
    puts " Running ATPG for Mode: $mode ($EXPERIMENT)"
    puts "=================================================================="

    # 6.1 Build Fault Model
    if {$mode == "delay"} {
        puts "INFO: Building Transition Delay fault model (-includedynamic yes)..."
        build_faultmodel \
            -includedynamic yes \
            -overwrite yes
    } else {
        puts "INFO: Building Stuck-At fault model (-includedynamic no)..."
        build_faultmodel \
            -includedynamic no
    }

    puts "INFO: Writing initial fault summary to $REPORTS_DIR/${mode}_initial_faults.rpt..."
    report_faults -summary > "$REPORTS_DIR/${mode}_initial_faults.rpt"

    # 6.2 Generate Test Patterns
    if {$mode == "delay"} {
        puts "INFO: Generating Transition Delay ATPG patterns (LOC/LOS)..."
        create_logic_delay_tests \
            -experiment $EXPERIMENT \
            -testmode COMPRESSION

        puts "INFO: Generating supplementary logic tests..."
        create_logic_tests \
            -experiment $EXPERIMENT \
            -append yes \
            -testmode COMPRESSION \
            -testscan no
    } else {
        puts "INFO: Generating Stuck-At ATPG test patterns..."
        create_logic_tests \
            -experiment $EXPERIMENT \
            -testmode COMPRESSION
    }

    # 6.3 Export Summary and Coverage Reports
    puts "INFO: Writing test summary and fault coverage reports..."
    report_tests \
        -experiment $EXPERIMENT \
        -testmode COMPRESSION \
        > "$REPORTS_DIR/${mode}_test_summary.rpt"

    report_faults -summary >> "$REPORTS_DIR/${mode}_test_summary.rpt"

    report_faults \
        -experiment $EXPERIMENT \
        -testmode COMPRESSION \
        > "$REPORTS_DIR/${mode}_fault_coverage.rpt"

    # 6.4 Power / Switching Activity Analysis
    puts "INFO: Writing switching activity (toggle-gram) report..."
    write_toggle_gram \
        -experiment $EXPERIMENT \
        -testmode COMPRESSION \
        > "$REPORTS_DIR/${mode}_toggle_gram.rpt"

    # 6.5 Export Test Vectors (Serial & Parallel)
    puts "INFO: Exporting serial Verilog vectors to $TESTRESULTS_DIR/${mode}/verilog_serial..."
    write_vectors \
        -inexperiment $EXPERIMENT \
        -testmode COMPRESSION \
        -language verilog \
        -scanformat serial \
        -exportdir "$TESTRESULTS_DIR/${mode}/verilog_serial"

    puts "INFO: Exporting parallel Verilog vectors to $TESTRESULTS_DIR/${mode}/verilog_parallel..."
    write_vectors \
        -inexperiment $EXPERIMENT \
        -testmode COMPRESSION \
        -language verilog \
        -scanformat parallel \
        -exportdir "$TESTRESULTS_DIR/${mode}/verilog_parallel"

    # 6.6 Commit Tests to Master Database
    puts "INFO: Committing experiment $EXPERIMENT to master database..."
    commit_tests \
        -inexperiment $EXPERIMENT \
        -testmode COMPRESSION
}

puts "\n=================================================================="
puts " Modus ATPG ($ATPG_MODE) Completed Successfully!"
puts " Reports:  $REPORTS_DIR/"
puts " Results:  $TESTRESULTS_DIR/"
puts "=================================================================="

exit
