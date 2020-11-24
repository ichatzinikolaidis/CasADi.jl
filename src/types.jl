##################################################
## CasadiSymbolicObject types have field x::PyCall.PyObject

## Symbol class for controlling dispatch
abstract type CasadiSymbolicObject <: Real end

struct SX <: CasadiSymbolicObject
    __pyobject__::PyCall.PyObject
end
struct MX <: CasadiSymbolicObject
    __pyobject__::PyCall.PyObject
end

Base.convert(::Type{C}, x::PyCall.PyObject) where C <: CasadiSymbolicObject = C(x)

##################################################

## important override
## this allows most things to flow though PyCall
PyCall.PyObject(x::CasadiSymbolicObject) = x.__pyobject__

##################################################

## text/plain
jprint(x::CasadiSymbolicObject) = PyCall.pycall(pybuiltin("str"), String, PyObject(x))
Base.show(io::IO, s::CasadiSymbolicObject) = print(io, jprint(s))

function Base.getproperty(o::C, s::Symbol) where C <: CasadiSymbolicObject
    if s in fieldnames(C)
        getfield(o, s)
    else
        getproperty(PyCall.PyObject(o), s)
    end
end
