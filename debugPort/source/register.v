`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module register #(parameter BUS_WIDTH = 8)(
	
	input CLK,
	input RESET,
	input LD,
	input EN,
	
	input [BUS_WIDTH-1:0] DIN,
	output reg [BUS_WIDTH-1:0] DOUT
);

always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
		DOUT <= 0;
	end else begin
		if(EN & LD) begin
			DOUT <= DIN;
		end
	end
end

endmodule
	