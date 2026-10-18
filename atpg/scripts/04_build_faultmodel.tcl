set SCRIPT_DIR [file dirname [file normalize [info script]]]
source "$SCRIPT_DIR/00_setup_env.tcl"

puts "=================================================================="
puts " Modus ATPG Step 4: Build Fault Model"
puts " Fault Type: $FAULT_TYPE"
puts "=================================================================="

if {$FAULT_TYPE == "delay"} {
    puts "INFO: Building Transition Delay fault model (-includedynamic yes)..."
    build_faultmodel \
        -includedynamic yes
} else {
    puts "INFO: Building Stuck-At fault model (-includedynamic no)..."
    build_faultmodel \
        -includedynamic no
}

# Generate initial fault universe report
set FAULT_RPT "$REPORTS_DIR/${DESIGN}_${FAULT_TYPE}_initial_faults.rpt"
report_faults -summary > $FAULT_RPT
puts "INFO: Initial fault universe report written to: $FAULT_RPT"

puts "INFO: Step 4 Fault model built successfully."
exit
