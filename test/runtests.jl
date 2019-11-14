using Test, CasADi

cas_symbol = [:SX, :MX]

include("test_constructors.jl")
include("test_generic.jl")
include("test_mathops.jl")
include("test_numbers.jl")
