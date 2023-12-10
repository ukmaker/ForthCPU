`timescale 1 ns / 1 ns

`include "../../constants.v"
`include "../../testSetup.v"

module instructionLatchTests;
	
	reg CLK;
	reg RESET;
	reg EXECUTE;
	
	reg [15:0] DIN;
	
	reg [3:0]   DEBUG_OP;
	reg [3:0]   DEBUG_ARG;
	reg          DEBUG_DEBUG;
	
	wire [13:0] INSTRUCTION;
	wire [1:0]  GROUP;
	
	wire [7:0]  DEBUG_INSTRUCTION;
	wire         DEBUG_GROUP;
	
instructionLatch testArticle(

	.CLK(CLK),
	.RESET(RESET),
	.EXECUTE(EXECUTE),
	.DIN(DIN),
	.DEBUG_OP(DEBUG_OP),
	.DEBUG_ARG(DEBUG_ARG),
	.DEBUG_DEBUG(DEBUG_DEBUG),
	.INSTRUCTION(INSTRUCTION),
	.GROUP(GROUP),
	.DEBUG_INSTRUCTION(DEBUG_INSTRUCTION),
	.DEBUG_GROUP(DEBUG_GROUP)
);

reg [1:0] PHI;
reg EXECUTE_R;

always begin
	#50 CLK = ~CLK;
end

always begin
	#100 PHI <= PHI + 1;
	EXECUTE_R <= PHI == 3 ? 1 : 0;
end

always begin
	EXECUTE = #10 EXECUTE_R;
end

initial begin
	CLK= 0;
	RESET = 0;
	PHI = 0;
	DIN =16'habcd;
	DEBUG_OP = 4'b1010;
	DEBUG_ARG = 4'b0101;
	DEBUG_DEBUG = 0;
	`TICKTOCK;
	RESET = 1;
	`TICKTOCK;
	RESET = 0;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`mark(1)
	`assert("EXECUTE", 1, EXECUTE)
	`TICKTOCK;
	`assert("INSTRUCTION", 14'b10101111001101, INSTRUCTION)
	`assert("GROUP",                    2'b10, GROUP)
	`assert("DEBUG_INSTRUCTION",  8'b01011010, DEBUG_INSTRUCTION)
	`assert("DEBUG_GROUP",                  0, DEBUG_GROUP)
	`TICKTOCK;
	DIN =16'h5999;
	DEBUG_OP = 4'b0101;
	DEBUG_ARG = 4'b1010;
	DEBUG_DEBUG = 1;
	`TICKTOCK;
	`TICKTOCK;
	`mark(2)
	`assert("EXECUTE", 1, EXECUTE)
	`TICKTOCK;
	`assert("INSTRUCTION", 14'b01100110011001, INSTRUCTION)
	`assert("GROUP",                    2'b01, GROUP)
	`assert("DEBUG_INSTRUCTION",  8'b10100101, DEBUG_INSTRUCTION)
	`assert("DEBUG_GROUP",                  1, DEBUG_GROUP)
	`TICKTOCK;
	


end


endmodule