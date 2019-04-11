##################################################
## CasadiSymbolicObject types have field x::PyCall.PyObject

## Symbol class for controlling dispatch
abstract type CasadiSymbolicObject <: Number end
struct SX <: CasadiSymbolicObject
    x::PyCall.PyObject
end

mutable struct SXmat <: CasadiSymbolicObject
    x::PyCall.PyObject
end

##################################################

## important override
## this allows most things to flow though PyCall
PyCall.PyObject(x::CasadiSymbolicObject) = x.x

##################################################

function jprint(x::CasadiSymbolicObject)
    out = PyCall.pycall(pybuiltin("str"), String, PyObject(x))
    out = replace(out, r"\*\*" => "^")
    out
end

## text/plain
Base.show(io::IO, s::SX) = print(io, jprint(s))
Base.show(io::IO, ::MIME"text/plain", s::CasadiSymbolicObject) = print(io, jprint(s))

function Base.getproperty(o::T, s::Symbol) where {T <: CasadiSymbolicObject}
    if (s in fieldnames(T))
        getfield(o, s)
    else
        getproperty(PyCall.PyObject(o), s)
    end
end

function Base.convert(::Type{SX}, x::PyCall.PyObject)
    SX(x)
end
