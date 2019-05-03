for i ∈ casadi_types
    @eval begin
        ## Indexing
        # Get index
        Base.getindex(x::$i, j::Union{Int, UnitRange{Int}, Colon}) =
            x.x.__getitem__([1:length(x)...][j] .- 1)

        function Base.getindex(x::$i, j1::Union{Int, UnitRange{Int}, Colon}, j2::Union{Int, UnitRange{Int}, Colon})
            shape = ( typeof(j1) == Colon ? size(x, 1) : length(j1),
                      typeof(j2) == Colon ? size(x, 2) : length(j2)
            )

            return reshape(x.x.__getitem__(LinearIndices( size(x) )[j1,j2] .- 1), shape)
        end

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

        # Set index
        Base.setindex!(x::$i, v::Real, j::Union{Int, UnitRange{Int}, Colon}) =
            x.x.__setitem__([1:length(x)...][j] .- 1, v)

        Base.setindex!(x::$i, v::Real, j1::Union{Int, UnitRange{Int}, Colon}, j2::Union{Int, UnitRange{Int}, Colon}) =
            x.x.__setitem__(LinearIndices( size(x) )[j1,j2] .- 1, v)

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

        ## Matrix operations
        Base.adjoint(x::$i) = casadi.transpose(x)::$i
        Base.transpose(x::$i) = casadi.transpose(x)::$i
        Base.repeat(x::$i, counts::Integer...) = casadi.repmat(x, counts...)

        ## Size related operations
        function Base.size(x::$i, j::Integer)
            if j == 1
                return casadi.$i.size1(x)
            elseif j == 2
                return casadi.$i.size2(x)
            elseif j > 2
                return 1
            else
                error("arraysize: dimension out of range")
            end
        end
        Base.length(x::$i) = casadi.$i.numel(x)

        ## Broadcasting
        Broadcast.broadcasted(::typeof(*), x::$i, y::$i) = casadi.times(x, y)

        ## From array to CasADi
        function Base.convert(::Type{$i}, M::AbstractMatrix{T}) where {T <: Number}
            casadi.hcat([convert($i, M[:,i]) for i in 1:size(M,2)])
        end
        Base.convert(::Type{$i}, V::AbstractVector{T}) where {T <: Number} = casadi.vcat(V)
    end
end

## Convert SX/MX to array
Base.convert(::Type{Matrix{SX}}, M::SX) = reshape(casadi.SX.elements(M), M.x.shape)
Base.convert(::Type{Vector{SX}}, V::SX) = casadi.SX.elements(V)
