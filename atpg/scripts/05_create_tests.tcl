set SCRIPT_DIR [file dirname [file normalize [info script]]]
source "$SCRIPT_DIR/00_setup_env.tcl"

set EXPERIMENT "${DESIGN}_${TESTMODE}"

puts "=================================================================="
puts " Modus ATPG Step 5: Test Pattern Generation"
puts " Experiment: $EXPERIMENT"
puts " Fault Type: $FAULT_TYPE"
puts " Test Mode:  $TESTMODE"
puts "=================================================================="

if {$FAULT_TYPE == "delay"} {
    puts "INFO: Generating Transition Delay ATPG patterns (LOC/LOS)..."
    create_logic_delay_tests \
        -experiment $EXPERIMENT \
        -testmode $TESTMODE

    puts "INFO: Generating supplementary logic tests to catch remaining faults..."
    create_logic_tests \
        -experiment $EXPERIMENT \
        -append yes \
        -testmode $TESTMODE \
        -testscan no
} else {
    puts "INFO: Generating Stuck-At ATPG patterns..."
    create_logic_tests \
        -experiment $EXPERIMENT \
        -testmode $TESTMODE
}

# Report test pattern summary and coverage metrics
set ATPG_RPT "$REPORTS_DIR/${DESIGN}_${FAULT_TYPE}_coverage.rpt"
report_tests -experiment $EXPERIMENT -testmode $TESTMODE > $ATPG_RPT
report_faults -summary >> $ATPG_RPT
puts "INFO: Test coverage and pattern summary written to: $ATPG_RPT"

puts "INFO: Step 5 Test pattern generation completed successfully."
exit
