# ==============================================================================
# Cadence Modus ATPG Script (COMPRESSION Mode Only)
# Pure Command Execution Flow for Stuck-At or Transition Delay ATPG
# Target Design: cv32e40p_core
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Variables & Mode Selection
# ------------------------------------------------------------------------------
set DESIGN    "cv32e40p_core"
set TECH_LIB  "/home/admin/DFT/Library/atpg/stdcell.v"
set NETLIST   "../../scan/netlists/cv32e40p_core_compressed.v"
set PINASSIGN "../cv32e40p_core.COMPRESSION.pinassign"

# Select ATPG mode ("stuck_at" or "delay")
if {[info exists argv] && [llength $argv] > 0} {
    set ATPG_MODE [lindex $argv 0]
} elseif {[info exists ::env(ATPG_MODE)]} {
    set ATPG_MODE $::env(ATPG_MODE)
} elseif {[string match "*delay*" [pwd]]} {
    set ATPG_MODE "delay"
} else {
    set ATPG_MODE "stuck_at"
}

set EXPERIMENT "${DESIGN}_${ATPG_MODE}"

# ------------------------------------------------------------------------------
# 2. Database Configuration
# ------------------------------------------------------------------------------
set_db workdir .
set_option stdout summary
set ::env(CDS_LIC_REPORT) yes
set_db stop_on_severity error

file delete -force ./tbdata
file delete -force ./testresults

# ------------------------------------------------------------------------------
# 3. Build Logic Simulation Model
# ------------------------------------------------------------------------------
build_model \
    -cell $DESIGN \
    -techlib $TECH_LIB \
    -designsource $NETLIST \
    -allowmissingmodules yes \
    -messagecounteach 100

# ------------------------------------------------------------------------------
# 4. Build Test Mode (COMPRESSION)
# ------------------------------------------------------------------------------
build_testmode \
    -testmode COMPRESSION \
    -assignfile $PINASSIGN \
    -modedef COMPRESSION

# ------------------------------------------------------------------------------
# 5. Report & Verify Test Structures (TSV Rules)
# ------------------------------------------------------------------------------
report_test_structures \
    -testmode COMPRESSION \
    -reportscanchain all \
    -reportchannelio yes \
    -reportchannelmaskscanchain yes \
    -reportchannelmaskstate yes \
    > "./reports/test_structures.rpt"

verify_test_structures \
    -messagecount TSV-016=10,TSV-024=10,TSV-315=10,TSV-027=10 \
    -testmode COMPRESSION

# ------------------------------------------------------------------------------
# 6. Build Fault Model
# ------------------------------------------------------------------------------
if {$ATPG_MODE == "delay"} {
    build_faultmodel \
        -includedynamic yes
} else {
    build_faultmodel \
        -includedynamic no
}

report_faults -summary > "./reports/${ATPG_MODE}_initial_faults.rpt"

# ------------------------------------------------------------------------------
# 7. Generate Test Patterns
# ------------------------------------------------------------------------------
if {$ATPG_MODE == "delay"} {
    create_logic_delay_tests \
        -experiment $EXPERIMENT \
        -testmode COMPRESSION

    create_logic_tests \
        -experiment $EXPERIMENT \
        -append yes \
        -testmode COMPRESSION \
        -testscan no
} else {
    create_logic_tests \
        -experiment $EXPERIMENT \
        -testmode COMPRESSION
}

# ------------------------------------------------------------------------------
# 8. Export Summary, Coverage, and Switching Activity Reports
# ------------------------------------------------------------------------------
report_tests \
    -experiment $EXPERIMENT \
    -testmode COMPRESSION \
    > "./reports/${ATPG_MODE}_test_summary.rpt"

report_faults -summary >> "./reports/${ATPG_MODE}_test_summary.rpt"

report_faults \
    -experiment $EXPERIMENT \
    -testmode COMPRESSION \
    > "./reports/${ATPG_MODE}_fault_coverage.rpt"

write_toggle_gram \
    -experiment $EXPERIMENT \
    -testmode COMPRESSION \
    > "./reports/${ATPG_MODE}_toggle_gram.rpt"

# ------------------------------------------------------------------------------
# 9. Export Serial and Parallel Verilog Test Vectors
# ------------------------------------------------------------------------------
write_vectors \
    -inexperiment $EXPERIMENT \
    -testmode COMPRESSION \
    -language verilog \
    -scanformat serial \
    -exportdir "./testresults/verilog_serial"

write_vectors \
    -inexperiment $EXPERIMENT \
    -testmode COMPRESSION \
    -language verilog \
    -scanformat parallel \
    -exportdir "./testresults/verilog_parallel"

# ------------------------------------------------------------------------------
# 10. Commit Tests to Database
# ------------------------------------------------------------------------------
commit_tests \
    -inexperiment $EXPERIMENT \
    -testmode COMPRESSION

exit
