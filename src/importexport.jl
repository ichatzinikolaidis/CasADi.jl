# Overloaded CasADi methods
generic_methods = (
    :inv, :sqrt,
    :sin, :cos,
    :vec, :transpose
)
for j ∈ generic_methods
    @eval Base.$j(x::CasadiSymbolicObject) = getproperty( casadi, Symbol($j) )(x)
end

for i ∈ casadi_types
    @eval Base.hcat(x::Vector{$i}) = getproperty(casadi, :hcat)(x)
    @eval Base.vcat(x::Vector{$i}) = getproperty(casadi, :vcat)(x)
end

Base.size(x::CasadiSymbolicObject) = x.size()
Base.reshape(x::CasadiSymbolicObject, t::Tuple{Int, Int}) = getproperty( casadi, Symbol(:reshape) )(x, t)
