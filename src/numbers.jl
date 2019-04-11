## promote up to symbolic so that math ops work
promote_rule(::Type{T}, ::Type{S}) where {T<:CasadiSymbolicObject, S<:Number} = T
convert(::Type{T}, o::PyCall.PyObject) where {T <: CasadiSymbolicObject} = T(o)
convert(::Type{PyObject}, s::SX) = s.x
## real
convert(::Type{S}, x::T) where {S<:CasadiSymbolicObject, T <: Real}= casadi.SX(x)::S
convert(::Type{T}, x::SX) where {T <: Real} = convert(T, PyObject(x))

"""

Convert a `SX` value to a numeric Julian value.

"""
function N(x::SX)
    if x.x.is_scalar()
        if x.x.is_constant()
            if x.x.is_zero()
                return 0
            elseif (x.x == x.x.inf() ).is_one()
                return Inf
            elseif (x.x == -x.x.inf() ).is_one()
                return -Inf
            end
            if x.x.is_integer()
                return convert(Int64, x)
            else
                return convert(Float64, x)
            end
        end
    end
end
N(x::Number) = x
N(m::AbstractArray{SX}) = map(N, m)
