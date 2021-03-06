"""
    Parse the command line arguments for KiD_driver.jl
"""

function parse_commandline()
    s = AP.ArgParseSettings()

    AP.@add_arg_table s begin
        "--moisture_choice"
        help = "Mositure model choice: EquilibriumMoisture, NonEquilibriumMoisture"
        arg_type = String
        default = "NonEquilibriumMoisture"
        "--precipitation_choice"
        help = "Precipitation model choice: NoPrecipitation, Precipitation0M, Precipitation1M"
        arg_type = String
        default = "Precipitation1M"
        "--plotting_flag"
        help = "Set to true if you want to generate some basic plots at the end of the simulation"
        arg_type = Bool
        default = true
        "--precip_sources"
        help = "Set to true if you want to switch on autoconversion and accretion in the 1-moment scheme"
        arg_type = Bool
        default = true
        "--precip_sinks"
        help = "Set to true if you want to switch on evaporation, deposition, sublimation and melting in the 1-moment scheme"
        arg_type = Bool
        default = true
        "--z_min"
        help = "Bottom of the computational domain [m]"
        arg_type = Real
        default = 0.0
        "--z_max"
        help = "Top of the computational domain [m]"
        arg_type = Real
        default = 2000.0
        "--n_elem"
        help = "Number of computational elements"
        arg_type = Int
        default = 256
        "--dt"
        help = "Simulation time step [s]"
        arg_type = Real
        default = 1.0
        "--dt_output"
        help = "Output time step [s]"
        arg_type = Real
        default = 10.0
        "--t_ini"
        help = "Time at the beginning of the simulation [s]"
        arg_type = Real
        default = 0.0
        "--t_end"
        help = "Time at the end of the simulation [s]"
        arg_type = Real
        default = 3600.0
        "--w1"
        help = "Maximum prescribed updraft momentum flux [m/s * kg/m3]"
        arg_type = Real
        default = 2.0
        "--t1"
        help = "Oscillation time of the prescribed momentum flux [s]"
        arg_type = Real
        default = 600.0
    end

    return AP.parse_args(s)
end
