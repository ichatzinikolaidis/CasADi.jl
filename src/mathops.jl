for i ∈ casadi_types
    @eval begin
        ## evaluate binary operations of symbolic objects
        +(x::$i, y::$i) = pycall(casadi.plus, $i, x, y)
        *(x::$i, y::$i) = pycall(casadi.mtimes, $i, x, y)
        -(x::$i, y::$i) = pycall(casadi.minus, $i, x, y)
        -(x::$i) = pycall(casadi.minus, $i, 0, x)
        /(x::$i, y::$i) = pycall(casadi.mrdivide, $i, x, y)
        ^(x::$i, y::$i) = pycall(casadi.power, $i, x, y)
        \(x::$i, y::$i) = pycall(casadi.mldivide, $i, x, y)
    end
end
