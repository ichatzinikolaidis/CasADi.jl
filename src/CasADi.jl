module CasADi

using PyCall

import Base: show
import Base: convert, promote_rule
import Base: getproperty
import Base: length, size
import Base.iterate
import Base: +, -, *, /, \, ^

export SX
export True, False
export N

export casadi

include("types.jl")
include("constructors.jl")
include("numbers.jl")
include("mathops.jl")
include("mathfuns.jl")
include("generic.jl")
include("utils.jl")

##################################################

pynull() = PyCall.PyNULL()
const casadi = pynull()
const mpmath = pynull()

"True from CasADi"
global True = SX(pynull())
"False from CasADi"
global False = SX(pynull())

function __init__()
    ## Define casadi
    copy!(casadi, PyCall.pyimport_conda("casadi", "casadi"))
    copy!(True.x, PyCall.PyObject(true))
    copy!(False.x, PyCall.PyObject(false))

    pytype_mapping(casadi.SX, SX)
end

## Add generic and new methods
include("importexport.jl")

end # module
