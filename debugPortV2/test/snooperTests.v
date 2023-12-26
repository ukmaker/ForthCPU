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
	
	reg [15:0] DIN;
	reg [15:0] ADDR;
	reg RD;
	reg WR;
	
	wire [15:0] SNOOP_INST_ADDR;
	wire [15:0] SNOOP_INST_DATA;
	wire [15:0] SNOOP_ARG_ADDR;
	wire [15:0] SNOOP_ARG_DATA;
	wire         SNOOP_ARG_VALID;
	
snooper testInst(	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.DIN(DIN),
	.ADDR(ADDR),
	.RD(RD),
	.WR(WR),
	.SNOOP_INST_ADDR(SNOOP_INST_ADDR),
	.SNOOP_INST_DATA(SNOOP_INST_DATA),
	.SNOOP_ARG_ADDR(SNOOP_ARG_ADDR),
	.SNOOP_ARG_DATA(SNOOP_ARG_DATA),
	.SNOOP_ARG_VALID(SNOOP_ARG_VALID)
);


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
	RD = 0;
	WR = 0;
	`TICKTOCK;
	RESET = 0;
	`TICKTOCK;
	`internalCycle(16'h0000, 16'h0000)
	`internalCycle(16'h0002, 16'h1111)
	`externalCycle(16'h0004, 16'h2222, 16'h0006, 16'h3333)
	
	`internalCycle(16'h0008, 16'h4444)
	`externalCycle(16'h000a, 16'h5555, 16'h7777, 16'h6666)
	
	`internalCycle(16'h000c, 16'h8888)
	
end
endmodule