# Modus ATPG Directory (`atpg/`)

This directory contains the Automatic Test Pattern Generation (ATPG) workspaces for the **CV32E40P** core, exported by Genus in Step 8 (`08_export.tcl`).

## Workspaces
- **`stuck_at/`**: Modus Stuck-At ATPG workspace (`runmodus.atpg.tcl`).
- **`delay/`**: Modus Transition Delay (LOC/LOS) ATPG workspace (`runmodus.atpg.tcl`).
- **`logs/`**: Execution logs for ATPG runs.
- **`reports/`**: Fault summary and coverage reports.

## Running ATPG
Once Step 8 has been executed in `scan/`, run ATPG using the runner script:
```bash
# Run Stuck-At ATPG:
./run_atpg.sh stuck_at

# Run Transition Delay ATPG:
./run_atpg.sh delay

# Run both:
./run_atpg.sh all
```
