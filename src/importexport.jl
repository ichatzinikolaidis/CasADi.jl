Base.inv(x::T) where T <: CasadiSymbolicObject = pycall(casadi.inv, T, x)
Base.sqrt(x::T) where T <: CasadiSymbolicObject = pycall(casadi.sqrt, T, x)
Base.sin(x::T) where T <: CasadiSymbolicObject = pycall(casadi.sin, T, x)
Base.cos(x::T) where T <: CasadiSymbolicObject = pycall(casadi.cos, T, x)
Base.vec(x::T) where T <: CasadiSymbolicObject = pycall(casadi.vec, T, x)
Base.transpose(x::T) where T <: CasadiSymbolicObject = pycall(casadi.transpose, T, x)

Base.size(x::CasadiSymbolicObject) = x.size()
Base.reshape(x::T, t::Tuple{Int, Int}) where T <: CasadiSymbolicObject = pycall(casadi.reshape, T, x, t)
