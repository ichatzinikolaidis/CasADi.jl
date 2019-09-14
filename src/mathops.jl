for i ∈ casadi_types
    @eval begin
        ## Binary operations
        +(x::$i, y::$i) = pycall(casadi.plus, $i, x, y)
        *(x::$i, y::$i) = pycall(casadi.mtimes, $i, x, y)
        -(x::$i, y::$i) = pycall(casadi.minus, $i, x, y)
        -(x::$i) = pycall(casadi.minus, $i, 0, x)
        /(x::$i, y::$i) = pycall(casadi.mrdivide, $i, x, y)
        ^(x::$i, y::$i) = pycall(casadi.power, $i, x, y)
        \(x::$i, y::$i) = pycall(casadi.mldivide, $i, x, y)

        ## Comparisons
        >=(x::$i, y::Real) = pycall(casadi.ge, $i, x, y)
        >(x::$i, y::Real)  = pycall(casadi.gt, $i, x, y)
        <=(x::$i, y::Real) = pycall(casadi.le, $i, x, y)
        <(x::$i, y::Real)  = pycall(casadi.lt, $i, x, y)
        ==(x::$i, y::Real) = pycall(casadi.eq, $i, x, y)

        ## Linear algebra
        cross(x::$i, y::$i) = casadi.cross(x, y)
    end
end
