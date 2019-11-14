@testset "Conversion of numeric SX to Julia                " begin
    x₁ = rand()
    x₂ = rand(3)
    x₃ = [rand(1,2); Inf -Inf]

    @test to_julia( SX( 0) ) == 0.
    @test to_julia( SX(-0) ) == 0.
    @test to_julia( SX(-Inf) ) == -Inf
    @test to_julia( SX( Inf) ) == Inf
    @test to_julia( SX(x₁) ) == x₁
    @test to_julia( SX(x₂) ) == x₂
    @test to_julia( SX(x₃) ) == x₃
end

@testset "Conversion of numeric MX to Julia                " begin
    x₁ = rand()
    x₂ = rand(3)
    x₃ = [rand(1,2); Inf -Inf]

    @test to_julia( MX( 0) ) == 0.
    @test to_julia( MX(-0) ) == 0.
    @test to_julia( MX(-Inf) ) == -Inf
    @test to_julia( MX( Inf) ) == Inf
    @test to_julia( MX(x₁) ) == x₁
    @test to_julia( MX(x₂) ) == x₂
    @test to_julia( MX(x₃) ) == x₃
end
