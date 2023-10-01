`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

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



// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	#10
	CLK = 0; 
	`TICK;
	RESET = 1;
	`TICK;
	`TICK;
	 
	ALU_R   = 16'h1234;
	PC_A    = 16'h2345;
	ALUA_PP = 16'h3456;
	DIN     = 16'h5678;
	ARGA_X  = 4'b0000;
	ARGB_X = 4'b0100;
	REGA_ADDRX = `REGA_ADDRX_ARGA;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	REGA_DINX = `REGA_DINX_ALU_R;
	REGA_EN = 0;
	REGB_EN = 0;
	REGA_WEN = 0;
	REGB_WEN = 0;
	CLK = 0;
	`TICKTOCK;
	RESET = 0;
	`TICKTOCK;
	`TICKTOCK;
	/**********************************************************
	* Write to port a using addra_x, each port A data source
	***********************************************************/
	REGA_EN = 1;
	REGA_WEN = 1;
	REGA_DINX = `REGA_DINX_ALU_R;
	REGA_ADDRX = `REGA_ADDRX_ARGA;
	ARGA_X  = 4'b0000;
	`TICKTOCK;
	`assert("QA", 16'h1234, REGA_DOUT)
	`assert("QB", 16'h0000, REGB_DOUT)
	
	REGA_DINX = `REGA_DINX_PC_A;
	ARGA_X  = 4'b0010;
	`TICKTOCK;
	`assert("QA", 16'h2345, REGA_DOUT)
	`assert("QB", 16'h0000, REGB_DOUT)
	
	REGA_DINX = `REGA_DINX_ALUA_PP;
	ARGA_X  = 4'b0100;
	`TICKTOCK;
	`assert("QA", 16'h3456, REGA_DOUT)
	
	/**********************************************************
	* Read the values back
	***********************************************************/
	REGA_EN = 1;
	REGA_WEN = 0;
	REGB_EN = 1;
	REGA_DINX = `REGA_DINX_ALU_R;
	REGA_ADDRX = `REGA_ADDRX_ARGA;
	ARGA_X  = 4'b0000;
	`TICKTOCK;
	`assert("QA", 16'h1234, REGA_DOUT)
	`assert("QB", 16'h3456, REGB_DOUT)
	
	ARGA_X  = 4'b0010;
	`TICKTOCK;
	`assert("QA", 16'h2345, REGA_DOUT)
	
	REGB_EN = 0;
	ARGA_X  = 4'b0100;
	`TICKTOCK;
	`assert("QA", 16'h3456, REGA_DOUT)
	
	/**********************************************************
	* Write to port a using the hardwired portA addresses
	***********************************************************/
	REGA_EN = 1;
	REGA_WEN = 1;
	REGA_DINX = `REGA_DINX_ALUA_PP;
	REGA_ADDRX = `REGA_ADDRX_RL;
	ALUA_PP = 16'h1111;
	ARGA_X  = 4'b0000;
	`TICKTOCK;
	`assert("QA", 16'h1111, REGA_DOUT)
	
	REGA_ADDRX = `REGA_ADDRX_RB;
	ALUA_PP = 16'h2222;
	`TICKTOCK;
	`assert("QA", 16'h2222, REGA_DOUT)
	
	REGA_ADDRX = `REGA_ADDRX_RA;
	ALUA_PP = 16'h3333;
	`TICKTOCK;
	`assert("QA", 16'h3333, REGA_DOUT)
	
	REGA_ADDRX = `REGA_ADDRX_RSP;
	ALUA_PP = 16'h4444;
	`TICKTOCK;
	`assert("QA", 16'h4444, REGA_DOUT)
	
	REGA_ADDRX = `REGA_ADDRX_RFP;
	ALUA_PP = 16'h5555;
	`TICKTOCK;
	`assert("QA", 16'h5555, REGA_DOUT)
	
	REGA_ADDRX = `REGA_ADDRX_RRS;
	ALUA_PP = 16'h6666;
	`TICKTOCK;
	`assert("QA", 16'h6666, REGA_DOUT)
	
	/**********************************************************
	* Read back through port B
	***********************************************************/
	REGA_EN = 0;
	REGA_WEN = 0;
	REGB_EN = 1;
	REGA_DINX = `REGA_DINX_ALU_R;
	REGA_ADDRX = `REGA_ADDRX_ARGA;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	ARGB_X  = `RLN;
	`TICKTOCK;
	`assert("QA", 16'h6666, REGA_DOUT)
	`assert("QB", 16'h1111, REGB_DOUT)
	
	ARGB_X  = `RB;
	`TICKTOCK;
	`assert("QB", 16'h2222, REGB_DOUT)
	
	ARGB_X  = `RA;
	`TICKTOCK;
	`assert("QB", 16'h3333, REGB_DOUT)
	
	ARGB_X  = `RSP;
	`TICKTOCK;
	`assert("QB", 16'h4444, REGB_DOUT)
	
	ARGB_X  = `RFP;
	`TICKTOCK;
	`assert("QB", 16'h5555, REGB_DOUT)
	
	ARGB_X  = `RRS;
	`TICKTOCK;
	`assert("QB", 16'h6666, REGB_DOUT)

	/**********************************************************
	* Read back through port B using constant address
	***********************************************************/
	REGB_ADDRX = `REGB_ADDRX_RB;
	ARGB_X  = `RLN;
	`TICKTOCK;
	`assert("QB", 16'h2222, REGB_DOUT)
	
	/**********************************************************
	* Read back through port B using ARGA_X
	***********************************************************/
	REGB_ADDRX = `REGB_ADDRX_ARGA;
	ARGA_X  = `RRS;
	`TICKTOCK;
	`assert("QB", 16'h6666, REGB_DOUT)
end
	
endmodule