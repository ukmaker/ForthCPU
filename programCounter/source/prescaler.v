`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module prescaler(
	input clk_in,
	output reg clk_out
);

reg[7:0] next;

initial next = 0;

always @(posedge clk_in) begin
	next <= next+1;
	clk_out <= next[7];
end

endmodule