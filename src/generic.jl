for i ∈ casadi_types
    @eval begin
        ## Indexing
        Base.getindex(x::$i, j::Union{Int, UnitRange{Int}, Colon}) =
            x.x.__getitem__([1:length(x)...][j] .- 1)

        Base.getindex(x::$i, j1::Union{Int, UnitRange{Int}, Colon}, j2::Union{Int, UnitRange{Int}, Colon}) =
            x.x.__getitem__(LinearIndices( size(x) )[j1,j2] .- 1)

        # Last index
        Base.lastindex(x::$i) = casadi.$i.numel(x)
        function Base.lastindex(x::$i, j::Int)
            if j == 1
                return casadi.$i.size1(x)
            elseif j == 2
                return casadi.$i.size2(x)
            elseif j > 2
                return 1
            else
                throw( BoundsError(x, j) )
            end
        end

        ## one, zero, zeros, ones
        Base.one(::Type{$i}) = casadi.$i.eye(1)
        Base.one(x::$i) = casadi.$i.size1(x) == casadi.$i.size2(x) ?
            casadi.$i.eye( casadi.$i.size1(x) ) :
            throw(DimensionMismatch("multiplicative identity defined only for square matrices"))

        Base.zero(::Type{$i}) = casadi.$i.zeros()
        Base.zero(x::$i) = casadi.$i.zeros( casadi.$i.size(x) )

        Base.zeros(::Type{$i}, j::Integer) = casadi.$i.zeros(j)
        Base.zeros(::Type{$i}, j1::Integer, j2::Integer) = casadi.$i.zeros(j1, j2)

        Base.ones(::Type{$i}, j::Integer) = casadi.$i.zeros(j)
        Base.ones(::Type{$i}, j1::Integer, j2::Integer) = casadi.$i.zeros(j1, j2)

        ## Adjoint and transpose
        Base.adjoint(x::$i) = casadi.transpose(x)
        Base.transpose(x::$i) = casadi.transpose(x)

        Base.length(x::$i) = casadi.$i.numel(x)
    end
end
