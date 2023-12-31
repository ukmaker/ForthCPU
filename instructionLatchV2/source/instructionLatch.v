`include "../../constants.v"

/*****************************************
* Latch the instruction comprising
* the 16 bits from DIN and the
* DEBUG_DEBUG bit from the DebugPort
* Data is clocked in during the falling
* edge of CLK in DECODE (i.e. while EXECUTE
* is high)
*****************************************/
module instructionLatch(
	
	input CLK,
	input RESET,
	input EXECUTE,
	
	input [15:0] DIN,
	input DEBUG_MODE_DEBUG,
	
	output reg [13:0] INSTRUCTION,
	output reg [2:0]  GROUPX
	
);


always @(negedge CLK or posedge RESET) begin
	if(RESET) begin
		INSTRUCTION       <= 0;
		GROUPX            <= 0;
	end else if(EXECUTE) begin
		INSTRUCTION       <= DIN[13:0];
		GROUPX            <= {DEBUG_MODE_DEBUG,DIN[15:14]};
	end
end

endmodule