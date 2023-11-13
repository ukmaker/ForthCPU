`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module ramTests;
	
	
	reg CLK;
	reg RESET;
	
	reg CLKEN;
	reg BEN0;
	reg BEN1;
	reg WEN;
	reg [15:0] ADDR;
	reg [15:0] DIN;
	
	wire [15:0] DOUT;
	
RAM ram(
	.Clock(CLK), 
	.ClockEn(CLKEN), 
	.Reset(RESET), 
	.ByteEn({BEN1,BEN0}), 
	.WE(WEN), 
	.Address(ADDR[12:0]), 
	.Data(DIN), 
	.Q(DOUT)
);

PUR PUR_INST (.PUR(1'b1));
GSR GSR_INST (.GSR(1'b1));
	
	// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
		#10
		CLK = 0; 
		CLKEN = 0;
		BEN0 = 0;
		BEN1 = 0;
		WEN = 0;
		`TICK;
		RESET = 1;
		DIN = 16'h0000;
		ADDR = 16'h0000;
		`TICK;
		`TICK;

		RESET = 0;  
		`TICKTOCK;
		`TICKTOCK;
		`TICKTOCK;
		// Write a word
		DIN = 16'h1234;
		CLKEN = 1;
		WEN = 1;
		BEN1 = 1;
		BEN0 = 1;
		`TICKTOCK;
		`assert("Q", 16'h1234, DOUT)
		WEN = 0;
		BEN1 = 0;
		BEN0 = 0;
		`TICKTOCK;
		`assert("Q", 16'h1234, DOUT)
		// Write high byte
		DIN = 16'haa55;
		CLKEN = 1;
		WEN = 1;
		BEN1 = 1;
		BEN0 = 0;
		`TICKTOCK;
		`assert("Q", 16'haa34, DOUT)
		WEN = 0;
		BEN1 = 0;
		BEN0 = 0;
		`TICKTOCK;
		`assert("Q", 16'haa34, DOUT)

		// Write low byte
		DIN = 16'haa55;
		CLKEN = 1;
		WEN = 1;
		BEN1 = 0;
		BEN0 = 1;
		`TICKTOCK;
		`assert("Q", 16'haa55, DOUT)
		WEN = 0;
		BEN1 = 0;
		BEN0 = 0;
		`TICKTOCK;
		`assert("Q", 16'haa55, DOUT)

end
 
 endmodule