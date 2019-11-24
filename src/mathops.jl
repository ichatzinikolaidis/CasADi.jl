## Unary operations
-(x::T) where T <: CasadiSymbolicObject = casadi.minus(0., x)

## Binary operations
+(x::T, y::T) where T <: CasadiSymbolicObject = casadi.plus(x, y)
-(x::T, y::T) where T <: CasadiSymbolicObject = casadi.minus(x, y)
/(x::T, y::T) where T <: CasadiSymbolicObject = casadi.mrdivide(x, y)
^(x::T, y::T) where T <: CasadiSymbolicObject = casadi.power(x, y)
\(x::T, y::T) where T <: CasadiSymbolicObject = casadi.solve(x, y)

*(x::Union{C, T}, y::Union{C, T}) where {C <: CasadiSymbolicObject, T <: Real} =
  if size(x,2) == size(y,1) casadi.mtimes( C(x), C(y) )
  else casadi.times( C(x), C(y) ) end

## Comparisons
>=(x::T, y::T) where T <: CasadiSymbolicObject = casadi.ge(x, y)
>(x::T, y::T)  where T <: CasadiSymbolicObject = casadi.gt(x, y)
<=(x::T, y::T) where T <: CasadiSymbolicObject = casadi.le(x, y)
<(x::T, y::T)  where T <: CasadiSymbolicObject = casadi.lt(x, y)
==(x::T, y::T) where T <: CasadiSymbolicObject = casadi.eq(x, y)

## Linear algebra
cross(x::T, y::T) where T <: CasadiSymbolicObject = casadi.cross(x, y)
