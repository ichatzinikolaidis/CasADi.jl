## Trig
Base.sincos(x::CasadiSymbolicObject) = (sin(x), cos(x))
Base.sinc(x::CasadiSymbolicObject) = sin(x)/x

Base.abs(x::T) where T <: CasadiSymbolicObject = pycall(casadi.fabs, T, x)
