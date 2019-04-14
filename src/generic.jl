for i ∈ casadi_types
    @eval begin
        ## Iterator
        import Base.iterate
        iterate(x::$i) = (x.x, 0)
        iterate(x::$i, state) = nothing

        ## Indexing
        function Base.getindex(x::$i, j::Int)
            if j <= 0 || j > casadi.$i.numel(x)
                throw( BoundsError(x, j) )
            end
            item = x.x.__getitem__(j-1)
        end
        function Base.getindex(x::$i, j1::Int, j2::Int)
            if j1 <= 0 || j1 > casadi.$i.size1(x)
                throw( BoundsError(x, (j1,j2)) )
            end
            if j2 <= 0 || j2 > casadi.$i.size2(x)
                throw( BoundsError(x, (j1,j2)) )
            end
            item = x.x.__getitem__( j1-1 + (j2-1)*casadi.$i.size1(x) )
        end

        Base.lastindex(x::$i) = x.x.__getitem__(-1)
        Base.firstindex(x::$i) = x.x.__getitem__(-1)

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
    end
end
