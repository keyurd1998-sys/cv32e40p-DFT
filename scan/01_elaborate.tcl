set SCRIPT_DIR [file dirname [file normalize [info script]]]
source "$SCRIPT_DIR/00_setup_env.tcl"

set STEP_RPT_DIR "$REPORTS_DIR/01_elaboration"
file mkdir $STEP_RPT_DIR $DBS_DIR

# 1. Load target standard cell libraries
set_db root: .lib_lef_consistency_check_enable false
read_libs $TIMING_LIB
if {[file exists $LEF_FILE]} {
    read_physical -lef $LEF_FILE
}
set_db [get_db lib_cells] .avoid false
set_db root: .lp_insert_clock_gating false

# 2. Set search paths and load SystemVerilog RTL
set_db root: .init_hdl_search_path [list "$ROOT_DIR/rtl/include" "$ROOT_DIR/bhv"]

read_hdl -language sv [glob "$ROOT_DIR/rtl/include/*.sv"]
read_hdl -language sv "$ROOT_DIR/bhv/cv32e40p_sim_clock_gate.sv"
read_hdl -language sv [lsearch -all -inline -not [glob "$ROOT_DIR/rtl/*.sv"] "*latch*"]

# 3. Elaborate design
elaborate $DESIGN

# 4. Design checks and checkpoint database
check_design -unresolved > "$STEP_RPT_DIR/${DESIGN}_unresolved.rpt"
report_design            > "$STEP_RPT_DIR/${DESIGN}_design_summary.rpt"

set DB_FILE "$DBS_DIR/01_elaborated.db"
write_db -all_root_attributes -to_file $DB_FILE

puts "INFO: Step 1 elaboration completed successfully. Checkpoint saved: $DB_FILE"
exit
