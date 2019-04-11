## Iterator for Sym
import Base.iterate
iterate(x::SX) = (x.x, 0)
iterate(x::SX, state) = nothing

## one, zero, ones
Base.one(::Type{SX}) = casadi.SX(1)
Base.one(x::SX) = casadi.SX(1)

Base.zero(::Type{SX}) = casadi.SX.zeros()
Base.zero(x::SX) = casadi.SX.zeros()
