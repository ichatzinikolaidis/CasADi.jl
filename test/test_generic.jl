null_SX = SX("null_SX", 0)
scalar = SX("scalar", 1)
V = SX("V", 3)
M = SX("M", 2, 4)

@testset "Transform SX to null, scalar, Vector, and Matrix" begin
  @test Vector(null_SX) == Vector{Any}()
  @test Matrix(null_SX) == Matrix{Any}(undef,0,1)
  @test Float64.(Vector(scalar) - [scalar]) == zeros(1)
  @test Float64.(Matrix(scalar) - [scalar]) == zeros(1,1)
  @test Float64.(Vector(V) - [V[1] ; V[2] ; V[3]]) == zeros(3)
  @test Float64.(Matrix(M) - [M[1,1] M[1,2] M[1,3] M[1,4]; M[2,1] M[2,2] M[2,3] M[2,4]]) == zeros(2,4)
end
