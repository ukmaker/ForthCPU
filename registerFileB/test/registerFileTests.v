`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module registerFileTests;
	
	reg CLK;
	reg RESET;

	/**
	* Port A inputs
	**/
	reg [15:0] ALU_R;
	
	/**
	* Port B inputs
	**/
	reg [15:0] DIN;
	reg [15:0] PC_A;
	
	/**
	* Port A controls
	**/
	reg REGA_EN;
	reg REGA_WEN;
	reg [3:0] ARGA_X;
	reg [2:0] REGA_ADDRX;
	reg [1:0] REGA_BYTE_EN;
	
	/**
	* Port B controls
	**/
	reg REGB_EN;
	reg REGB_WEN;
	reg [3:0] ARGB_X;
	reg [1:0] REGB_ADDRX;
	reg [1:0] REGB_BYTE_EN;
	reg [1:0] REGB_DINX;
	
	wire [15:0] REGA_DOUT;
	wire [15:0] REGB_DOUT;
	
	registerFile rf(
		.CLK(CLK),
		.RESET(RESET),
		.ALU_R(ALU_R),
		.PC_A(PC_A),
		.DIN(DIN),
		.REGA_EN(REGA_EN),
		.REGA_WEN(REGA_WEN),
		.ARGA_X(ARGA_X),
		.REGA_ADDRX(REGA_ADDRX),
		.REGA_BYTE_EN(REGA_BYTE_EN),
		.REGB_EN(REGB_EN),
		.REGB_WEN(REGB_WEN),
		.ARGB_X(ARGB_X),
		
		.REGB_DINX(REGB_DINX),
		.REGB_ADDRX(REGB_ADDRX),
		.REGB_BYTE_EN(REGB_BYTE_EN),
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
	DIN     = 16'h5678;
	ARGA_X  = 4'b0000;
	ARGB_X = 4'b0100;
	REGA_ADDRX = `REGA_ADDRX_ARGA;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	REGB_DINX  = `REGB_DINX_DIN;
	REGA_EN = 0;
	REGB_EN = 0;
	REGA_WEN = 0;
	REGB_WEN = 0;
	REGA_BYTE_EN = 2'b11;
	REGB_BYTE_EN = 2'b11;
	CLK = 0;
	`TICKTOCK;
	RESET = 0;
	`TICKTOCK;
	`TICKTOCK;
	/**********************************************************
	* Write to port B using addrb_x, each port B data source
	***********************************************************/
	REGB_EN = 1;
	REGB_WEN = 1;
	REGB_DINX = `REGB_DINX_DIN;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	ARGB_X  = 4'b0000;
	`TICKTOCK;
	`assert("QA", 16'h0000, REGA_DOUT)
	`assert("QB", 16'h1234, REGB_DOUT)
	
	REGB_DINX = `REGB_DINX_PC_A;
	ARGB_X  = 4'b0010;
	`TICKTOCK;
	`assert("QA", 16'h0000, REGA_DOUT)
	`assert("QB", 16'h2345, REGB_DOUT)
	
	REGB_DINX = `REGB_DINX_DINH;
	ARGB_X  = 4'b0100;
	`TICKTOCK;
	`assert("QB", 16'h0056, REGB_DOUT)
	
	/**********************************************************
	* Read the values back
	***********************************************************/
	REGB_EN = 1;
	REGB_WEN = 0;
	REGB_DINX = `REGB_DINX_DIN;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	ARGB_X  = 4'b0000;
	`TICKTOCK;
	`assert("QA", 16'h0000, REGA_DOUT)
	`assert("QB", 16'h1234, REGB_DOUT)
	
	REGB_DINX = `REGB_DINX_PC_A;
	ARGB_X  = 4'b0010;
	`TICKTOCK;
	`assert("QA", 16'h0000, REGA_DOUT)
	`assert("QB", 16'h2345, REGB_DOUT)
	
	REGB_DINX = `REGB_DINX_DINH;
	ARGB_X  = 4'b0100;
	`TICKTOCK;
	`assert("QB", 16'h0056, REGB_DOUT)
	
	/**********************************************************
	* Write to port A using the hardwired portA addresses
	***********************************************************/
	REGB_EN = 0;
	REGB_WEN = 0;	
	
	REGA_EN = 1;
	REGA_WEN = 1;
	
	REGA_ADDRX = `REGA_ADDRX_RB;
	ALU_R = 16'h2222;
	`TICKTOCK;
	`assert("QA", 16'h2222, REGA_DOUT)
	
	REGA_ADDRX = `REGA_ADDRX_RA;
	ALU_R = 16'h3333;
	`TICKTOCK;
	`assert("QA", 16'h3333, REGA_DOUT)
	
	REGA_ADDRX = `REGA_ADDRX_RSP;
	ALU_R = 16'h4444;
	`TICKTOCK;
	`assert("QA", 16'h4444, REGA_DOUT)
	
	REGA_ADDRX = `REGA_ADDRX_RFP;
	ALU_R = 16'h5555;
	`TICKTOCK;
	`assert("QA", 16'h5555, REGA_DOUT)
	
	REGA_ADDRX = `REGA_ADDRX_RRS;
	ALU_R = 16'h6666;
	`TICKTOCK;
	`assert("QA", 16'h6666, REGA_DOUT)
	
	/**********************************************************
	* Read back through port B
	***********************************************************/
	REGA_EN = 0;
	REGA_WEN = 0;
	REGB_EN = 1;
	REGA_ADDRX = `REGA_ADDRX_ARGA;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	
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
	ARGB_X  = `RL;
	`TICKTOCK;
	`assert("QB", 16'h2222, REGB_DOUT)
	
	/**********************************************************
	* Read back through port B using ARGA_X
	***********************************************************/
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	ARGB_X  = `RRS;
	`TICKTOCK;
	`assert("QB", 16'h6666, REGB_DOUT)
end
	
endmodule