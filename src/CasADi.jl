__precompile__()
module CasADi

using PyCall

import Base: convert, getproperty, hcat, length, promote_rule, show, size, vcat
import Base: +, -, *, /, \, ^
import Base: >, >=, <, <=, ==
import LinearAlgebra: ×

export CasadiSymbolicObject, SX, MX
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

    pytype_mapping(casadi.SX, SX)
    pytype_mapping(casadi.MX, MX)
end

## Add generic and new methods
include("importexport.jl")

end # module
