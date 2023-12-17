`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module instructionLatch(
	
	input CLK,
	input RESET,
	input EXECUTE,
	
	input [15:0] DIN,
	
	input          DEBUG_ADDR_INC,
	input [2:0]   DEBUG_OP,
	input          DEBUG_MODE,
	
	output reg [13:0] INSTRUCTION,
	output reg [1:0]  GROUPX,
	
	output reg         DEBUG_ADDR_INC_I,
	output reg [2:0]  DEBUG_OP_I,
	output reg         DEBUG_MODE_I
	
);


always @(negedge CLK or posedge RESET) begin
	if(RESET) begin
		INSTRUCTION       <= 0;
		GROUPX            <= 0;
		DEBUG_ADDR_INC_I  <= 0;
		DEBUG_OP_I        <= 0;
		DEBUG_MODE_I      <= 0;
	end else if(EXECUTE) begin
		INSTRUCTION       <= DIN[13:0];
		GROUPX            <= DIN[15:14];
		DEBUG_ADDR_INC_I  <= DEBUG_ADDR_INC;
		DEBUG_OP_I        <= DEBUG_OP;
		DEBUG_MODE_I      <= DEBUG_MODE;
	end
end

endmodule