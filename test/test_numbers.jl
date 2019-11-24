function test_numbers(::Type{T}) where T <: CasadiSymbolicObject
    @testset "$( string("Conversion of numeric ", T, " to Julia                ") )" begin
        x₁ = rand()
        x₂ = rand(3)
        x₃ = [rand(1,2); Inf -Inf]

        @test to_julia( T( 0) ) == 0.
        @test to_julia( T(-0) ) == 0.
        @test to_julia( T(-Inf) ) == -Inf
        @test to_julia( T( Inf) ) == Inf
        @test to_julia( T(x₁) ) == x₁
        @test to_julia( T(x₂) ) == x₂
        @test to_julia( T(x₃) ) == x₃
    end
end
