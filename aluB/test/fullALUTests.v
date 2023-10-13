`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module fullALUTests;

	reg CLK;
	reg RESET;
	
	reg [15:0] ALUA_DIN;
	reg [15:0] ALUB_DIN;
	reg [3:0]  ALU_OPX;
	
	reg [1:0] ALUA_SRCX;
	reg [2:0] ALUB_SRCX;
	
	reg [3:0] ARGA_X;
	reg [3:0] ARGB_X;
	reg [1:0] LDSINCF;

	reg CCL_LD;
	
	wire [15:0] ALUA_DATA;
	wire [15:0] ALUB_DATA;
	wire [15:0] ALU_R;
	wire [3:0] CCN;

fullALU testInstance(
	.CLK(CLK),
	.RESET(RESET),
	.ALUA_DIN(ALUA_DIN),
	.ALUB_DIN(ALUB_DIN),
	.ALU_OPX(ALU_OPX),
	.ALUA_SRCX(ALUA_SRCX),
	.ALUB_SRCX(ALUB_SRCX),
	.ARGA_X(ARGA_X),
	.ARGB_X(ARGB_X),
	.LDSINCF(LDSINCF),
	.CCL_LD(CCL_LD),
	.ALU_R(ALU_R),
	.CCN(CCN),
	.ALUA_DATA(ALUA_DATA),
	.ALUB_DATA(ALUB_DATA)
);


// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	#10
	CLK = 0; 
	`TICK;
	CCL_LD = 0;
	RESET = 1;
	ALUA_DIN = 16'h1234;
	ALUB_DIN = 16'h4321;
	ALU_OPX = `ALU_OPX_ADD;
	ALUA_SRCX = `ALUA_SRCX_REG_A;
	ALUB_SRCX = `ALUB_SRCX_REG_B;
	ARGA_X = 4'b0101;
	ARGB_X = 4'b1010;
	LDSINCF = 2'b10;
	
	`TICK;
	`TICK;

	RESET = 0;  
	`TICKTOCK;
	// Start FETCH
	`TICKTOCK; 	 
	// Latch instruction 
	`TICKTOCK; 	 
	// Control outputs become valid here
	CCL_LD = 1;
	
	`TICKTOCK;
	// Result
	`assert("ALU_R",      16'h5555, ALU_R)
	`assert("CCN",        4'b0000,  CCN)
	`TICKTOCK;
	CCL_LD = 0;
	ALUA_DIN = 16'hffff;
	ALUB_DIN = 16'hffff;
	`TICKTOCK;
	// CC Result should be unchanged
	`assert("ALU_R",      16'hfffe, ALU_R)
	`assert("CCN",        4'b0000,  CCN)
	`TICKTOCK;
	CCL_LD = 1;
	`TICKTOCK;
	// CC Result should be latched through
	`assert("ALU_R",      16'hfffe, ALU_R)
	`assert("CCN",        4'b0011,  CCN)
	
end

endmodule