`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"


module synchronizerTests;
	
	reg         SLOWCLK;
	reg         RESET;
	reg         CLR;
	reg         FASTCLK;
	reg         EN;
	reg         LD;
	reg  [7:0] D;
	wire [7:0] Q;
	
synchronizer testArticle(

	.SLOWCLK(SLOWCLK),
	.FASTCLK(FASTCLK),
	.RESET(RESET),
	.CLR(CLR),
	.EN(EN),
	.LD(LD),
	.D(D),
	.Q(Q)
);

reg [2:0] phi;

always begin
	// Fast clock
	#50 FASTCLK = ~FASTCLK;
end

always @(posedge FASTCLK) begin
	phi <= phi + 1;
	if(phi == 3'b000) begin
		SLOWCLK <= ~SLOWCLK;
	end
end

initial begin
	
	phi = 3'b000;
	
	FASTCLK = 0;
	SLOWCLK = 0;
	RESET = 0;
	CLR = 0;
	EN = 0;
	LD = 0;
	D = 8'h00;
	#100;
	RESET = 1;
	#100;
	RESET = 0;
	#500;
	D = 8'haa;
	#500;
	EN = 1;
	#3000;
	LD = 1;
	#1000;
	D = 8'hbb;
	#2000;
	EN = 0;
	#3000;
	LD = 0;
	#3000;
	CLR = 1;
	#1000;
	CLR = 0;
	#1000;

end

endmodule