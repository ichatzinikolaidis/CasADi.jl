__precompile__()
module CasADi

using PyCall

import Base: hcat, vcat
import Base: show
import Base: convert, promote_rule
import Base: getproperty
import Base: length, size
import Base: +, -, *, /, \, ^
import Base: >, >=, <, <=, ==

import LinearAlgebra: cross

casadi_types = (:SX, :MX)
for i ∈ casadi_types
    @eval export $i
end
export CasadiSymbolicObject

export casadi, to_julia, substitute

include("types.jl")
include("constructors.jl")
include("numbers.jl")
include("mathops.jl")
include("mathfuns.jl")
include("generic.jl")
include("utils.jl")

##################################################

const casadi = PyNULL()

function __init__()
    ## Define casadi
    copy!(casadi, pyimport_conda("casadi", "casadi", "conda-forge"))

    for i ∈ casadi_types
        @eval pytype_mapping(casadi.$i, $i)
    end
end

## Add generic and new methods
include("importexport.jl")

end # module
