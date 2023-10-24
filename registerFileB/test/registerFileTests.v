`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module registerFileTests;
	
	reg CLK;
	reg RESET;

	/**
	* inputs
	**/
	reg [15:0] ALU_R;
	reg [15:0] DIN;
	reg [15:0] PC_A_NEXT;
	
	/**
	* Port A controls
	**/
	reg REGA_EN;
	reg REGA_WEN;
	reg [3:0] ARGA_X;
	reg [1:0] REGA_ADDRX;
	reg [1:0] REGA_BYTE_EN;
	reg [1:0] REGA_DINX;
	reg REGA_BYTEX;
	
	/**
	* Port B controls
	**/
	reg REGB_EN;
	reg REGB_WEN;
	reg [3:0] ARGB_X;
	reg [2:0] REGB_ADDRX;
	reg [1:0] REGB_BYTE_EN;
	
	wire [15:0] REGA_DOUT;
	wire [15:0] REGB_DOUT;
	
	registerFile rf(
		.CLK(CLK),
		.RESET(RESET),
		.ALU_R(ALU_R),
		.PC_A_NEXT(PC_A_NEXT),
		.DIN(DIN),
		.REGA_EN(REGA_EN),
		.REGA_WEN(REGA_WEN),
		.ARGA_X(ARGA_X),
		.REGA_ADDRX(REGA_ADDRX),
		.REGA_BYTE_EN(REGA_BYTE_EN),
		.REGB_EN(REGB_EN),
		.REGB_WEN(REGB_WEN),
		.ARGB_X(ARGB_X),
		
		.REGA_DINX(REGA_DINX),
		.REGA_BYTEX(REGA_BYTEX),
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
	`TICKTOCK;
	 
	ALU_R        = 16'h1234;
	PC_A_NEXT    = 16'h2345;
	DIN          = 16'h5678;
	ARGA_X       = 4'b0000;
	ARGB_X       = 4'b0100;
	REGA_ADDRX   = `REGA_ADDRX_ARGA;
	REGB_ADDRX   = `REGB_ADDRX_ARGB;
	REGA_DINX    = `REGA_DINX_DIN;
	REGA_BYTEX   = 0;
	REGA_EN      = 0;
	REGB_EN      = 0;
	REGA_WEN     = 0;
	REGB_WEN     = 0;
	REGA_BYTE_EN = 2'b11;
	REGB_BYTE_EN = 2'b11;
	`TICKTOCK;
	RESET = 0;
	`TICKTOCK;
	`TICKTOCK;
	/**********************************************************
	* Write to port A using addra_x, each port A data source
	***********************************************************/
	REGA_EN = 1;
	REGA_WEN = 1;
	REGA_DINX  = `REGA_DINX_DIN;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	ARGA_X  = 4'b0000;
	`TICKTOCK;
	`mark(1)
	`assert("QA", 16'h5678, REGA_DOUT)
	`assert("QB", 16'h0000, REGB_DOUT)
	
	REGA_DINX  = `REGA_DINX_BYTE;
	REGA_BYTEX = `REGA_BYTEX_LOW;
	ARGA_X     = `R1;
	`TICKTOCK;
	`mark(2)
	`assert("QA", 16'h0078, REGA_DOUT)
	
	REGA_DINX  = `REGA_DINX_BYTE;
	REGA_BYTEX = `REGA_BYTEX_HIGH;
	ARGA_X     = `RA;
	`TICKTOCK;
	`mark(2)
	`assert("QA", 16'h0056, REGA_DOUT)
	
	REGA_DINX = `REGA_DINX_PC_A_NEXT;
	ARGA_X  = `RB;
	`TICKTOCK;
	`mark(3)
	`assert("QA", 16'h2345, REGA_DOUT)
	`assert("QB", 16'h0000, REGB_DOUT)

	
	REGA_DINX = `REGA_DINX_ALU_R;
	ARGA_X  = `RL;
	`TICKTOCK;
	`mark(4)
	`assert("QA", 16'h1234, REGA_DOUT)
	`assert("QB", 16'h0000, REGB_DOUT)

	
	/**********************************************************
	* Read the values back
	***********************************************************/
	REGA_EN = 1;
	REGA_WEN = 0;
	REGA_DINX = `REGA_DINX_DIN;
	
	REGA_ADDRX = `REGA_ADDRX_ARGA;
	ARGA_X = 4'b0000;
	`TICKTOCK;
	`mark(5)
	`assert("QA", 16'h5678, REGA_DOUT)
	`assert("QB", 16'h0000, REGB_DOUT)
	
	ARGA_X = `R1;
	`TICKTOCK;
	`mark(6)
	`assert("QA", 16'h0078, REGA_DOUT)
	`assert("QB", 16'h0000, REGB_DOUT)
	
	REGA_ADDRX = `REGA_ADDRX_RA;
	`TICKTOCK;
	`mark(6)
	`assert("QA", 16'h0056, REGA_DOUT)
	`assert("QB", 16'h0000, REGB_DOUT)
	
	REGA_ADDRX = `REGA_ADDRX_RB;
	`TICKTOCK;
	`mark(7)
	`assert("QA", 16'h2345, REGA_DOUT)
	
	REGA_ADDRX = `REGA_ADDRX_RL;
	`TICKTOCK;
	`mark(8)
	`assert("QA", 16'h1234, REGA_DOUT)
	`assert("QB", 16'h0000, REGB_DOUT)
	
	/**********************************************************
	* Write to port B using the hardwired portB addresses
	***********************************************************/
	REGA_EN = 0;
	REGA_WEN = 0;	
	
	REGB_EN = 1;
	REGB_WEN = 1;
	
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	ARGB_X = 4'b0100;
	ALU_R = 16'h2222;
	`TICKTOCK;
	`mark(9)
	`assert("QB", 16'h2222, REGB_DOUT)
	
	REGB_ADDRX = `REGB_ADDRX_RB;
	ALU_R = 16'h3333;
	`TICKTOCK;
	`mark(10)
	`assert("QB", 16'h3333, REGB_DOUT)
	
	REGB_ADDRX = `REGB_ADDRX_RSP;
	ALU_R = 16'h4444;
	`TICKTOCK;
	`mark(11)
	`assert("QB", 16'h4444, REGB_DOUT)
	
	REGB_ADDRX = `REGB_ADDRX_RFP;
	ALU_R = 16'h5555;
	`TICKTOCK;
	`mark(12)
	`assert("QB", 16'h5555, REGB_DOUT)
	
	REGB_ADDRX = `REGB_ADDRX_RRS;
	ALU_R = 16'h6666;
	`TICKTOCK;
	`mark(13)
	`assert("QB", 16'h6666, REGB_DOUT)
	
	/**********************************************************
	* Read back through port B
	***********************************************************/
	REGB_EN = 1;
	REGB_WEN = 0;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	
	ARGB_X  = 4'b0100;
	`TICKTOCK;
	`mark(14)
	`assert("QB", 16'h2222, REGB_DOUT)
	
	ARGB_X  = `RB;
	`TICKTOCK;
	`mark(15)
	`assert("QB", 16'h3333, REGB_DOUT)
	
	ARGB_X  = `RSP;
	`TICKTOCK;
	`mark(16)
	`assert("QB", 16'h4444, REGB_DOUT)
	
	ARGB_X  = `RFP;
	`TICKTOCK;
	`mark(17)
	`assert("QB", 16'h5555, REGB_DOUT)
	
	ARGB_X  = `RRS;
	`TICKTOCK;
	`mark(18)
	`assert("QB", 16'h6666, REGB_DOUT)

	/**********************************************************
	* Read through A and B together
	***********************************************************/
	REGB_EN = 1;
	REGB_WEN = 0;
	REGA_EN = 1;
	REGA_WEN = 0;
	REGA_DINX = `REGA_DINX_DIN;
	
	REGA_ADDRX = `REGA_ADDRX_ARGA;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	ARGA_X = 4'b0000;
	ARGB_X = 4'b0000;
	
	`TICKTOCK;
	`mark(19)
	`assert("QA", 16'h5678, REGA_DOUT)
	`assert("QB", 16'h5678, REGB_DOUT)
	
	/**********************************************************
	* Write back through B
	***********************************************************/
	REGB_EN    = 1;
	REGB_WEN   = 1;
	REGA_EN    = 0;
	REGA_WEN   = 0;
	REGA_DINX  = `REGA_DINX_DIN;
	
	REGA_ADDRX = `REGA_ADDRX_ARGA;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	ARGA_X     = 4'b0000;
	ARGB_X     = 4'b0000;
	ALU_R      = 16'h8765;	
	`TICKTOCK;
	`mark(20)
	`assert("QA", 16'h5678, REGA_DOUT)
	`assert("QB", 16'h8765, REGB_DOUT)	
	
	/**********************************************************
	* Read through A and B together
	***********************************************************/
	REGB_EN = 1;
	REGB_WEN = 0;
	REGA_EN = 1;
	REGA_WEN = 0;
	REGA_DINX = `REGA_DINX_DIN;
	
	REGA_ADDRX = `REGA_ADDRX_ARGA;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	ARGA_X = 4'b0000;
	ARGB_X = 4'b0000;
	
	`TICKTOCK;
	`mark(21)
	`assert("QA", 16'h8765, REGA_DOUT)
	`assert("QB", 16'h8765, REGB_DOUT)

end
	
endmodule