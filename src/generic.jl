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

        ## one, zero, ones
        Base.one(::Type{$i}) = casadi.$i(1)
        Base.one(x::$i) = casadi.$i(1)

        Base.zero(::Type{$i}) = casadi.$i.zeros()
        Base.zero(::Type{$i}, j::Integer) = casadi.$i.zeros(j)
        Base.zero(::Type{$i}, j1::Integer, j2::Integer) = casadi.$i.zeros(j1, j2)
        Base.zero(x::$i) = casadi.$i.zeros()

        ## Adjoint and transpose
        Base.adjoint(x::$i) = casadi.transpose(x)
        Base.transpose(x::$i) = casadi.transpose(x)
    end
end
