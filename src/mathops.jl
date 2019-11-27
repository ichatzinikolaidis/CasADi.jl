## Unary operations
-(x::T) where T <: CasadiSymbolicObject = pycall(casadi.minus, T, 0, x)

## Binary operations
+(x::T, y::T) where T <: CasadiSymbolicObject = pycall(casadi.plus, T, x, y)
-(x::T, y::T) where T <: CasadiSymbolicObject = pycall(casadi.minus, T, x, y)
/(x::T, y::T) where T <: CasadiSymbolicObject = pycall(casadi.mrdivide, T, x, y)
^(x::T, y::T) where T <: CasadiSymbolicObject = pycall(casadi.power, T, x, y)
\(x::T, y::T) where T <: CasadiSymbolicObject = pycall(casadi.solve, T, x, y)

*(x::Union{C, T}, y::Union{C, T}) where {C <: CasadiSymbolicObject, T <: Real} =
  if size(x,2) == size(y,1) pycall(casadi.mtimes, C, x, y)
  else pycall(casadi.times, C, x, y) end

## Comparisons
>=(x::T, y::T) where T <: CasadiSymbolicObject = pycall(casadi.ge, T, x, y)
>(x::T, y::T)  where T <: CasadiSymbolicObject = pycall(casadi.gt, T, x, y)
<=(x::T, y::T) where T <: CasadiSymbolicObject = pycall(casadi.le, T, x, y)
<(x::T, y::T)  where T <: CasadiSymbolicObject = pycall(casadi.lt, T, x, y)
==(x::T, y::T) where T <: CasadiSymbolicObject = pycall(casadi.eq, T, x, y)

## Linear algebra
cross(x::T, y::T) where T <: CasadiSymbolicObject = pycall(casadi.cross, T, x, y)
