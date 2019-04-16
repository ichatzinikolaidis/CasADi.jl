##################################################
## CasadiSymbolicObject types have field x::PyCall.PyObject

## Symbol class for controlling dispatch
abstract type CasadiSymbolicObject <: Real end

for i in casadi_types
    @eval begin
        struct $i <: CasadiSymbolicObject
            x::PyCall.PyObject
        end
    end
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
for i in casadi_types
    @eval Base.show(io::IO, s::$i) = print(io, jprint(s))
end
Base.show(io::IO, ::MIME"text/plain", s::CasadiSymbolicObject) = print(io, jprint(s))

function Base.getproperty(o::T, s::Symbol) where {T <: CasadiSymbolicObject}
    if (s in fieldnames(T))
        getfield(o, s)
    else
        getproperty(PyCall.PyObject(o), s)
    end
end

for i in casadi_types
    @eval Base.convert(::Type{$i}, x::PyCall.PyObject) = $i(x)
end
