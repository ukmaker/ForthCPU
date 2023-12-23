`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/**************************************************
* Two single 8-bit registers with a 16-bit output
***************************************************/
module wordRegister (
	
	input CLK,
	input RESET,
	
	input EN0,
	input EN1,
	input LD,
	
	input [7:0] DIN,
	
	output reg [15:0] DOUT
	
);

always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
		DOUT <= 0;
	end else begin
		if(EN0 & LD) begin
			DOUT[7:0] <= DIN;
		end
		if(EN1 & LD) begin
			DOUT[15:8] <= DIN;
		end
	end
end

endmodule