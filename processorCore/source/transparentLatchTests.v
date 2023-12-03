`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module transparentLatchTests;
	
	reg LD;
	reg [15:0] DIN;
	wire [15:0] DOUT;
	
transparentLatch testArticle(
	.LD(LD),
	.DIN(DIN),
	.DOUT(DOUT)
);
	

initial begin

	DIN = 16'hbeef;
	LD = 0;
	
	`TICKTOCK;
	`TICK;
	DIN = 16'hfeed;
	`TICK;
	#25;
	LD = 1;
	`TICKTOCK;
	DIN = 16'hcafe;
	`TICK;
	LD = 0;
	DIN = 16'hface;
	`TICK;
	DIN = 16'hdeed;
	`TICKTOCK;
end
		
		
endmodule