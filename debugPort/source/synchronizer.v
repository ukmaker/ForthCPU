`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module synchronizer #(parameter BUS_WIDTH = 8)(
	
	input RESET,
	
	input SLOWCLK,
	input EN,
	input LD,
	input FASTCLK,
	input CLR,

	input [BUS_WIDTH-1:0] D,
	output reg [BUS_WIDTH-1:0] Q

);

reg [BUS_WIDTH-1:0] Q_R;
reg [BUS_WIDTH-1:0] Q_PHI0;


/****************
* Write latch
*****************/
always @(posedge SLOWCLK or posedge RESET or posedge CLR) begin
	if(CLR | RESET) begin
		Q_R <= 0;
	end else if(LD & EN) begin
		Q_R <= D;
	end
end

/****************
* Resynchronizer
*****************/
always @(posedge FASTCLK or posedge RESET or posedge CLR) begin
	if(CLR | RESET) begin
		Q_PHI0 <= 0;
		Q      <= 0;
	end else begin
		Q_PHI0 <= Q_R;
		Q      <= Q_PHI0;
	end
end

endmodule