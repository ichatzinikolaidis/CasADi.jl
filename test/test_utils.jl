@testset "Function 'substitute' for SX                     " begin
    x = SX("x")
    y = SX("y")
    z = SX("z")
    f = x + 2y + z

    @test casadi.is_equal(substitute(f, x, y), y + 2y + z, 3)
    @test casadi.is_equal(substitute(f, z, 1), x + 2y + 1, 3)
    @test to_julia( substitute(f, [y z x], [-1 0 1]) ) == -1
    @test to_julia( substitute(f, [y; z; x], [2; 0; -4]) ) == 0
end

@testset "Function 'substitute' for MX                     " begin
    x = SX("x")
    y = SX("y")
    z = SX("z")
    f = x + 2y + z

    @test casadi.is_equal(substitute(f, x, y), y + 2y + z, 3)
    @test casadi.is_equal(substitute(f, z, 1), x + 2y + 1, 3)
    @test casadi.evalf( substitute(f, [y z x], [-1 0 1]) ).__array__()[1] == -1
    @test casadi.evalf( substitute(f, [y; z; x], [2; 0; -4]) ).__array__()[1] == 0
end
