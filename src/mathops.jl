## Unary operations
-(x::C) where C <: CasadiSymbolicObject = pycall(casadi.minus, C, 0, x)

## Binary operations
+(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.plus, C, x, y)
-(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.minus, C, x, y)
/(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.mrdivide, C, x, y)
^(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.power, C, x, y)
^(x::C, y::Integer) where C <: CasadiSymbolicObject = pycall(casadi.power, C, x, y)
\(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.solve, C, x, y)

function *(x::C, y::Real) where C <: CasadiSymbolicObject
    if size(x,2) == size(y,1)
        pycall(casadi.mtimes, C, x, y)
    else 
        pycall(casadi.times, C, x, y)
    end
end

## Comparisons
>=(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.ge, C, x, y)
>(x::C, y::Real)  where C <: CasadiSymbolicObject = pycall(casadi.gt, C, x, y)
<=(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.le, C, x, y)
<(x::C, y::Real)  where C <: CasadiSymbolicObject = pycall(casadi.lt, C, x, y)
==(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.eq, C, x, y)

## Linear algebra
×(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.cross, C, x, y)
