set SCRIPT_DIR [file dirname [file normalize [info script]]]
source "$SCRIPT_DIR/00_setup_env.tcl"

set EXPERIMENT "${DESIGN}_${TESTMODE}"

puts "=================================================================="
puts " Modus ATPG Step 6: Scan & Capture Switching Activity Analysis"
puts " Experiment: $EXPERIMENT"
puts "=================================================================="

set TOGGLE_RPT "$REPORTS_DIR/${DESIGN}_${TESTMODE}_toggle_gram.rpt"
puts "INFO: Writing toggle-gram switching activity to: $TOGGLE_RPT..."

write_toggle_gram \
    -experiment $EXPERIMENT \
    -testmode $TESTMODE \
    > $TOGGLE_RPT

puts "INFO: Step 6 Toggle and switching activity analysis completed."
exit
