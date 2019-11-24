function test_mathops(::Type{T}) where T <: CasadiSymbolicObject
    @testset "$( string("Cross product for ", T, "                             ") )" begin
        n₁ = rand(3)
        n₂ = rand(3)
        c₁ = T(n₁)
        c₂ = T(n₂)

        n₁₂ = n₁×n₂
        c₁₂ = c₁×c₂
        @test casadi.evalf(c₁₂).toarray()[:] == n₁₂

        c₁₂ = cross(c₁, c₂)
        @test casadi.evalf(c₁₂).toarray()[:] == n₁₂
    end

    @testset "$( string("Unary operations for ", T, "                          ") )" begin
        x = randn()

        @test to_julia( -T(x) ) ≈ -x
    end

    @testset "$( string("Binary operations for ", T, "                         ") )" begin
        x = rand()
        y = rand()

        @test to_julia( T(x) + T(y) ) ≈ x + y
        @test to_julia( T(x) * T(y) ) ≈ x * y
        @test to_julia( T(x) - T(y) ) ≈ x - y
        @test to_julia( T(x) / T(y) ) ≈ x / y
        @test to_julia( T(x) ^ T(y) ) ≈ x ^ y
        @test to_julia( T(x) \ T(y) ) ≈ x \ y
    end

    @testset "$( string("Comparisons for ", T, "                               ") )" begin
        x = randn()
        y = x + rand()

        @test Bool( to_julia(T(y) >= T(x)) )
        @test Bool( to_julia(T(y) >  T(x)) )
        @test Bool( to_julia(T(x) <= T(y)) )
        @test Bool( to_julia(T(x) <  T(y)) )
        @test Bool( to_julia(T(x) == T(x)) )
    end
end
