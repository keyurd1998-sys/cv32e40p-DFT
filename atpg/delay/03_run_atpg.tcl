set_db workdir .
set_option stdout summary
set_db stop_on_severity error

# Build Transition Delay fault model
build_faultmodel \
    -includedynamic yes

# Generate at-speed Transition Delay ATPG patterns (LOC/LOS)
create_logic_delay_tests \
    -experiment cv32e40p_core_compression \
    -testmode COMPRESSION

# Generate supplementary logic tests for remaining faults
create_logic_tests \
    -experiment cv32e40p_core_compression \
    -append yes \
    -testmode COMPRESSION \
    -testscan no

# Report scan and capture switching activity
write_toggle_gram \
    -experiment cv32e40p_core_compression \
    -testmode COMPRESSION

exit
