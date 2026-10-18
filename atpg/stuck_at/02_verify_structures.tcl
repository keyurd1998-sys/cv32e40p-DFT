set DESIGN    "cv32e40p_core"
set PINASSIGN "./cv32e40p_core.COMPRESSION.pinassign"

set_db workdir .
set_option stdout summary
set_db stop_on_severity error

# Build compression testmode
build_testmode \
    -testmode COMPRESSION \
    -assignfile $PINASSIGN \
    -modedef COMPRESSION

# Report scan chains and masking structures
report_test_structures \
    -testmode COMPRESSION \
    -reportscanchain all \
    -reportchannelio yes \
    -reportchannelmaskscanchain yes \
    -reportchannelmaskstate yes

# Verify test structures (TSV rule check)
verify_test_structures \
    -messagecount TSV-016=10,TSV-024=10,TSV-315=10,TSV-027=10 \
    -testmode COMPRESSION

exit
