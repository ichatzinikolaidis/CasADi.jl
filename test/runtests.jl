using Test, CasADi
import LinearAlgebra: cross, ×, Symmetric
import Suppressor: @capture_out

cas_symbol = [:SX, :MX]

include("test_constructors.jl")
include("test_generic.jl")
include("test_importexport.jl")
include("test_mathfuns.jl")
include("test_mathops.jl")
include("test_numbers.jl")
include("test_types.jl")
include("test_utils.jl")

for i ∈ cas_symbol
    @eval begin
        test_constructors($i)
        test_generic($i)
        test_importexport($i)
        test_mathfuns($i)
        test_mathops($i)
        test_numbers($i)
        test_types($i)
        test_utils($i)
    end
end
