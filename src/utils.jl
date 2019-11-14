##################################################
# avoid type piracy. After we call `pytype` mappings, some objects are automatically converted and no longer PyObjects
pycall_hasproperty(x::PyCall.PyObject, k) = PyCall.hasproperty(x, k)
for i ∈ casadi_types
    @eval pycall_hasproperty(x::$i, k) = PyCall.hasproperty(PyCall.PyObject(x), k)
end
pycall_hasproperty(x, k) = false

## Extra functions
for i ∈ casadi_types
    @eval begin
        substitute(
          ex::Union{$i, AbstractVector{$i}, AbstractMatrix{$i}},
          vars::$i,
          vals::Number
        ) = casadi.substitute( $i(ex), $i(vars), $i(vals) )
        substitute(
          ex::Union{$i, AbstractVector{$i}, AbstractMatrix{$i}},
          vars::AbstractVector{$i},
          vals::AbstractVector
        ) = casadi.substitute( $i(ex), $i(vars), $i(vals) )
        substitute(
          ex::Union{$i, AbstractVector{$i}, AbstractMatrix{$i}},
          vars::AbstractMatrix{$i},
          vals::AbstractMatrix
        ) = casadi.substitute( $i(ex), $i(vars), $i(vals) )
    end
end
