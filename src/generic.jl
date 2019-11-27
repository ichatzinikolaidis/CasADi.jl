## Indexing
Base.getindex(
  x::CasadiSymbolicObject,
  j::Union{Int, UnitRange{Int}, Colon}
) = get(x.x, ( 1:length(x) )[j] .- 1)

Base.getindex(
  x::CasadiSymbolicObject,
  j1::Union{Int, UnitRange{Int}, Colon},
  j2::Union{Int, UnitRange{Int}, Colon}
) = get(x.x, LinearIndices( size(x) )[j1,j2] .- 1)

Base.setindex!(
  x::CasadiSymbolicObject,
  v::Real,
  j::Union{Int, UnitRange{Int}, Colon}
) = set!(x.x, ( 1:length(x) )[if (j isa Int) j:j else j end] .- 1, v)

function Base.setindex!(
  x::CasadiSymbolicObject,
  v::Real,
  j1::Union{Int, UnitRange{Int}, Colon},
  j2::Union{Int, UnitRange{Int}, Colon}
)
    J1 = if (j1 isa Int) j1:j1 else j1 end
    J2 = if (j2 isa Int) j2:j2 else j2 end

    set!(x.x, LinearIndices( size(x) )[J1,J2] .- 1, v)
end

Base.lastindex(x::CasadiSymbolicObject) = length(x)
Base.lastindex(x::CasadiSymbolicObject, j::Int) = size(x,j)

for i ∈ casadi_types
    @eval begin
        ## one, zero, zeros, ones
        Base.one(::Type{$i}) = casadi.$i.eye(1)
        Base.one(x::$i) =
          if size(x,1) == size(x,2)
            casadi.$i.eye( size(x,1) )
          else
            throw(DimensionMismatch("multiplicative identity defined only for square matrices"))
          end

        Base.zero(::Type{$i}) = casadi.$i.zeros()
        Base.zero(x::$i) = casadi.$i.zeros( size(x) )

        Base.ones(::Type{$i}, j::Integer) = casadi.$i.ones(j)
        Base.ones(::Type{$i}, j1::Integer, j2::Integer) = casadi.$i.ones(j1, j2)

        Base.zeros(::Type{$i}, j::Integer) = casadi.$i.zeros(j)
        Base.zeros(::Type{$i}, j1::Integer, j2::Integer) = casadi.$i.zeros(j1, j2)

        ## Size related operations
        function Base.size(x::$i, j::Integer)
            if j == 1
                return casadi.$i.size1(x)
            elseif j == 2
                return casadi.$i.size2(x)
            else
                throw(DimensionMismatch("arraysize: dimension out of range"))
            end
        end
        Base.length(x::$i) = casadi.$i.numel(x)
    end
end

## Matrix operations
Base.transpose(x::T) where T <: CasadiSymbolicObject = casadi.transpose(x)::T
Base.adjoint(x::CasadiSymbolicObject) = transpose(x)
Base.repeat(x::CasadiSymbolicObject, counts::Integer...) = casadi.repmat(x, counts...)

## To/From array
# From vector to SX/MX
Base.convert(::Type{C}, V::AbstractVector{C}) where C <: CasadiSymbolicObject = casadi.vcat(V)

# From matrix to SX/MX
Base.convert(::Type{C}, M::AbstractMatrix{C}) where C <: CasadiSymbolicObject = casadi.blockcat(M)

# Convert SX/MX to vector
Base.Vector(V::CasadiSymbolicObject) = casadi.vertsplit(V)

# Convert SX/MX to matrix
Base.Matrix(M::CasadiSymbolicObject) = casadi.blocksplit(M)
