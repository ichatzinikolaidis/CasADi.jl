function test_constructors(::Type{T}) where T <: CasadiSymbolicObject
    @testset "$( string("Construct constant ", T, " from scalar, Vector, Matrix") )" begin
        scalar1 = T(1)
        scalar2 = T(1.0)
        V = T([1;2;3])
        M = T([1 2 ; 3 4 ; 5 6])

        @test casadi.is_equal(eval( Meta.parse( string("casadi.", T) ) )(1), scalar1, 1)
        @test casadi.is_equal(eval( Meta.parse( string("casadi.", T) ) )(1.0), scalar2, 1)
        @test casadi.is_equal(scalar1, scalar2, 1)
        @test casadi.is_equal(eval( Meta.parse( string("casadi.", T) ) )([1;2;3]), V, 1)
        @test casadi.is_equal(eval( Meta.parse( string("casadi.", T) ) )([1 2;3 4;5 6]), M, 1)
    end

    @testset "$( string("Construct variable ", T, " vector and matrix          ") )" begin
        v = eval( Meta.parse( string("casadi.", T, ".sym") ) )("v",3)
        V = T("V",3)
        v_val = rand(3)
        @test casadi.is_equal(casadi.substitute(v,v,v_val), casadi.substitute(V,V,v_val), 1)

        m = eval( Meta.parse( string("casadi.", T, ".sym") ) )("m",2,4)
        M = T("M",2,4)
        m_val = rand(2,4)
        @test casadi.is_equal(casadi.substitute(m,m,m_val), casadi.substitute(M,M,m_val), 1)
    end

    @testset "$( string("AbstractFloat and Integer constructors for ", T, "    ") )" begin
        af = [1.2 ; -0.0 ; -4.3]
        @test casadi.is_equal(T(af)', eval( Meta.parse( string("casadi.", T) ) )(af)', 2)

        int = [1 ; 0 ; -2]
        @test casadi.is_equal(T(int)', eval( Meta.parse( string("casadi.", T) ) )(int)', 2)
    end

    @testset "$( string("Other constructors tests for ", T, "                  ") )" begin
        x = T("x")
        @test casadi.is_equal(T(x), x)

        @test convert(T, "y").name() == "y"

        @test to_julia( T(3,2) ) == zeros(3,2)
    end
end
