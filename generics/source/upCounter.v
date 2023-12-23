`include "C:/Users/Duncan/git/ForthCPU/constants.v"
/***********************************************
* Up-counter with ripple carry input and output
************************************************/
module upCounter #(parameter BUS_WIDTH = 8)(
	
	input CLK,
	input RESET,
	
	input [BUS_WIDTH-1:0] DIN,
	output reg [BUS_WIDTH-1:0] DOUT,
	
	input LD,
	input EN,
	input CP,
	input RI,
	output reg RO
);

reg RO_R;

always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
		DOUT <= 0;
		RO   <= 1'b0;
	end else begin
		
		RO <= RO_R;
		
		if(LD & EN) begin
			DOUT <= DIN;
		end else if(CP & RI) begin
			DOUT <= DOUT + 1;
		end
	end
end

always @(*) begin
	if(DOUT == {BUS_WIDTH{1'b1}}) begin
		RO_R = RI; 
	end else begin
		RO_R = 0;
	end
end




endmodule