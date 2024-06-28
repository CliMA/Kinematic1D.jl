var documenterSearchIndex = {"docs":
[{"location":"References/#References","page":"References","title":"References","text":"","category":"section"},{"location":"References/","page":"References","title":"References","text":"","category":"page"},{"location":"#Kinematic1D.jl","page":"Home","title":"Kinematic1D.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Kinematic1D.jl is a single column, prescribed flow driver for testing microphysics schemes. It uses   ClimaCore.jl operators and   CloudMicrophysics.jl tendencies   to create the numerical problem that is then solved using   OrdinaryDiffEq.jl.","category":"page"},{"location":"#Simulation-setup","page":"Home","title":"Simulation setup","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The setup is based on the kinematic framework introduced by [1]: Vertical momentum flux is constant with height and varying in time. Density and temerature profiles are constant and defined by the initial   condition, which is unsaturated. As the simulation progresses in time moisture is transported upwards,   supersaturation grows in the upper part of the domain   and precipitation is formed. In the second part of the simulation the vertical momentum flux is switched off,   leaving only cloud microphysics tendencies acting to change   the model state. Below figure shows an example prescribed vertical momentum as a function of time.","category":"page"},{"location":"","page":"Home","title":"Home","text":"using Plots\nimport Kinematic1D.K1DModel as K1D\n\nt_range = range(0, 15 * 60, length=100)\nw1 = 2.0\nt1 = 600.0\nplot(t_range / 60.0, [K1D.ρw_helper(t, w1, t1) for t in t_range], linewidth=3, xlabel=\"t [min]\", ylabel=\"updraft momentum flux [m/s kg/m3]\")\nsavefig(\"prescribed_momentum_flux.svg\") #hide","category":"page"},{"location":"","page":"Home","title":"Home","text":"(Image: )","category":"page"},{"location":"#Changes-to-CliMA-defaults","page":"Home","title":"Changes to CliMA defaults","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"One of the goals of Kinematic1D.jl   is to test against PySDM   and the particle-based implementation of the kinematic model available in   PySDM-examples. As a result, some CliMA constants were changed from their default values to better match PySDM:","category":"page"},{"location":"","page":"Home","title":"Home","text":"symbol definition units default value new value\nMSLP Mean sea level pressure Pa 101325 10^5\ngrav Gravitational acceleration ms^2 981 980665\ngas_constant Universal gas constant JmolK 83144598 8314462618\nkappa_d Adiabatic exponent for dry air (2/7) - 028571428571 02855747338575384\ncp_v Isobaric specific heat of water vapor JkgK 1859 1850\nmolmass_dryair Molecular mass of dry air kgmol 002897 002896998\nmolmass_water Molecular mass of water kgmol 001801528 0018015\nqliqthreshold Cloud liquid water autoconversion threshold kgkg 00005 00001","category":"page"},{"location":"#Comparison-with-PySDM","page":"Home","title":"Comparison with PySDM","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"TODO","category":"page"}]
}
