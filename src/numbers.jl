## promote up to symbolic so that math ops work
promote_rule(::Type{T}, ::Type{S}) where {T<:CasadiSymbolicObject, S<:Real} = T
convert(::Type{T}, o::PyCall.PyObject) where {T <: CasadiSymbolicObject} = T(o)
convert(::Type{PyObject}, s::CasadiSymbolicObject) = s.x

"""

Convert a numeric CasADi value to a numeric Julia value.

"""
function to_julia(x::CasadiSymbolicObject)
    if size(x,1) == 1 && size(x,2) == 1
        return casadi.evalf(x).toarray()[1]
    end
    if size(x,2) == 1
        return casadi.evalf(x).toarray()[:]
    end

    return reshape( casadi.evalf(x).toarray(), size(x) )
end
