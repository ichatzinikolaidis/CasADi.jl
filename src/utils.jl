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
        substitute(ex::Vector{$i}, vars::Vector{$i}, vals::Union{Vector{Float64}, Vector{$i}}) = casadi.substitute(ex, [vcat(vars)], [vcat(vals)])
    end
end
