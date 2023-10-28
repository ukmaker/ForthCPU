`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module memoryTests;
	
reg CLK;
reg RESET;

reg RDN;
reg WR0N;
reg WR1N;

reg [15:0] ADDR;
wire [15:0] DOUT;
reg  [15:0] DIN;

PUR PUR_INST(.PUR(1'b1));
GSR GSR_INST(.GSR(1'b1));


memory testInstance(
	.CLK(CLK),
	.RESET(RESET),
	.ADDR(ADDR),
	.DIN(DIN),
	.DOUT(DOUT),
	.RDN(RDN),
	.WR0N(WR0N),
	.WR1N(WR1N)
);


// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 0; 
	`TICK;
	RESET = 1;
	DIN = 16'habcd;
	`TICKTOCK;
	#5 RESET = 0;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	
	// Instruction fetch
	RDN = 0;
	ADDR = 16'h0000;
	`TICKTOCK;
	`assert("1 DOUT", 16'h1000, DOUT)
	RDN = 1;
	`TICKTOCK;
	// write to ROM
	WR0N = 0;
	WR1N = 0;
	`TICKTOCK;
	WR0N = 1;
	WR1N = 1;
	`TICKTOCK;
	// Should be unchanged
	RDN = 0;
	ADDR = 16'h0000;
	`TICKTOCK;
	`assert("2 DOUT", 16'h1000, DOUT)
	
	RDN = 1;
	`TICKTOCK;
	// write to RAM
	ADDR = 16'h2000;
	WR0N = 0;
	WR1N = 0;
	`TICKTOCK;
	WR0N = 1;
	WR1N = 1;
	`TICKTOCK;
	// Should be written
	RDN = 0;
	`TICKTOCK;
	`assert("3 DOUT", 16'habcd, DOUT)
	RDN = 1;
	`TICKTOCK;
	// write to RAM
	ADDR = 16'h2000;
	DIN = 16'hdcba;
	WR0N = 0;
	WR1N = 0;
	`TICKTOCK;
	WR0N = 1;
	WR1N = 1;
	`TICKTOCK;
	// Should be written
	RDN = 0;
	`TICKTOCK;
	`assert("4 DOUT", 16'hdcba, DOUT)

	RDN = 1;
	`TICKTOCK;
	// write to RAM
	DIN = 16'hdcba;
	ADDR = 16'h3000;
	WR0N = 0;
	WR1N = 0;
	`TICKTOCK;
	WR0N = 1;
	WR1N = 1;
	`TICKTOCK;

	
	// write a byte
	RDN = 1;
	`TICKTOCK;
	// write to RAM
	ADDR = 16'h3000;
	DIN = 16'hffee;
	WR0N = 0;
	WR1N = 1;
	`TICKTOCK;
	WR0N = 1;
	WR1N = 1;
	`TICKTOCK;
	// Should be written
	RDN = 0;
	`TICKTOCK;
	`assert("5 DOUT", 16'hdcee, DOUT)
	RDN = 1;
	`TICKTOCK;
	// write to RAM
	ADDR = 16'h3000;
	DIN = 16'hdcba;
	WR0N = 0;
	WR1N = 0;
	`TICKTOCK;
	WR0N = 1;
	WR1N = 1;
	`TICKTOCK;
	// Should be written
	RDN = 0;
	`TICKTOCK;
	`assert("6 DOUT", 16'hdcba, DOUT)

	
	
	// write a byte
	RDN = 1;
	`TICKTOCK;
	// write to RAM
	ADDR = 16'h3000;
	DIN = 16'heeff;
	WR0N = 1;
	WR1N = 0;
	`TICKTOCK;
	WR0N = 1;
	WR1N = 1;
	`TICKTOCK;
	// Should be written
	RDN = 0;
	`TICKTOCK;
	`assert("7 DOUT", 16'heeba, DOUT)
	RDN = 1;
	`TICKTOCK;
	// write to RAM
	ADDR = 16'h3000;
	DIN = 16'hdcba;
	WR0N = 0;
	WR1N = 0;
	`TICKTOCK;
	WR0N = 1;
	WR1N = 1;
	`TICKTOCK;
	// Should be written
	RDN = 0;
	`TICKTOCK;
	`assert("8 DOUT", 16'hdcba, DOUT)

end

endmodule