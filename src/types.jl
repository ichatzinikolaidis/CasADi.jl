##################################################
## CasadiSymbolicObject types have field x::PyCall.PyObject

## Symbol class for controlling dispatch
abstract type CasadiSymbolicObject <: Real end

for i in casadi_types
    @eval begin
        struct $i <: CasadiSymbolicObject
            x::PyCall.PyObject
        end

        Base.convert(::Type{$i}, x::PyCall.PyObject) = $i(x)
    end
end

##################################################

## important override
## this allows most things to flow though PyCall
PyCall.PyObject(x::CasadiSymbolicObject) = x.x

##################################################

## text/plain
jprint(x::CasadiSymbolicObject) = PyCall.pycall(pybuiltin("str"), String, PyObject(x))
Base.show(io::IO, s::CasadiSymbolicObject) = print(io, jprint(s))

Base.getproperty(o::T, s::Symbol) where {T <: CasadiSymbolicObject} =
    if (s in fieldnames(T)) getfield(o, s)
    else getproperty(PyCall.PyObject(o), s) end
