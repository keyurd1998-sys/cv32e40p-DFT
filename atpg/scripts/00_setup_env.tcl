# ==============================================================================
# Modus ATPG Environment Setup Script
# Configures design names, paths, technology library, fault type, and test mode
# ==============================================================================

set DESIGN "cv32e40p_core"

# Set Modus working directory (current execution directory)
set_db workdir .
set WORKDIR [get_db workdir]

# Output logging options
set_option stdout summary
set ::env(CDS_LIC_REPORT) yes
set_db stop_on_severity error

# Infer or read fault model (stuck_at vs delay)
if {[info exists ::env(MODUS_FAULT_TYPE)]} {
    set FAULT_TYPE $::env(MODUS_FAULT_TYPE)
} else {
    if {[string match "*delay*" [file normalize $WORKDIR]]} {
        set FAULT_TYPE "delay"
    } else {
        set FAULT_TYPE "stuck_at"
    }
}

# Infer or read test mode (COMPRESSION vs FULLSCAN)
if {[info exists ::env(MODUS_TESTMODE)]} {
    set TESTMODE $::env(MODUS_TESTMODE)
} else {
    set TESTMODE "COMPRESSION"
}

# Technology Library search path setup (auto-detects local RAK path or container path)
if {[file exists "/home/vlsi/keyurd1998-sys/LAB/GENUS_LABS/Normal_runs/Basic_Digital_Test_RAK_21.1/LIBS/atpg/stdcell.v"]} {
    set TECH_LIB "/home/vlsi/keyurd1998-sys/LAB/GENUS_LABS/Normal_runs/Basic_Digital_Test_RAK_21.1/LIBS/atpg/stdcell.v"
} elseif {[file exists "/home/admin/DFT/Library/atpg/stdcell.v"]} {
    set TECH_LIB "/home/admin/DFT/Library/atpg/stdcell.v"
} elseif {[file exists "/home/vlsi/Library/atpg/stdcell.v"]} {
    set TECH_LIB "/home/vlsi/Library/atpg/stdcell.v"
} else {
    set TECH_LIB "/home/admin/DFT/Library/atpg/stdcell.v"
}

# Design netlist and pin assignment paths
set NETLIST   "$WORKDIR/${DESIGN}.test_netlist.v"
set PINASSIGN "$WORKDIR/${DESIGN}.${TESTMODE}.pinassign"

# Output directories for reports and logs
set REPORTS_DIR     "$WORKDIR/reports"
set LOGS_DIR        "$WORKDIR/logs"
set TESTRESULTS_DIR "$WORKDIR/testresults"

file mkdir $REPORTS_DIR $LOGS_DIR $TESTRESULTS_DIR

if {![file exists $NETLIST]} {
    puts "ERROR: Gate-level netlist not found: $NETLIST"
    exit 1
}

if {![file exists $PINASSIGN]} {
    puts "ERROR: Pin assignment file not found: $PINASSIGN"
    exit 1
}

puts "=================================================================="
puts " Modus ATPG Environment Setup:"
puts "   Target Cell:      $DESIGN"
puts "   Working Dir:      $WORKDIR"
puts "   Fault Type:       $FAULT_TYPE"
puts "   Test Mode:        $TESTMODE"
puts "   Technology Lib:   $TECH_LIB"
puts "   Test Netlist:     $NETLIST"
puts "   Pin Assignment:   $PINASSIGN"
puts "=================================================================="
