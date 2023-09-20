`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module aluBMuxTests;


reg [15:0] REGB_DOUT;
reg [3:0] ARGA_X;
reg [3:0] ARGB_X;

reg [2:0] ALUB_SRCX;

reg CLK;

wire [15:0] ARGB;

aluBMux testInstance(
	.REGB_DOUT(REGB_DOUT),
	.ARGA_X(ARGA_X),
	.ARGB_X(ARGB_X),
	.ALUB_SRCX(ALUB_SRCX),
	.ARGB(ARGB)
);

// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 0;
	REGB_DOUT = 16'h1234;
	ARGA_X = 4'b1010;
	ARGB_X = 4'b0101;
	ALUB_SRCX = 3'b000;
	
	`TICKTOCK;
	`assert("REGB_DOUT", REGB_DOUT, ARGB)
	
	`TICKTOCK;
	ALUB_SRCX = 3'b001;

	`TICKTOCK;
	`assert("U4", 16'b0000000000000101, ARGB)
	
	`TICKTOCK;
	ALUB_SRCX = 3'b010;

	`TICKTOCK;
	`assert("U8", 16'b0000000010100101, ARGB)
	
	`TICKTOCK;
	ALUB_SRCX = 3'b011;

	`TICKTOCK;
	`assert("U8H", 16'b1010010100110100, ARGB)
	
	`TICKTOCK;
	ALUB_SRCX = 3'b100;

	`TICKTOCK;
	`assert("U4.0", 16'b0000000000001010, ARGB)
	
	`TICKTOCK;
	ALUB_SRCX = 3'b101;
	
	`TICKTOCK;
	`assert("ZERO", 16'b0000000000000000, ARGB)
	
	`TICKTOCK;

end

endmodule