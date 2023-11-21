`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module register(
	
	input CLK,
	input RESET,
	input LD,
	input EN,
	
	input [7:0] DIN,
	output reg [7:0] DOUT
);


always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
		DOUT <= 8'h00;
	end else begin
		if(EN & LD) begin
			DOUT <= DIN;
		end
	end
end

endmodule
	