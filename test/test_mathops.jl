@testset "Cross product for $i                             " for i ∈ cas_symbol
    @eval begin
        import LinearAlgebra: cross, ×

        n₁ = rand(3)
        n₂ = rand(3)
        c₁ = $i(n₁)
        c₂ = $i(n₂)

        n₁₂ = n₁×n₂
        c₁₂ = c₁×c₂
        @test casadi.evalf(c₁₂).toarray()[:] == n₁₂

        c₁₂ = cross(c₁, c₂)
        @test casadi.evalf(c₁₂).toarray()[:] == n₁₂
    end
end
