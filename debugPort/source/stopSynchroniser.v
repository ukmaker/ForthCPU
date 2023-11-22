`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module stopSynchroniser(
	
	input CLK,
	input RESET,
	input WR,
	input D0,
	
	input EN_STOP,
	
	output reg STOPX
);

reg STOP_REQ_R;
reg REQ_PHI0;


/****************
* Write latch
*****************/
always @(posedge WR or posedge RESET) begin
	if(RESET) begin
		STOP_REQ_R <= 0;
	end else begin
		STOP_REQ_R <= D0;
	end
end

/****************
* Resynchronizer
*****************/
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		REQ_PHI0 <= 0;
		STOPX <= 0;
	end else if(STOP_REQ_R) begin
		REQ_PHI0 <= 1;
		STOPX <= REQ_PHI0;
	end
end

endmodule