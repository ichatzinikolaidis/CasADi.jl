## promote up to symbolic so that math ops work
promote_rule(::Type{T}, ::Type{S}) where {T<:CasadiSymbolicObject, S<:Real} = T
convert(::Type{T}, o::PyCall.PyObject) where {T <: CasadiSymbolicObject} = T(o)

for i ∈ casadi_types
    @eval begin
        convert(::Type{PyObject}, s::$i) = s.x

        ## real
        convert(::Type{S}, x::T) where {S<:$i, T <: Real} = casadi.$i(x)::S

        """

        Convert a numeric CasADi value to a numeric Julian value.

        """
        function N(x::$i)
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
        N(m::AbstractArray{$i}) = map(N, m)
    end
end
N(x::Real) = x
