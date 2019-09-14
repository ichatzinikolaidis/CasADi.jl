@testset "Construct constant $i from scalar, Vector, Matrix" for i ∈ cas_symbol
    @eval begin
        scalar1 = $i(1)
        scalar2 = $i(1.0)
        V = $i([1;2;3])
        M = $i([1 2 ; 3 4 ; 5 6])

        @test casadi.is_equal(casadi.$i(1), scalar1, 1)
        @test casadi.is_equal(casadi.$i(1.0), scalar2, 1)
        @test casadi.is_equal(scalar1, scalar2, 1)
        @test casadi.is_equal(casadi.$i([1;2;3]), V, 1)
        @test casadi.is_equal(casadi.$i([1 2 ; 3 4 ; 5 6]), M, 1)
    end
end

@testset "Construct variable $i vector and matrix          " for i ∈ cas_symbol
    @eval begin
        v = casadi.$i.sym("v",3)
        V = $i("V",3)
        v_val = rand(3)
        @test casadi.is_equal(casadi.substitute(v,v,v_val), casadi.substitute(V,V,v_val), 1)

        m = casadi.$i.sym("m",2,4)
        M = $i("M",2,4)
        m_val = rand(2,4)
        @test casadi.is_equal(casadi.substitute(m,m,m_val), casadi.substitute(M,M,m_val), 1)
    end
end

@testset "AbstractFloat and Integer constructors           " for i ∈ cas_symbol
    @eval begin
        af = [1.2 ; -0.0 ; -4.3]
        @test casadi.is_equal($i(af)', casadi.$i(af)', 2)

        int = [1 ; 0 ; -2]
        @test casadi.is_equal($i(int)', casadi.$i(int)', 2)
    end
end
