## Trig
Base.sincos(x::CasadiSymbolicObject) = (sin(x), cos(x))
Base.sinc(x::CasadiSymbolicObject) = sin(x)/x

Base.abs(x::CasadiSymbolicObject) = casadi.fabs(x)
