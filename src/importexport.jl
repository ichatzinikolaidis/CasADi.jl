# Overloaded CasADi methods
generic_methods = (
    # linear algebra
    :inv, :sqrt,

    # Trigonometric
    :sin, :cos,

    :vec
)

for j ∈ generic_methods
    @eval Base.$j(x::CasadiSymbolicObject) = getproperty( casadi, Symbol($j) )(x)
end

Base.reshape(x::CasadiSymbolicObject, t::Tuple{Int, Int}) = getproperty( casadi, Symbol(:reshape) )(x, t)

type_specific_methods = (
    :size,
)

for i ∈ casadi_types, j ∈ type_specific_methods
    @eval Base.$j(x::$i) = getproperty( casadi.$i, Symbol($j) )(x)
end

# Concatenation
for i ∈ casadi_types
    @eval Base.hcat(x::VecOrMat{$i}) = getproperty(casadi, :hcat)(x)
    @eval Base.vcat(x::VecOrMat{$i}) = getproperty(casadi, :vcat)(x)
end
