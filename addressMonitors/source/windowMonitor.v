`include "../../constants.v"
/*************************************
* Monitor a range of address and output
* async IN_WINDOW when matched >= | <=
**************************************/
module windowMonitor(
	
	input CLK,
	input RESET,
	input ENABLE,
	input LD_START,
	input LD_END,
	input [15:0] DATA,
	input [15:0] ADDR,
	output IN_WINDOW
);

reg [15:0] MON_START_R;
reg [15:0] MON_END_R;
reg         EN_R;

/**
* The monitor
**/
assign IN_WINDOW = (ADDR >= MON_START_R) && (ADDR <= MON_END_R) && EN_R;

/**
* Setup
**/
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		MON_START_R <= 16'h0000;
		MON_END_R   <= 16'h0000;
		EN_R        <= 0;
	end else if(LD_START) begin
		MON_START_R <= DATA;
		EN_R        <= ENABLE;
	end else if(LD_END) begin
		MON_END_R   <= DATA;
		EN_R        <= ENABLE;
	end
end
endmodule
