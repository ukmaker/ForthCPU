`include "C:/Users/Duncan/git/ForthCPU/constants.v"
/***********************************************
* Up-counter with ripple carry input and output
************************************************/
module upCounter(
	
	input CLK,
	input RESET,
	
	input [7:0] DIN,
	output reg [7:0] DOUT,
	
	input LD,
	input EN,
	input CP,
	input RI,
	output reg RO
);

always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
		DOUT <= 8'h00;
		RO   <= 1'b0;
	end else begin
		
		if(LD & EN) begin
			DOUT <= DIN;
		end else if(CP & RI) begin
			DOUT <= DOUT + 1;
		end
	end
end

always @(*) begin
	if(DOUT == 8'hff) begin
		RO = RI; 
	end else begin
		RO = 0;
	end
end




endmodule