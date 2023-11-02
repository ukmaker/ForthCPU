`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module branchLogicTests;
	
	reg CCZ;
	reg CCS;
	reg CCP;
	reg CCC;

	
	reg [1:0] CC_SELECTX;
	reg CC_INVERTX;
	reg CC_APPLYX;
	reg [1:0] JMPX;
	
	wire [1:0] PC_OFFSETX;
	wire [1:0] PC_BASEX;
	
branchLogic testInstance(
	.CC_ZERO(CCZ),
	.CC_CARRY(CCC),
	.CC_PARITY(CCP),
	.CC_SIGN(CCS),
	.CC_SELECTX(CC_SELECTX),
	.CC_INVERTX(CC_INVERTX),
	.CC_APPLYX(CC_APPLYX),
	.JMPX(JMPX),
	.PC_OFFSETX(PC_OFFSETX),
	.PC_BASEX(PC_BASEX)
);
	
reg CLK;

reg [15:0] IDX = 16'h0000;


// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	#10
	CLK = 0; 
	CCZ = 0;
	CCS = 0;
	CCP = 0;
	CCC = 0;
	CC_SELECTX = `CC_SELECTX_Z;
	CC_INVERTX = `CC_INVERTX_NONE;
	CC_APPLYX  = `CC_APPLYX_NONE;
	JMPX       = `MODE_JMP_ABS_REG;
	
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	 
	 // let's check everything is stable

	`TICKTOCK;
	IDX = 1;
	`assert("PC_OFFSETX", `PC_OFFSETX_2,  PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A, PC_BASEX)
	
	// CCs shouldn't affect anything yet
	CCZ = 1;
	`TICKTOCK;
	IDX = 2;
	`assert("PC_OFFSETX", `PC_OFFSETX_2,  PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A, PC_BASEX)
	
	CCS = 1;
	`TICKTOCK;
	IDX = 3;
	`assert("PC_OFFSETX", `PC_OFFSETX_2,  PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A, PC_BASEX)
	
	CCP = 1;
	`TICKTOCK;
	IDX = 4;
	`assert("PC_OFFSETX", `PC_OFFSETX_2,  PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A, PC_BASEX)
	
	CCC = 1;
	`TICKTOCK;
	IDX = 5;
	`assert("PC_OFFSETX", `PC_OFFSETX_2,  PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A, PC_BASEX)
	

	// CCs shouldn't affect anything yet
	CC_INVERTX = 1;
	`TICKTOCK;
	IDX = 6;
	`assert("PC_OFFSETX", `PC_OFFSETX_2,  PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A, PC_BASEX)
	
	
	CCZ = 0;
	CCS = 0;
	CCP = 0;
	CCC = 0;
	CC_APPLYX = 1;
	`TICKTOCK;
	IDX = 7;
	`assert("PC_OFFSETX", `PC_OFFSETX_2,  PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A, PC_BASEX)
	
	CCZ = 1;
	`TICKTOCK;
	IDX = 8;
	`assert("PC_OFFSETX", `PC_OFFSETX_2,  PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A, PC_BASEX)
	
	CC_INVERTX = 1;
	`TICKTOCK;
	IDX = 9;
	`assert("PC_OFFSETX", `PC_OFFSETX_2,  PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A, PC_BASEX)
	
	

	
	CCZ = 0;
	CCS = 0;
	CCP = 0;
	CCC = 0;
	CC_APPLYX = 1;
	CC_INVERTX = 0;
	JMPX = `MODE_JMP_ABS_REG;
	// JP[Z] - not taken
	`TICKTOCK;
	IDX = 10;
	#20
	`assert("PC_OFFSETX", `PC_OFFSETX_2,  PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A, PC_BASEX)
	

	CCZ = 1;
	// JP[Z] - taken
	`TICKTOCK;
	IDX = 11;
	#20
	`assert("PC_OFFSETX", `PC_OFFSETX_DIN, PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_0, PC_BASEX)
	#20
	CC_INVERTX = 1;
	// JP[Z] - not taken
	`TICKTOCK;
	IDX = 12;
	`assert("PC_OFFSETX", `PC_OFFSETX_2,  PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A, PC_BASEX)
	
	
	`TICKTOCK;
	IDX = 13;
	`assert("PC_OFFSETX", `PC_OFFSETX_2,  PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A, PC_BASEX)	


	JMPX = `MODE_JMP_REL_HERE;
	CCZ = 1;
	CC_INVERTX = 0;
	// JP[Z] - taken
	`TICKTOCK;
	IDX = 14;
	#20
	`assert("PC_OFFSETX", `PC_OFFSETX_DIN, PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A, PC_BASEX)
	#20
	CC_INVERTX = 1;
	// JP[Z] - not taken
	`TICKTOCK;
	IDX = 15;
	`assert("PC_OFFSETX", 0, PC_OFFSETX)
	`assert("PC_BASEX",   0, PC_BASEX)
	CCZ = 0;	
	`TICKTOCK;
	IDX = 16;
	`assert("PC_OFFSETX", `PC_OFFSETX_DIN, PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A, PC_BASEX)
	


end


endmodule