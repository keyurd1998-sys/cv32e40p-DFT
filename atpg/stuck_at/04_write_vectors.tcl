set_db workdir .
set_option stdout summary
set_db stop_on_severity error

# Export serial Verilog test vectors
write_vectors \
    -inexperiment cv32e40p_core_compression \
    -testmode COMPRESSION \
    -language verilog \
    -scanformat serial

# Commit tests to master database
commit_tests \
    -inexperiment cv32e40p_core_compression \
    -testmode COMPRESSION

exit
