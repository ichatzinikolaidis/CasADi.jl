cas_symbol = [:SX, :MX]

@testset "Transform $i to null, scalar, Vector, and Matrix" for i ∈ cas_symbol
  @eval begin
    null_symbol = $i("null_symbol", 0)
    scalar = $i("scalar", 1)
    V = $i("V1", 3) - $i("V2", 3)
    M = $i("M1", 2, 4) - $i("M2", 2, 4)

    @test Vector(null_symbol) == Vector{Any}()
    @test Matrix(null_symbol) == Vector{Any}(undef,0)
    @test casadi.is_equal($i( Vector(scalar) ), scalar)
    @test casadi.is_equal($i( Matrix(scalar) ), scalar)
    @test casadi.is_equal($i( Vector(V) ), V, 1)
    @test casadi.is_equal($i( Matrix(M) ), M, 1)
  end
end
