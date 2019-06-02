## Trig
Base.sincos(x::CasadiSymbolicObject) = (sin(x), cos(x))

Base.abs(x::CasadiSymbolicObject) = casadi.norm_1(x)
