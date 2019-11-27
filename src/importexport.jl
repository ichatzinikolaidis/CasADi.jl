unary_homonymous_methods = (
    :inv, :sqrt,
    :sin, :cos,
    :vec, :transpose
)
for j ∈ unary_homonymous_methods
    @eval Base.$j(x::T) where T <: CasadiSymbolicObject = pycall(casadi.$j, T, x)
end

Base.size(x::T) where T <: CasadiSymbolicObject = x.size()

Base.reshape(x::T, t::Tuple{Int, Int}) where T <: CasadiSymbolicObject =
  pycall(casadi.reshape, T, x, t)
