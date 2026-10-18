set SCRIPT_DIR [file dirname [file normalize [info script]]]
source "$SCRIPT_DIR/00_setup_env.tcl"

puts "=================================================================="
puts " Modus ATPG Step 3: Verify Test Structures & TDRC ($TESTMODE)"
puts "=================================================================="

# 3.1 Report scan chains and channel masking architecture
set STRUCT_RPT "$REPORTS_DIR/${DESIGN}_${TESTMODE}_test_structures.rpt"
puts "INFO: Reporting test structures to $STRUCT_RPT..."
if {$TESTMODE == "COMPRESSION"} {
    report_test_structures \
        -testmode $TESTMODE \
        -reportscanchain all \
        -reportchannelio yes \
        -reportchannelmaskscanchain yes \
        -reportchannelmaskstate yes \
        > $STRUCT_RPT
} else {
    report_test_structures \
        -testmode $TESTMODE \
        -reportscanchain all \
        > $STRUCT_RPT
}

# 3.2 Verify test structures (TSV structural Design Rule Check)
puts "INFO: Running TSV structural rule check..."
verify_test_structures \
    -messagecount TSV-016=10,TSV-024=10,TSV-315=10,TSV-027=10 \
    -testmode $TESTMODE

puts "INFO: Step 3 Test structures verified successfully."
exit
