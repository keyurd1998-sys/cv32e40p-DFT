set DESIGN   "cv32e40p_core"
set TECH_LIB "/home/admin/DFT/Library/atpg/stdcell.v"
set NETLIST  "./cv32e40p_core.test_netlist.v"

set_db workdir .
set_option stdout summary
set_db stop_on_severity error

# Clean previous database for a fresh build
file delete -force ./tbdata
file delete -force ./testresults

# Build logic simulation model
build_model \
    -cell $DESIGN \
    -techlib $TECH_LIB \
    -designsource $NETLIST \
    -allowmissingmodules yes \
    -messagecounteach 100

exit
