## promote up to symbolic so that math ops work
promote_rule(::Type{T}, ::Type{S}) where {T<:CasadiSymbolicObject, S<:Real} = T
convert(::Type{T}, o::PyCall.PyObject) where {T <: CasadiSymbolicObject} = T(o)

for i ∈ casadi_types
    @eval begin
        convert(::Type{PyObject}, s::$i) = s.x
    end
end

"""

Convert a numeric CasADi value to a numeric Julia value.

"""
function to_julia(x::SX)
    if x.is_scalar()
        return casadi.DM(x).__array__()[1]
    end
    if x.is_vector()
        return casadi.DM(x).__array__()[:]
    end

    return casadi.DM(x).__array__()
end

function to_julia(x::MX)
    if x.is_scalar()
        return x.to_DM().__array__()[1]
    end
    if x.is_vector()
        return x.to_DM().__array__()[:]
    end

    return x.to_DM().__array__()
end
