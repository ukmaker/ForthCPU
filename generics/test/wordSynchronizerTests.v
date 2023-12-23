`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"


module wordSynchronizerTests;
	
	reg         SLOWCLK;
	reg         RESET;
	reg         CLR;
	reg         FASTCLK;
	reg         EN0;
	reg         EN1;
	reg         LD;
	reg  [7:0] D;
	wire [15:0] Q;
	
wordSynchronizer testArticle(

	.SLOWCLK(SLOWCLK),
	.FASTCLK(FASTCLK),
	.RESET(RESET),
	.CLR(CLR),
	.EN0(EN0),
	.EN1(EN1),
	.LD(LD),
	.D(D),
	.Q(Q)
);

always begin
	// Fast clock
	#50 FASTCLK = ~FASTCLK;
end

initial begin
	
	FASTCLK = 0;
	SLOWCLK = 0;
	RESET = 0;
	CLR = 0;
	EN0 = 0;
	EN1 = 0;
	LD = 0;
	D = 8'ha5;
	`TICKTOCK;
	RESET = 1;
	`TICKTOCK;
	RESET = 0;
	`TICKTOCK;
	`assert("Q", 16'h0000, Q)
	`TICKTOCK;
	EN0 = 1;
	SLOWCLK = 1;
	`TICKTOCK;
	SLOWCLK = 0;
	`TICKTOCK;
	`TICKTOCK;
	`assert("Q", 16'h0000, Q)
	LD = 1;
	SLOWCLK = 1;
	`TICKTOCK;
	SLOWCLK = 0;
	`TICKTOCK;
	`TICKTOCK;
	`assert("Q", 16'h0000, Q)
	D = 8'h5a;
	EN0 = 0;
	EN1 = 1;
	SLOWCLK = 1;
	`TICKTOCK;
	SLOWCLK = 0;
	`TICKTOCK;
	`TICKTOCK;
	`assert("Q", 16'h5aa5, Q)
	LD = 0; EN1 = 0;
	SLOWCLK = 1;
	`TICKTOCK;
	SLOWCLK = 0;
	`TICKTOCK;
	`TICKTOCK;
	`assert("Q", 16'h5aa5, Q)


end

endmodule