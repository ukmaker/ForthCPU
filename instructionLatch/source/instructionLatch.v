`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module instructionLatch(
	
	input CLK,
	input RESET,
	input EXECUTE,
	
	input [15:0] DIN,
	
	input [3:0]   DEBUG_OP,
	input [2:0]   DEBUG_ARG,
	input          DEBUG_MODE,
	
	output reg [13:0] INSTRUCTION,
	output reg [1:0]  GROUPX,
	
	output reg [6:0]  DEBUG_INSTRUCTION,
	output reg         DEBUG_MODEX
	
);


always @(negedge CLK or posedge RESET) begin
	if(RESET) begin
		INSTRUCTION       <= 0;
		GROUPX            <= 0;
		DEBUG_INSTRUCTION <= 0;
		DEBUG_MODEX       <= 0;
	end else if(EXECUTE) begin
		INSTRUCTION       <= DIN[13:0];
		GROUPX            <= DIN[15:14];
		DEBUG_INSTRUCTION <= {DEBUG_ARG, DEBUG_OP};
		DEBUG_MODEX       <= DEBUG_MODE;
	end
end

endmodule