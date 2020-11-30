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

for i in cas_symbol
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

## Test examples
@testset "Test first example                                " begin
    x = SX("x")
    y = SX("y")
    α = 1
    b = 100
    f = (α - x)^2 + b*(y - x^2)^2

    nlp = Dict("x" => vcat([x ; y]), "f" => f)
    S = casadi.nlpsol("S", "ipopt", nlp, Dict("ipopt" => Dict("print_level" => 0), "verbose" => false))

    sol = S(x0 = [0, 0]);

    @test sol["x"].toarray()[1] ≈ 0.9999999999999899
    @test sol["x"].toarray()[2] ≈ 0.9999999999999792
end

@testset "Test second example                               " begin
    opti = casadi.Opti();

    x = opti._variable()
    y = opti._variable()

    opti.minimize( (y - x^2)^2 )
    opti._subject_to(x^2 + y^2 == 1)
    opti._subject_to(x + y >= 1)

    opti.solver("ipopt", Dict("verbose" => false), Dict("print_level" => 0));
    sol = opti.solve();

    @test sol.value(x) ≈ 0.7861513776531158
    @test sol.value(y) ≈ 0.6180339888825889
end
