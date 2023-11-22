`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module requestGenerator(
	
	input CLK,
	input RESET,
	input WR,
	input RD,
	input ACKX,
	
	input EN_OP,
	input EN_MDH,
	
	output reg REQX
);

reg RD_REQ_R;
reg WR_REQ_R;
reg REQ_PHI0;

/****************
* Read latch
*****************/
always @(negedge RD or posedge RESET or posedge ACKX) begin
	if(RESET | ACKX) begin
		RD_REQ_R <= 0;
	end else begin
		RD_REQ_R <= EN_MDH;
	end
end


/****************
* Write latch
*****************/
always @(posedge WR or posedge RESET or posedge ACKX) begin
	if(RESET | ACKX) begin
		WR_REQ_R <= 0;
	end else begin
		WR_REQ_R <= EN_OP;
	end
end

/****************
* Resynchronizer
*****************/
always @(posedge CLK or posedge RESET or posedge ACKX) begin
	if(RESET | ACKX) begin
		REQ_PHI0 <= 0;
		REQX <= 0;
	end else if((WR_REQ_R | RD_REQ_R)) begin
		REQ_PHI0 <= 1;
		REQX <= REQ_PHI0;
	end
end

endmodule