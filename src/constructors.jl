## avoid PyObject conversion as possible
SX(x::T) where {T <: Number} = casadi.SX(x)

SX(x::AbstractString) = casadi.SX.sym(x)
SX(x::AbstractString, i1::Integer) = casadi.SX.sym(x, i1, 1)
SX(x::AbstractString, i1::Integer, i2::Integer) = casadi.SX.sym(x, i1, i2)
convert(::Type{SX}, s::AbstractString) = SX(s)

SX(i1::Integer, i2::Integer) = casadi.SX(i1, i2)

SXmat(X::SXmat) = X
SXmat(x::SX) = casadi.SX(x)
SXmat(M::Matrix) = casadi.SX([M[i,:] for i in 1:size(M)[1]])
