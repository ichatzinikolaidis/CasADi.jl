function test_generic(::Type{T}) where T <: CasadiSymbolicObject
    @testset "$( string("Transform ", T, " to null, scalar, Vector, and Matrix ") )" begin
        null_symbol = T("null_symbol", 0)
        scalar = T("scalar", 1)
        V = T("V1", 3) - T("V2", 3)
        M = T("M1", 2, 4) - T("M2", 2, 4)

        @test Vector(null_symbol) == Vector{Any}()
        @test Matrix(null_symbol) == Vector{Any}(undef,0)
        @test casadi.is_equal(T( Vector(scalar) ), scalar)
        @test casadi.is_equal(T( Matrix(scalar) ), scalar)
        @test casadi.is_equal(T( Vector(V) ), V, 1)
        @test casadi.is_equal(T( Matrix(M) ), M, 1)
    end

    @testset "$( string("Get index for ", T, "                                 ") )" begin
        s = randn(); S = T(s)
        v = randn(4); V = T(v)
        m = randn(5,5); M = T(m)

        @test to_julia(S[1])   ≈ s
        @test to_julia(S[1:1]) ≈ s
        @test to_julia(S[:])   ≈ s
        @test to_julia(V[3])   ≈ v[3]
        @test to_julia(V[2:4]) ≈ v[2:4]
        @test to_julia(V[:])   ≈ v[:]
        @test to_julia(M[3])   ≈ m[3]
        @test to_julia(M[4:9]) ≈ m[4:9]
        @test to_julia(M[:])   ≈ m[:]

        @test to_julia(S[1,1])   ≈ s
        @test to_julia(S[1:1,1]) ≈ s
        @test to_julia(S[1,:])   ≈ s
        @test to_julia(V[2,1])   ≈ v[2]
        @test to_julia(V[2:4,1]) ≈ v[2:4]
        @test to_julia(V[3,:])   ≈ v[3]
        @test to_julia(M[3,5])   ≈ m[3,5]
        @test to_julia(M[3,2:4]) ≈ m[3,2:4]
        @test to_julia(M[1:3,:]) ≈ m[1:3,:]
    end

    @testset "$( string("Set index for ", T, "                                 ") )" begin
        s = randn(); S = T(s)
        v = randn(4); V = T(v)
        m = randn(5,5); M = T(m)

        S[1] = 1.
        @test to_julia(S) == 1.
        S[1:1] = 2.
        @test to_julia(S) == 2.
        S[:] = 3.
        @test to_julia(S) == 3.
        V[2] = 1.
        v[2] = 1.
        @test to_julia(V) ≈ v
        V[2:3] = T([2. ; 3])
        v[2:3] = [2. ; 3]
        @test to_julia(V) ≈ v
        V[:] = T([1. ; 2 ; 3 ; 4])
        v[:] = [1. ; 2 ; 3 ; 4]
        @test to_julia(V) ≈ v
        M[17] = m[17] = rand()
        @test to_julia(M) ≈ m
        M[3:8] = zeros(T,6)
        m[3:8] .= 0.
        @test to_julia(M) ≈ m
        M[:] = ones(T,25)
        m[:] .= 1.
        @test to_julia(M) ≈ m

        S[1,1] = 2.
        @test to_julia(S) == 2.
        S[1,:] = 3.
        @test to_julia(S) == 3.
        S[:,1:1] = 4.
        @test to_julia(S) == 4.
        S[:,:] = 5.
        @test to_julia(S) == 5.
        V[3,1] = v[3,1] = 1.
        @test to_julia(V) ≈ v
        V[3,:] = 3.
        v[3] = 3.
        @test to_julia(V) ≈ v
        V[2:3,1:1] = 4.
        v[2:3] .= 4.
        @test to_julia(V) ≈ v
        V[:,:] = 5.
        v .= 5.
        @test to_julia(V) ≈ v
        M[3,4] = m[3,4] = 8.
        @test to_julia(M) ≈ m
        M[3,:] = 9.
        m[3,:] .= 9.
        @test to_julia(M) ≈ m
        M[2:3,4:5] = 10.
        m[2:3,4:5] .= 10.
        @test to_julia(M) ≈ m
        M[:,:] = -5.
        m .= -5.
        @test to_julia(M) ≈ m
    end

    @testset "$( string("Last index for ", T, "                                ") )" begin
        s = randn(); S = T(s)
        v = randn(4); V = T(v)
        m = randn(5,5); M = T(m)

        @test to_julia(S[end]) ≈ s
        @test to_julia(S[:,end]) ≈ s
        @test to_julia(S[end,end]) ≈ s
        @test to_julia(V[end]) ≈ v[end]
        @test to_julia(V[end,:]) ≈ v[end]
        @test to_julia(V[:,end]) ≈ v
        @test to_julia(V[end,end]) ≈ v[end]
        @test to_julia(M[end]) ≈ m[end]
        @test to_julia(M[end,:]) ≈ m[end,:]
        @test to_julia(M[:,end]) ≈ m[:,end]
        @test to_julia(M[end,end]) ≈ m[end]
    end

    @testset "$( string("One, zero, ones, zeros for ", T, "                    ") )" begin
        @test to_julia( one(T) ) == 1.
        @test to_julia( one( T("x",5,5) ) ) == one( zeros(5,5) )
        @test_throws DimensionMismatch(
          "multiplicative identity defined only for square matrices") one( zeros(T,3,4) )

        @test to_julia( zero(T) ) == 0.
        @test to_julia( zero( T("x",3,4) ) ) == zeros(3,4)

        @test to_julia( ones(T,6) ) == ones(6)
        @test to_julia( ones(T,7,8) ) == ones(7,8)

        @test to_julia( zeros(T,2) ) == zeros(2)
        @test to_julia( zeros(T,1,9) ) == zeros(1,9)
    end

    @testset "$( string("Size related operations for ", T, "                   ") )" begin
        @test size(zeros(T,3), 1)  == 3
        @test size(zeros(T,3), 2)  == 1
        @test size(ones(T,4,5), 1) == 4
        @test size(ones(T,4,5), 2) == 5
        @test_throws DimensionMismatch(
          "arraysize: dimension out of range") size(zeros(T,3,3),3)
    end

    @testset "$( string("Concatenations for ", T, "                            ") )" begin
        M = rand(3,3)

        @test to_julia( hcat([T(M) ; T(M)]) ) ≈ hcat(M, M)
        @test to_julia( vcat([T(M) ; T(M)]) ) ≈ vcat(M, M)
    end

    @testset "$( string("Matrix operations for ", T, "                         ") )" begin
        m = rand(5,3)
        s = rand(6,6)
        M = T(m)
        S = T(s)

        @test to_julia( adjoint(M) ) ≈ m'
        @test to_julia( repeat(M,2,3) ) ≈ repeat(m,2,3)
    end

    @testset "$( string("Broadcasting for ", T, "                              ") )" begin
        m₁ = rand(3,6)
        M₁ = T(m₁)
        m₂ = rand(3,6)
        M₂ = T(m₂)

        @test to_julia(M₁.*M₂)  ≈ m₁.*m₂
        @test to_julia(M₁*M₂')  ≈ m₁*m₂'
        @test to_julia(M₁'*M₂)  ≈ m₁'*m₂
        @test to_julia(M₁.^M₂)  ≈ m₁.^m₂
        @test to_julia(M₁.^3)   ≈ m₁.^3
        @test to_julia(M₁.^2.1) ≈ m₁.^2.1
    end

    @testset "$( string("Return types for ", T, "                              ") )" begin
        M = T( rand(5,3) )
        S = T( rand(6,6) )

        @test eltype( transpose(M) ) == T
        @test eltype( transpose( Matrix(M) ) ) == T
        @test eltype( Symmetric( Matrix(S) ) ) == T

        @test eltype( Symmetric( Matrix( T(rand(5,5)) ) ) * Matrix( T(rand(5,5)) ) ) == T
    end

    @testset "$( string("Solve linear systems with ", T, "                     ") )" begin
        A = Matrix(2one(T(3,3)))
        b = Vector(T([2, 4, 8]))

        @test to_julia.(A\b) ≈ [1.0, 2.0, 4.0]
    end
end
