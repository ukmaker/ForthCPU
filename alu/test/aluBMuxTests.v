`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module aluBMuxTests;


reg [15:0] REGB_DOUT;
reg [3:0] ARGA_X;
reg [3:0] ARGB_X;

reg [1:0] LDS_SRCX;
reg [2:0] ALUB_SRCX;

reg CLK;

wire [15:0] ARGB;

aluBMux testInstance(
	.REGB_DOUT(REGB_DOUT),
	.ARGA_X(ARGA_X),
	.ARGB_X(ARGB_X),
	.LDS_SRCX(LDS_SRCX),
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
	ALUB_SRCX = `ALUB_SRCX_REG_B;
	LDS_SRCX = 2'b10;
	
	`TICKTOCK;
	`assert("REGB_DOUT", REGB_DOUT, ARGB)
	
	`TICKTOCK;
	ALUB_SRCX = `ALUB_SRCX_ARG_U4;

	`TICKTOCK;
	`assert("U4", 16'b0000000000000101, ARGB)
	
	`TICKTOCK;
	ALUB_SRCX = `ALUB_SRCX_ARG_U8;

	`TICKTOCK;
	`assert("U8", 16'b0000000010100101, ARGB)
	
	`TICKTOCK;
	ALUB_SRCX = `ALUB_SRCX_U8_REG_B;

	`TICKTOCK;
	`assert("U8H", 16'b1010010100110100, ARGB)
	
	`TICKTOCK;
	ALUB_SRCX = `ALUB_SRCX_ARG_U4_0;

	`TICKTOCK;
	`assert("U4.0", 16'b0000000000001010, ARGB)
	
	`TICKTOCK;
	ALUB_SRCX = `ALUB_SRCX_ARG_U6;

	`TICKTOCK;
	`assert("U6", 16'b00000000000100101, ARGB)
	
	`TICKTOCK;
	ALUB_SRCX = `ALUB_SRCX_ARG_U6_0;

	`TICKTOCK;
	`assert("U6.0", 16'b0000000001001010, ARGB)
	
	`TICKTOCK;
	ALUB_SRCX = `ALUB_SRCX_ZERO;
	
	`TICKTOCK;
	`assert("ZERO", 16'b0000000000000000, ARGB)
	
	`TICKTOCK;

end

endmodule