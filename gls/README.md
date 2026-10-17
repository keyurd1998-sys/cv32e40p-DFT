# Gate-Level Simulation Directory (`gls/`)

This directory is dedicated to **Gate-Level Simulation (GLS)** for verifying the post-scan compressed netlist of `cv32e40p_core`.

## Structure
- **`run_gls.sh`**: Runner script for executing simulations with Cadence Xcelium (`xrun`), Synopsys VCS, or Icarus Verilog.
- **`tb/`**: Gate-level testbenches (functional testbenches or ATPG-generated Verilog testbenches).
- **`logs/`**: Simulation run logs.
- **`waves/`**: Simulation waveforms (`.shm`, `.vcd`).

## Running GLS
```bash
# Run simulation with default or custom testbench:
./run_gls.sh tb/cv32e40p_core_tb.v
```
