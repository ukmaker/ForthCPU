`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module watcherTests;
	
	reg CLK; 
	reg RESET; 
	reg FETCH; 
	reg DECODE; 
	reg EXECUTE; 
	reg COMMIT;
	reg RD;
	
	reg [15:0] ADDR;
	reg         DEBUG_BKP_ENX;
	reg         DEBUG_WATCH_ENX;
	reg [15:0] DEBUG_BKP_ADDR;
	reg [15:0] DEBUG_WATCH_START_ADDR;
	reg [15:0] DEBUG_WATCH_END_ADDR;
	
	wire DEBUG_AT_BKP;
	wire DEBUG_IN_WATCH;
	
watcher testInst(	
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.RD(RD),
	.ADDR(ADDR),
	.DEBUG_BKP_ENX(DEBUG_BKP_ENX),
	.DEBUG_WATCH_ENX(DEBUG_WATCH_ENX),
	.DEBUG_BKP_ADDR(DEBUG_BKP_ADDR),
	.DEBUG_WATCH_START_ADDR(DEBUG_WATCH_START_ADDR),
	.DEBUG_WATCH_END_ADDR(DEBUG_WATCH_END_ADDR),
	.DEBUG_AT_BKP(DEBUG_AT_BKP),
	.DEBUG_IN_WATCH(DEBUG_IN_WATCH)
);

reg [15:0] DIN; // for reference only
	

always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 1;
	RD = 0;
	#20;
	RESET = 1;
	FETCH = 0;
	DECODE = 0;
	EXECUTE = 0;
	COMMIT = 0;
	DIN = 16'h0000;
	ADDR = 16'h0000;
	DEBUG_BKP_ENX = 1'b0;
	DEBUG_WATCH_ENX = 1'b0;
	DEBUG_BKP_ADDR = 16'h0004;
	DEBUG_WATCH_START_ADDR = 16'h7777;
	DEBUG_WATCH_END_ADDR = 16'h7778;
	`TICKTOCK;
	RESET = 0;
	`TICKTOCK;
	`internalCycle(16'h0000, 16'h0000)
	DEBUG_BKP_ENX = 1'b1;
	DEBUG_WATCH_ENX = 1'b1;
	`internalCycle(16'h0002, 16'h1111)
	`externalCycle(16'h0004, 16'h2222, 16'h0006, 16'h3333)
	
	`internalCycle(16'h0008, 16'h4444)
	`externalCycle(16'h000a, 16'h5555, 16'h7777, 16'h6666)
	
	`internalCycle(16'h000c, 16'h8888)
	
end
endmodule