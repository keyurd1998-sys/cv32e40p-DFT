set SCRIPT_DIR [file dirname [file normalize [info script]]]
source "$SCRIPT_DIR/00_setup_env.tcl"

puts "=================================================================="
puts " Modus ATPG Step 1: Build Logic Model"
puts " Cell:    $DESIGN"
puts " TechLib: $TECH_LIB"
puts " Netlist: $NETLIST"
puts "=================================================================="

# Delete existing test database for a clean build
file delete -force "$WORKDIR/tbdata"
file delete -force "$WORKDIR/testresults"

# Build flattened Boolean simulation model
build_model \
    -cell $DESIGN \
    -techlib $TECH_LIB \
    -designsource $NETLIST \
    -allowmissingmodules yes \
    -messagecounteach 100

puts "INFO: Step 1 Logic model built successfully in $WORKDIR/tbdata"
exit
