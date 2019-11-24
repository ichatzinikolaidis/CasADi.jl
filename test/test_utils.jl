function test_utils(::Type{T}) where T <: CasadiSymbolicObject
    @testset "$( string("Function 'substitute' for ", T, "                     ") )" begin
        x = T("x")
        y = T("y")
        z = T("z")
        f = x + 2y + z

        @test casadi.is_equal(substitute(f, x, y), y + 2y + z, 3)
        @test casadi.is_equal(substitute(f, z, 1), x + 2y + 1, 3)
        @test to_julia( substitute(f, [y z x], [-1 0 1]) ) == -1
        @test to_julia( substitute(f, [y; z; x], [2; 0; -4]) ) == 0
    end
end
