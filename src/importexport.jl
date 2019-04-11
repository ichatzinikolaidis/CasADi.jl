Base.inv(x::CasadiSymbolicObject) = getproperty(casadi, :inv)(x)
Base.adjoint(x::CasadiSymbolicObject) = getproperty(casadi, :transpose)(x)

# trigonometric functions
Base.cos(x::CasadiSymbolicObject) = getproperty(casadi, :cos)(x)
Base.sin(x::CasadiSymbolicObject) = getproperty(casadi, :sin)(x)

Base.hcat(x::CasadiSymbolicObject) = getproperty(casadi, :hcat)(x)
Base.vcat(x::CasadiSymbolicObject) = getproperty(casadi, :vcat)(x)

# SX specific
Base.size(x::SX) = getproperty(casadi.SX, :size)(x)
