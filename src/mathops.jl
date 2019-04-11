## evaluate binary operations of symbolic objects
+(x::CasadiSymbolicObject, y::CasadiSymbolicObject) = pycall(casadi.plus, SX, x, y)
*(x::CasadiSymbolicObject, y::CasadiSymbolicObject) = pycall(casadi.mtimes, SX, x, y)
-(x::CasadiSymbolicObject, y::CasadiSymbolicObject) = pycall(casadi.minus, SX, x, y)
-(x::CasadiSymbolicObject) = pycall(casadi.minus, SX, 0, x)
/(x::CasadiSymbolicObject, y::CasadiSymbolicObject) = pycall(casadi.mrdivide, SX, x, y)
^(x::CasadiSymbolicObject, y::CasadiSymbolicObject) = pycall(casadi.power, SX, x, y)
\(x::CasadiSymbolicObject, y::CasadiSymbolicObject) = pycall(casadi.mldivide, SX, x, y)
