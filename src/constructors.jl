for i ∈ casadi_types
    @eval begin
        $i(x::$i) = x
        $i(x::T) where {T <: Union{Real, AbstractVecOrMat}} = casadi.hcat([casadi.vcat(i) for i in eachcol(x)])

        $i(x::AbstractString) = casadi.$i.sym(x)
        $i(x::AbstractString, i1::Integer) = casadi.$i.sym(x, i1, 1)
        $i(x::AbstractString, i1::Integer, i2::Integer) = casadi.$i.sym(x, i1, i2)
        convert(::Type{$i}, s::AbstractString) = $i(s)

        $i(i1::Integer, i2::Integer) = casadi.$i(i1, i2)
    end
end
