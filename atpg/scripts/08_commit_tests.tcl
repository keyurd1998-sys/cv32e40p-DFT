set SCRIPT_DIR [file dirname [file normalize [info script]]]
source "$SCRIPT_DIR/00_setup_env.tcl"

set EXPERIMENT "${DESIGN}_${TESTMODE}"

puts "=================================================================="
puts " Modus ATPG Step 8: Commit Tests to Master Database"
puts " Experiment: $EXPERIMENT"
puts "=================================================================="

commit_tests \
    -inexperiment $EXPERIMENT \
    -testmode $TESTMODE

puts "INFO: Step 8 Tests committed to master database ($WORKDIR/tbdata)."
exit
