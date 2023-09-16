`timescale 1 ns / 1 ns



module register_file_tests;

    reg [15:0] DataInA;
    reg [15:0] DataInB;
    reg [3:0] AddressA;
    reg [3:0] AddressB;
    reg ClockA;
    reg ClockB;
    reg ClockEnA;
    reg ClockEnB;
    reg WrA;
    reg WrB;
    reg ResetA;
    reg ResetB;
    wire [15:0] QA;
    wire [15:0] QB;
	
	// For reference
	reg FETCH,DECODE,EXECUTE,COMMIT;
	
	register_file rf(
	.DataInA( DataInA), .DataInB( DataInB), .AddressA( AddressA), .AddressB( AddressB), 
    .ClockA( ClockA), .ClockB(ClockB ), .ClockEnA(ClockEnA ), .ClockEnB( ClockEnB), .WrA(WrA ), .WrB( WrB), 
    .ResetA(ResetA ), .ResetB(ResetB ), .QA(QA ), .QB( QB)
	);
	
	PUR PUR_INST(.PUR(1'b1));
	GSR GSR_INST(.GSR(1'b1));
	parameter CLOCK_HALF_CYCLE = 50;
	parameter INSTRUCTION_CYCLE = 400;


	initial begin
		DataInA = 16'h1234;
		DataInB = 16'h5678;
		AddressA = 4'b0000;
		AddressB = 4'b1000;
		ClockA = 0;
		ClockB = 0;
		ClockEnA = 1;
		ClockEnB = 1;
		WrA = 0;
		WrB = 0;
		ResetA = 0;
		ResetB = 0;
		FETCH = 1;
		DECODE = 0;
		EXECUTE = 0;
		COMMIT = 0;
	end
	
	always begin
		#CLOCK_HALF_CYCLE;
		ClockA = 1;
		ClockB = 1;
		COMMIT = 0;
		FETCH = 1;
		#CLOCK_HALF_CYCLE;
		ClockA = 0;
		ClockB = 0;
		#CLOCK_HALF_CYCLE;
		ClockA = 1;
		ClockB = 1;
		FETCH = 0;
		DECODE = 1;
		#CLOCK_HALF_CYCLE;
		ClockA = 0;
		ClockB = 0;
		#CLOCK_HALF_CYCLE;
		ClockA = 1;
		ClockB = 1;
		DECODE = 0;
		EXECUTE = 1;
		#CLOCK_HALF_CYCLE;
		ClockA = 0;
		ClockB = 0;
		#CLOCK_HALF_CYCLE;
		ClockA = 1;
		ClockB = 1;
		EXECUTE = 0;
		COMMIT = 1;
		#CLOCK_HALF_CYCLE;
		ClockA = 0;
		ClockB = 0;
	end
	
	// Now the actual test vectors
	initial begin
		#(10) // Clock to signal delay
		#(INSTRUCTION_CYCLE)
		// load addra
		DataInA = 16'h1234;
		DataInB = 16'h5678;
		AddressA = 4'b0000;
		AddressB = 4'b1000;
		WrA = 1;
		WrB = 0;
		#(INSTRUCTION_CYCLE)
		WrA = 0;
		WrB = 1;
		#(INSTRUCTION_CYCLE)
		WrA = 0;
		WrB = 0;
	end
	
endmodule