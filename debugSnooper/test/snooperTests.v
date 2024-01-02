`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module snooperTests;
	
	reg CLK; 
	reg RESET; 
	reg FETCH; 
	reg DECODE; 
	reg EXECUTE; 
	reg COMMIT;
	
	reg [15:0]  DIN;
	reg [15:0]  ADDR;
	reg         DEBUG_SNOOP_LD_EN;
	reg  [1:0]  SNOOP_REGX;
	wire [15:0] SNOOP_REG;
	
snooper testInst(	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.DIN(DIN),
	.ADDR(ADDR),
	.DEBUG_SNOOP_LD_EN(DEBUG_SNOOP_LD_EN),
	.SNOOP_REGX(SNOOP_REGX),
	.SNOOP_REG(SNOOP_REG)
);

// Wires for test only
reg RD, WR;


always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 1;
	#20;
	RESET = 1;
	FETCH = 0;
	DECODE = 0;
	EXECUTE = 0;
	COMMIT = 0;
	DIN = 16'h0000;
	ADDR = 16'h0000;
	SNOOP_REGX = 2'b00;
	DEBUG_SNOOP_LD_EN = 1'b1;
	`TICKTOCK;
	RESET = 0;
	`TICKTOCK;
	`internalCycle(16'h0000, 16'h0000)
	// check each register
	SNOOP_REGX = 2'b00;
	#100;
	SNOOP_REGX = 2'b01;
	#100;
	SNOOP_REGX = 2'b10;
	#100;
	SNOOP_REGX = 2'b11;
	#100;
	
	`internalCycle(16'h0002, 16'h1111)
	// check each register
	SNOOP_REGX = 2'b00;
	#100;
	SNOOP_REGX = 2'b01;
	#100;
	SNOOP_REGX = 2'b10;
	#100;
	SNOOP_REGX = 2'b11;
	#100;
	`externalCycle(16'h0004, 16'h2222, 16'h0006, 16'h3333)
	// check each register
	SNOOP_REGX = 2'b00;
	#100;
	SNOOP_REGX = 2'b01;
	#100;
	SNOOP_REGX = 2'b10;
	#100;
	SNOOP_REGX = 2'b11;
	#100;
	
	`internalCycle(16'h0008, 16'h4444)
	// check each register
	SNOOP_REGX = 2'b00;
	#100;
	SNOOP_REGX = 2'b01;
	#100;
	SNOOP_REGX = 2'b10;
	#100;
	SNOOP_REGX = 2'b11;
	#100;
	`externalCycle(16'h000a, 16'h5555, 16'h7777, 16'h6666)
	// check each register
	SNOOP_REGX = 2'b00;
	#100;
	SNOOP_REGX = 2'b01;
	#100;
	SNOOP_REGX = 2'b10;
	#100;
	SNOOP_REGX = 2'b11;
	#100;
	
	`internalCycle(16'h000c, 16'h8888)
	// check each register
	SNOOP_REGX = 2'b00;
	#100;
	SNOOP_REGX = 2'b01;
	#100;
	SNOOP_REGX = 2'b10;
	#100;
	SNOOP_REGX = 2'b11;
	#100;
	
end
endmodule