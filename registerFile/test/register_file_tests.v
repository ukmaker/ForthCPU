`timescale 1 ns / 1 ns

`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module register_file_tests;
	
	reg CLK;
	reg RESET;

	/**
	* Port A inputs
	**/
	reg [15:0] ALU_R;
	reg [15:0] PC_A;
	reg [15:0] ALUA_PP;
	/**
	* Port B inputs
	**/
	reg [15:0] DIN;
	
	/**
	* Port A controls
	**/
	reg REGA_EN;
	reg REGA_WEN;
	reg [3:0] ARGA_X;
	reg [2:0] REGA_ADDRX;
	reg [1:0] REGA_DINX;
	
	/**
	* Port B controls
	**/
	reg REGB_EN;
	reg REGB_WEN;
	reg [3:0] ARGB_X;
	reg [1:0] REGB_ADDRX;
	
	wire [15:0] REGA_DOUT;
	wire [15:0] REGB_DOUT;
	
	// For reference
	reg FETCH,DECODE,EXECUTE,COMMIT;
	
	register_file rf(
		.CLK(CLK),
		.RESET(RESET),
		.ALU_R(ALU_R),
		.PC_A(PC_A),
		.ALUA_PP(ALUA_PP),
		.DIN(DIN),
		.REGA_EN(REGA_EN),
		.REGA_WEN(REGA_WEN),
		.ARGA_X(ARGA_X),
		.REGA_ADDRX(REGA_ADDRX),
		.REGA_DINX(REGA_DINX),
		.REGB_EN(REGB_EN),
		.REGB_WEN(REGB_WEN),
		.ARGB_X(ARGB_X),
		.REGB_ADDRX(REGB_ADDRX),
		.REGA_DOUT(REGA_DOUT),
		.REGB_DOUT(REGB_DOUT)
	);
	
	PUR PUR_INST(.PUR(1'b1));
	GSR GSR_INST(.GSR(1'b1));
	parameter CLOCK_HALF_CYCLE = 50;
	parameter INSTRUCTION_CYCLE = 400;


	initial begin
		ALU_R   = 16'h1234;
		PC_A    = 16'h2345;
		ALUA_PP = 16'h3456;
		DIN     = 16'h5678;
		ARGA_X  = 4'b0000;
		ARGB_X = 4'b1000;
		REGA_ADDRX = 3'b000;
		REGB_ADDRX = 2'b00;
		REGA_DINX = `REGA_DINX_ALU_R;
		REGA_EN = 0;
		REGB_EN = 0;
		REGA_WEN = 0;
		REGB_WEN = 0;
		CLK = 0;
		RESET = 0;
		
		FETCH = 1;
		DECODE = 0;
		EXECUTE = 0;
		COMMIT = 0;
	end
	
	always begin
		#CLOCK_HALF_CYCLE;
		CLK = 1;
		COMMIT = 0;
		FETCH = 1;
		#CLOCK_HALF_CYCLE;
		CLK = 0;

		#CLOCK_HALF_CYCLE;
		CLK = 1;

		FETCH = 0;
		DECODE = 1;
		#CLOCK_HALF_CYCLE;
		CLK = 0;

		#CLOCK_HALF_CYCLE;
		CLK = 1;

		DECODE = 0;
		EXECUTE = 1;
		#CLOCK_HALF_CYCLE;
		CLK = 0;

		#CLOCK_HALF_CYCLE;
		CLK = 1;

		EXECUTE = 0;
		COMMIT = 1;
		#CLOCK_HALF_CYCLE;
		CLK = 0;
	end
	
	// Now the actual test vectors
	initial begin
		#(10) // Clock to signal delay
		#(INSTRUCTION_CYCLE)
		// load addra

		REGA_EN = 1;
		REGA_WEN = 1;
		#(INSTRUCTION_CYCLE)
		REGA_EN = 0;
		REGA_WEN = 0;
		REGB_EN = 1;
		REGB_WEN = 1;
		#(INSTRUCTION_CYCLE)
		REGA_EN = 0;
		REGB_EN = 0;
		REGA_WEN = 0;
		REGB_WEN = 0;
	end
	
endmodule