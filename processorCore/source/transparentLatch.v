`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module transparentLatch(
	
	input LD,
	
	input [15:0] DIN,
	
	output reg [15:0] DOUT
	
);

always @(*) begin

	if(LD) begin
		DOUT <= DIN;
	end
end

endmodule