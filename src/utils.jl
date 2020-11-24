##################################################
# avoid type piracy. After we call `pytype` mappings, some objects are automatically converted and no longer PyObjects
pycall_hasproperty(x::PyCall.PyObject, k) = PyCall.hasproperty(x, k)
pycall_hasproperty(x::CasadiSymbolicObject, k) = PyCall.hasproperty(PyCall.PyObject(x), k)
pycall_hasproperty(x, k) = false

## Extra functions
substitute(
  ex::Union{C, AbstractVector{C}, AbstractMatrix{C}},
  vars::C,
  vals::Number
) where C <: CasadiSymbolicObject = casadi.substitute( C(ex), C(vars), C(vals) )
substitute(
  ex::Union{C, AbstractVector{C}, AbstractMatrix{C}},
  vars::AbstractVector{C},
  vals::AbstractVector
) where C <: CasadiSymbolicObject = casadi.substitute( C(ex), C(vars), C(vals) )
substitute(
  ex::Union{C, AbstractVector{C}, AbstractMatrix{C}},
  vars::AbstractMatrix{C},
  vals::AbstractMatrix
) where C <: CasadiSymbolicObject = casadi.substitute( C(ex), C(vars), C(vals) )
