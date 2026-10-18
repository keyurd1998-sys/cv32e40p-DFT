set_db workdir .
set_option stdout summary
set_db stop_on_severity error

# Build Stuck-At fault model
build_faultmodel \
    -includedynamic no

# Generate Stuck-At ATPG patterns
create_logic_tests \
    -experiment cv32e40p_core_compression \
    -testmode COMPRESSION

# Report scan and capture switching activity
write_toggle_gram \
    -experiment cv32e40p_core_compression \
    -testmode COMPRESSION

exit
