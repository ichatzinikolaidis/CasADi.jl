cas_symbol = [:SX, :MX]

@testset "Transform $i to null, scalar, Vector, and Matrix" for i ∈ cas_symbol
  @eval begin
    null_symbol = $i("null_symbol", 0)
    scalar = $i("scalar", 1)
    V = $i("V1", 3) - $i("V2", 3)
    M = $i("M1", 2, 4) - $i("M2", 2, 4)

    @test Vector(null_symbol) == Vector{Any}()
    @test Matrix(null_symbol) == Matrix{Any}(undef,0,1)
    @test Float64.(Vector(scalar) - [scalar]) == zeros(1)
    @test Float64.(Matrix(scalar) - [scalar]) == zeros(1,1)
    @test Float64.(Vector(V) - [V[1] ; V[2] ; V[3]]) == zeros(3)
    @test Float64.(Matrix(M) - [M[1,1] M[1,2] M[1,3] M[1,4];
                                M[2,1] M[2,2] M[2,3] M[2,4]]) == zeros(2,4)
  end
end
