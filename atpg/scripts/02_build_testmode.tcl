set SCRIPT_DIR [file dirname [file normalize [info script]]]
source "$SCRIPT_DIR/00_setup_env.tcl"

puts "=================================================================="
puts " Modus ATPG Step 2: Build Test Mode ($TESTMODE)"
puts " Pinassign: $PINASSIGN"
puts "=================================================================="

build_testmode \
    -testmode $TESTMODE \
    -assignfile $PINASSIGN \
    -modedef $TESTMODE

puts "INFO: Step 2 Test mode $TESTMODE built successfully."
exit
