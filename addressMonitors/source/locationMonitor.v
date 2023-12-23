`include "../../constants.v"
/*************************************
* Monitor a single address and output
* async AT_ADDR when matched
**************************************/
module locationMonitor(
	
	input CLK,
	input RESET,
	input ENABLE,
	input LD,
	input [15:0] DATA,
	input [15:0] ADDR,
	output AT_ADDR
);

reg [15:0] MON_R;
reg         EN_R;

/**
* The monitor
**/
assign AT_ADDR = (ADDR === MON_R) && EN_R;

/**
* Setup
**/
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		MON_R <= 16'h0000;
		EN_R  <= 0;
	end else if(LD) begin
		MON_R <= DATA;
		EN_R  <= ENABLE;
	end
end
endmodule
