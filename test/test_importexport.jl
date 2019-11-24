function test_importexport(::Type{T}) where T <: CasadiSymbolicObject
    @testset "$( string("Import export functions ", T, "                       ") )" begin
        M = rand(3,3)
        R = rand(5,3)

        @test to_julia( inv( T(M) ) )  ≈ inv(M)
        @test to_julia( sqrt( T(M) ) ) ≈ sqrt.(M)
        @test to_julia( sin( T(M) ) )  ≈ sin.(M)
        @test to_julia( cos( T(M) ) )  ≈ cos.(M)
        @test to_julia( vec( T(M) ) )  ≈ vec(M)
        @test to_julia(T(R)')  ≈ R'

        @test size( T(M) ) == size(M)
        @test to_julia( reshape( T(M), (9,1) ) ) ≈ reshape( M, (9,1) )
    end

    @testset "$( string("Concatenations for ", T, "                            ") )" begin
        M = rand(3,3)

        @test to_julia( hcat([T(M) ; T(M)]) ) ≈ hcat(M, M)
        @test to_julia( vcat([T(M) ; T(M)]) ) ≈ vcat(M, M)
    end
end
