SX(x::SX) = x
SX(x::T) where {T <: Union{Real, AbstractVecOrMat}} = casadi.hcat([casadi.vcat(i) for i in eachcol(x)])

SX(x::AbstractString) = casadi.SX.sym(x)
SX(x::AbstractString, i1::Integer) = casadi.SX.sym(x, i1, 1)
SX(x::AbstractString, i1::Integer, i2::Integer) = casadi.SX.sym(x, i1, i2)
convert(::Type{SX}, s::AbstractString) = SX(s)

SX(i1::Integer, i2::Integer) = casadi.SX(i1, i2)
