# Minimal constraints (altera)

create_clock -name "CLOCK_50" -period 20.000ns [get_ports {CLOCK_50}]
derive_pll_clocks
derive_clock_uncertainty

# Automatically apply a generate clock on the output of phase-locked loops (PLLs)
# This command can be safely left in the SDC even if no PLLs exist in the design

derive_pll_clocks

# Constrain the input I/O path
set_input_delay -clock CLOCK_50 -max 3 [all_inputs]
set_input_delay -clock CLOCK_50 -min 2 [all_inputs]


# Constrain the output I/O path
set_output_delay -clock CLOCK_50 -max 3 [all_outputs]
set_output_delay -clock CLOCK_50 -min 2 [all_outputs]


#Setting LED outputs as false path, since no timing requirement
set_false_path -from * -to [get_ports LEDR[*]]
