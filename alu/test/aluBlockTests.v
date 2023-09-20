`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module aluBlockTests;

reg CLK;
reg RESET;

reg [15:0] ARGA;
reg [15:0] ARGB;
reg [3:0] ALU_OPX;

reg ALU_LD;

reg CCL_LD;

wire [15:0] ALU_R;
wire [3:0] CCN;


aluBlock testInstance(
	.CLK(CLK),
	.RESET(RESET),
	.ARGA(ARGA),
	.ARGB(ARGB),
	.ALU_OPX(ALU_OPX),
	.ALU_LD(ALU_LD),
	.CCL_LD(CCL_LD),
	.ALU_R(ALU_R),
	.CCN(CCN)
);


// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	#10
	CLK = 0; 
	`TICK;
	ALU_LD = 0;
	CCL_LD = 0;
	RESET = 1;
	ARGA = 16'h1234;
	ARGB = 16'h4321;
	ALU_OPX = `ALU_ADD;
	`TICK;
	`TICK;

	RESET = 0;  
	`TICKTOCK;
	// Start FETCH
	`TICKTOCK; 	 
	// Latch instruction 
	`TICKTOCK; 	 
	// Control outputs become valid here
	ALU_LD = 1;
	CCL_LD = 1;
	
	`TICKTOCK;
	// Result should be latched through
	`assert("ALU_R",      16'h5555, ALU_R)
	`assert("CCN",        4'b0000,  CCN)
	`TICKTOCK;
	ALU_LD = 0;
	CCL_LD = 0;
	ARGA = 16'hffff;
	ARGB = 16'hffff;
	`TICKTOCK;
	// Result should be unchanged
	`assert("ALU_R",      16'h5555, ALU_R)
	`assert("CCN",        4'b0000,  CCN)
	`TICKTOCK;
	ALU_LD = 1;
	CCL_LD = 1;
	`TICKTOCK;
	// Result should be latched through
	`assert("ALU_R",      16'hfffe, ALU_R)
	`assert("CCN",        4'b0011,  CCN)
	
end

endmodule