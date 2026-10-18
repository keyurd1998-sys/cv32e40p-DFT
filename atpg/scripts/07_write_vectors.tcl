set SCRIPT_DIR [file dirname [file normalize [info script]]]
source "$SCRIPT_DIR/00_setup_env.tcl"

set EXPERIMENT "${DESIGN}_${TESTMODE}"

puts "=================================================================="
puts " Modus ATPG Step 7: Export Test Vectors & Verilog Testbenches"
puts " Experiment: $EXPERIMENT"
puts "=================================================================="

# 7.1 Export Serial Vectors (Realistic tester shifting through scan_in/out)
puts "INFO: Exporting serial Verilog simulation vectors..."
write_vectors \
    -inexperiment $EXPERIMENT \
    -testmode $TESTMODE \
    -language verilog \
    -scanformat serial

# 7.2 Export Parallel Vectors (Fast debug simulation)
puts "INFO: Exporting parallel Verilog simulation vectors..."
write_vectors \
    -inexperiment $EXPERIMENT \
    -testmode $TESTMODE \
    -language verilog \
    -scanformat parallel

puts "INFO: Step 7 Vectors exported successfully to: $WORKDIR/testresults/verilog/"
exit
