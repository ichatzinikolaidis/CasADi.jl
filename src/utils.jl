##################################################
# avoid type piracy. After we call `pytype` mappings, some objects are automatically converted and no longer PyObjects
pycall_hasproperty(x::PyCall.PyObject, k) = PyCall.hasproperty(x, k)
pycall_hasproperty(x::SX, k) = PyCall.hasproperty(PyCall.PyObject(x), k)
pycall_hasproperty(x, k) = false
