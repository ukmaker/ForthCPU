`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/***************************************************
* Write a word on the CPU side
* Read a selected byte on the debugger side
****************************************************/

module wordToByteRegister (
	
	input CLK,
	input RESET,
	input LD,
	
	input SEL,

	input [15:0] D,
	output reg [7:0] Q

);

reg [15:0] Q_R;

always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
		Q_R <= 0;
	end else begin
		if(LD) begin
			Q_R <= D;
		end
	end
end

always @(*) begin
	if(SEL) begin
		Q = Q_R[15:8];
	end else begin
		Q = Q_R[7:0];
	end
end

endmodule