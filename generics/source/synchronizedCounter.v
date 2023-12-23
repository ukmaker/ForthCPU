`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/***********************************************
* Cross domain loadable up counter
* With preload, increment and reset inputs
* Ripple carry in and out
************************************************/

module synchronizedCounter #(parameter BUS_WIDTH = 8)(
	
	input SLOWCLK,
	input RESET,
	input FASTCLK,
	input EN,
	input LD,
	input COUNT,
	input RI,
	output reg RO,
	input [BUS_WIDTH-1:0] D,
	output reg [BUS_WIDTH-1:0] Q

);

reg [BUS_WIDTH-1:0] Q_R;
reg [BUS_WIDTH-1:0] Q_PHI0;

reg PL;
reg PL_R;
reg PL_PHI0;
reg RO_R;

/****************
* Write latch
*****************/
always @(posedge SLOWCLK or posedge RESET) begin
	if(RESET) begin
		Q_R     <= 0;
		PL_R    <= 0;
	end else if(LD & EN) begin
		Q_R     <= D;
		PL_R    <= 1;
	end else begin
		PL_R    <= 0;
	end
end

/****************
* Resynchronizer
*****************/
always @(posedge FASTCLK or posedge RESET) begin
	if(RESET) begin
		Q_PHI0  <= 0;
		Q       <= 0;
		PL_PHI0 <= 0;
		PL      <= 0;
		RO   <= 1'b0;
	end else begin
		PL_PHI0 <= PL_R;
		PL      <= PL_PHI0;
		RO      <= RO_R;
		if(PL) begin
			Q_PHI0 <= Q_R;
			Q      <= Q_PHI0;
		end else if(COUNT & RI) begin
			Q <= Q + 1;
		end
	end
end

always @(*) begin
	if(Q == {BUS_WIDTH{1'b1}}) begin
		RO_R = RI;
	end else begin
		RO_R = 0;
	end
end

endmodule