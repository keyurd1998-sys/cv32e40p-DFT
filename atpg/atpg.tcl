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
set PINASSIGN "../../scan/atpg_script/cv32e40p_core.COMPRESSION.pinassign"

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

set ATPG_MODE [string trimright [string trim $ATPG_MODE] "/"]
set EXPERIMENT "${DESIGN}_${ATPG_MODE}"

# ------------------------------------------------------------------------------
# 2. Database Configuration
# ------------------------------------------------------------------------------
set_db workdir .
set_option stdout all
set ::env(CDS_LIC_REPORT) yes
set_db stop_on_severity error

file delete -force ./tbdata
file delete -force ./testresults
file delete -force ./patterns

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
    -reportchannelmaskchain yes \
    -reportchannelmaskstate yes \
    -stdout all \
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

report_fault_statistics \
    -testmode COMPRESSION \
    -stdout all \
    > "./reports/${ATPG_MODE}_initial_faults.rpt"

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
# 8. Export Summary, Coverage, and Vector Reports
# ------------------------------------------------------------------------------
# Pattern & Vector Template Summary
report_vector_summary \
    -experiment $EXPERIMENT \
    -testmode COMPRESSION \
    -summary yes \
    -vectors yes \
    -key yes \
    -stdout all \
    > "./reports/${ATPG_MODE}_pattern_summary.rpt"

# Tester Cycle & Timing Statistics
report_vector_statistics \
    -experiment $EXPERIMENT \
    -testmode COMPRESSION \
    -reportcounts yes \
    -reportcovpercycle yes \
    -stdout all \
    > "./reports/${ATPG_MODE}_cycle_statistics.rpt"

# Full Fault Coverage Summary Table (TCov, ATCov, Tested, Untested, Effectiveness)
report_fault_statistics \
    -experiment $EXPERIMENT \
    -testmode COMPRESSION \
    -effectiveness yes \
    -reportpiporows yes \
    -stdout all \
    > "./reports/${ATPG_MODE}_fault_summary.rpt"

# Detailed Untested Faults List (For DFT Coverage Debug)
report_faults \
    -experiment $EXPERIMENT \
    -testmode COMPRESSION \
    -faultstatus untested \
    -stdout all \
    > "./reports/${ATPG_MODE}_untested_faults.rpt"

# Detailed Redundant Faults List (Tie-offs, redundant logic)
report_faults \
    -experiment $EXPERIMENT \
    -testmode COMPRESSION \
    -faultstatus redundant \
    -stdout all \
    > "./reports/${ATPG_MODE}_redundant_faults.rpt"

# Switching Activity (Toggle Gram) Report
write_toggle_gram \
    -experiment $EXPERIMENT \
    -testmode COMPRESSION \
    -stdout all \
    > "./reports/${ATPG_MODE}_toggle_gram.rpt"

# ------------------------------------------------------------------------------
# 9. Export Serial and Parallel Verilog Test Vectors
# ------------------------------------------------------------------------------
write_vectors \
    -inexperiment $EXPERIMENT \
    -testmode COMPRESSION \
    -language verilog \
    -scanformat serial \
    -exportdir "./patterns/verilog_serial"

write_vectors \
    -inexperiment $EXPERIMENT \
    -testmode COMPRESSION \
    -language verilog \
    -scanformat parallel \
    -exportdir "./patterns/verilog_parallel"

# ------------------------------------------------------------------------------
# 10. Commit Tests to Database
# ------------------------------------------------------------------------------
commit_tests \
    -inexperiment $EXPERIMENT \
    -testmode COMPRESSION

exit
