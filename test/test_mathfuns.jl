function test_mathfuns(::Type{T}) where T <: CasadiSymbolicObject
    @testset "$( string("Math functions for ", T, "                            ") )" begin
        x = randn()

        @test to_julia.( sincos( T(x) ) ) == sincos(x)
        @test to_julia( sinc( T(x) ) )    ≈ sinc(x/π)
        @test to_julia( abs( T(x) ) )     ≈ abs(x)
    end
end
