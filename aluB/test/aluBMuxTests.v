`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module aluBMuxTests;
	
	reg [15:0] ALUB_DIN;
	reg [2:0] ALUB_SRCX;
	
	reg [3:0] ARGA_X;
	reg [3:0] ARGB_X;
	reg [1:0] LDSINCF;
	
	wire [15:0] ALUB_DATA;
	
	reg CLK;
	
aluBMux testInstance(

	.ALUB_DIN(ALUB_DIN),
	.ALUB_SRCX(ALUB_SRCX),
	.ARGA_X(ARGA_X),
	.ARGB_X(ARGB_X),
	.LDSINCF(LDSINCF),
	.ALUB_DATA(ALUB_DATA)
);


// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	#10
	CLK = 0; 
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	 
	ALUB_DIN = 16'h1234;
	ALUB_SRCX = 3'b000;
	ARGA_X = 4'b1010;
	ARGB_X = 4'b0101;
	LDSINCF = 2'b10;
	
	ALUB_SRCX = `ALUB_SRCX_REG_B;
	`TICKTOCK;
	`assert("ALUB_DATA", 16'h1234, ALUB_DATA)

	ALUB_SRCX = `ALUB_SRCX_U8H;
	`TICKTOCK;
	`assert("ALUB_DATA", 16'ha534, ALUB_DATA)

	ALUB_SRCX = `ALUB_SRCX_U8;
	ARGA_X = 4'b1000;
	ARGB_X = 4'b0001;
	`TICKTOCK;
	`assert("ALUB_DATA", 16'h0081, ALUB_DATA)

	ALUB_SRCX = `ALUB_SRCX_S8;
	ARGA_X = 4'b1000;
	ARGB_X = 4'b0001;
	`TICKTOCK;
	`assert("ALUB_DATA", 16'hff81, ALUB_DATA)

	ALUB_SRCX = `ALUB_SRCX_S8;
	ARGA_X = 4'b0100;
	ARGB_X = 4'b0001;
	`TICKTOCK;
	`assert("ALUB_DATA", 16'h0041, ALUB_DATA)


	ALUB_SRCX = `ALUB_SRCX_U4;
	ARGA_X = 4'b1000;
	ARGB_X = 4'b0001;
	`TICKTOCK;
	`assert("ALUB_DATA", 16'h0001, ALUB_DATA)


	ALUB_SRCX = `ALUB_SRCX_U4_0;
	ARGA_X = 4'b1000;
	ARGB_X = 4'b0001;
	`TICKTOCK;
	`assert("ALUB_DATA", 16'h0002, ALUB_DATA)

	ALUB_SRCX = `ALUB_SRCX_U6;
	ARGA_X = 4'b1000;
	ARGB_X = 4'b1010;
	`TICKTOCK;
	`assert("ALUB_DATA", 16'h002a, ALUB_DATA)


	ALUB_SRCX = `ALUB_SRCX_U6_0;
	ARGA_X = 4'b1000;
	ARGB_X = 4'b1010;
	// 0101 0100
	`TICKTOCK;
	`assert("ALUB_DATA", 16'h0054, ALUB_DATA)


end

endmodule