function test_types(::Type{T}) where T <: CasadiSymbolicObject
    @testset "$( string("Console output for ", T, "                            ") )" begin
        @test ( @capture_out show( T(1) ) ) == "1"
        @test ( @capture_out show( T([1 ; 2.1]) ) ) == "[1, 2.1]"
        @test ( @capture_out show( T([1 0 ; 2.1 -3]) ) ) == "\n[[1, 0], \n [2.1, -3]]"
        @test ( @capture_out show( T("x") ) ) == "x"
    end
end
