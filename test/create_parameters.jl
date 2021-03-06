include("../src/Kinematic1D.jl")

import CLIMAParameters as CP
import CloudMicrophysics as CM
import Thermodynamics as TD

#! format: off
function create_parameter_set(
    out_dir::String,
    toml_dict::CP.AbstractTOMLDict,
    FTD = CP.float_type(toml_dict),
    w1 = 2.0,
    t1 = 600.0,
    precip_sources = 1,
    precip_sinks = 1,
)
    FT = CP.float_type(toml_dict)
    override_file = joinpath(out_dir, "override_dict.toml")
    open(override_file, "w") do io
        println(io, "[mean_sea_level_pressure]")
        println(io, "alias = \"MSLP\"")
        println(io, "value = 100000.0")
        println(io, "type = \"float\"")
        println(io, "[gravitational_acceleration]")
        println(io, "alias = \"grav\"")
        println(io, "value = 9.80665")
        println(io, "type = \"float\"")
        println(io, "[gas_constant]")
        println(io, "alias = \"gas_constant\"")
        println(io, "value = 8.314462618")
        println(io, "type = \"float\"")
        println(io, "[adiabatic_exponent_dry_air]")
        println(io, "alias = \"kappa_d\"")
        println(io, "value = 0.2855747338575384")
        println(io, "type = \"float\"")
        println(io, "[isobaric_specific_heat_vapor]")
        println(io, "alias = \"cp_v\"")
        println(io, "value = 1850.0")
        println(io, "type = \"float\"")
        println(io, "[molar_mass_dry_air]")
        println(io, "alias = \"molmass_dryair\"")
        println(io, "value = 0.02896998")
        println(io, "type = \"float\"")
        println(io, "[molar_mass_water]")
        println(io, "alias = \"molmass_water\"")
        println(io, "value = 0.018015")
        println(io, "type = \"float\"")
        println(io, "[cloud_liquid_water_specific_humidity_autoconversion_threshold]")
        println(io, "alias = \"q_liq_threshold\"")
        println(io, "value = 0.0001")
        println(io, "type = \"float\"")
        println(io, "[prescribed_flow_w1]")
        println(io, "alias = \"w1\"")
        println(io, "value = " * string(w1))
        println(io, "type = \"float\"")
        println(io, "[prescribed_flow_t1]")
        println(io, "alias = \"t1\"")
        println(io, "value = " * string(t1))
        println(io, "type = \"float\"")
        println(io, "[precipitation_sources_flag]")
        println(io, "alias = \"precip_sources\"")
        println(io, "value = " * string(precip_sources))
        println(io, "type = \"integer\"")
        println(io, "[precipitation_sinks_flag]")
        println(io, "alias = \"precip_sinks\"")
        println(io, "value = " * string(precip_sinks))
        println(io, "type = \"integer\"")
    end
    toml_dict = CP.create_toml_dict(FT; override_file, dict_type="alias")
    isfile(override_file) && rm(override_file; force=true)

    aliases = string.(fieldnames(TD.Parameters.ThermodynamicsParameters))
    param_pairs = CP.get_parameter_values!(toml_dict, aliases, "Thermodynamics")
    thermo_params = TD.Parameters.ThermodynamicsParameters{FTD}(; param_pairs...)
    TP = typeof(thermo_params)

    aliases = string.(fieldnames(CM.Parameters.CloudMicrophysicsParameters))
    aliases = setdiff(aliases, ["thermo_params"])
    pairs = CP.get_parameter_values!(toml_dict, aliases, "CloudMicrophysics")
    microphys_params = CM.Parameters.CloudMicrophysicsParameters{FTD, TP}(;
        pairs...,
        thermo_params,
    )
    MP = typeof(microphys_params)

    aliases = ["w1", "t1", "precip_sources", "precip_sinks"]
    pairs = CP.get_parameter_values!(toml_dict, aliases, "Kinematic1D")

    param_set = Kinematic1D.Parameters.KinematicParameters{FTD, MP}(; pairs..., microphys_params)
    if !isbits(param_set)
        @warn "The parameter set SHOULD be isbits in order to be stack-allocated."
    end
    return param_set
end
#! format: on
