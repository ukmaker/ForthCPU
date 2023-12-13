`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module debugSequencerTests;
	
	reg CLK;
	reg RESET;
	reg COMMIT;
	reg DEBUG_ADDR_INCX;
	reg DEBUG_LD_DATAX;
	
	wire DEBUG_ADDR_INC_EN;
	wire DEBUG_LD_DATA_EN;
	
	
debugSequencer testArticle(

	.CLK(CLK),
	.RESET(RESET),
	.COMMIT(COMMIT),
	.DEBUG_ADDR_INCX(DEBUG_ADDR_INCX),
	.DEBUG_LD_DATAX(DEBUG_LD_DATAX),
	.DEBUG_ADDR_INC_EN(DEBUG_ADDR_INC_EN),
	.DEBUG_LD_DATA_EN(DEBUG_LD_DATA_EN)
);

reg [1:0] PHI;
reg COMMIT_R;

always begin
	#50 CLK = ~CLK;
end

always begin
	#100 PHI <= PHI + 1;
	COMMIT_R <= PHI == 3 ? 1 : 0;
end

always begin
	COMMIT = #10 COMMIT_R;
end

initial begin
	#50;
	CLK = 0;
	RESET = 0;
	PHI = 0;
	COMMIT = 0;
	DEBUG_ADDR_INCX = 0;
	DEBUG_LD_DATAX = 0;
	#100;
	RESET = 1;
	#100;
	RESET = 0;
	#260;
	`mark(1)
	`assert("COMMIT", 1 , COMMIT)
	`assert("DEBUG_ADDR_INC", 0, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 0, DEBUG_LD_DATA_EN)
	#100;
	`assert("DEBUG_ADDR_INC", 0, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 0, DEBUG_LD_DATA_EN)
	#100;
	`assert("DEBUG_ADDR_INC", 0, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 0, DEBUG_LD_DATA_EN)
	#100;
	`assert("DEBUG_ADDR_INC", 0, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 0, DEBUG_LD_DATA_EN)
	#100;
	`mark(2)
	`assert("COMMIT", 1 , COMMIT)
	`assert("DEBUG_ADDR_INC", 0, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 0, DEBUG_LD_DATA_EN)
	DEBUG_ADDR_INCX = 1;
	#100;
	`assert("DEBUG_ADDR_INC", 0, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 0, DEBUG_LD_DATA_EN)
	#100;
	`assert("DEBUG_ADDR_INC", 0, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 0, DEBUG_LD_DATA_EN)
	#100;
	`assert("DEBUG_ADDR_INC", 0, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 0, DEBUG_LD_DATA_EN)
	#100;
	`mark(3)
	`assert("COMMIT", 1 , COMMIT)
	`assert("DEBUG_ADDR_INC", 1, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 0, DEBUG_LD_DATA_EN)
	DEBUG_ADDR_INCX = 0;
	DEBUG_LD_DATAX = 1;
	#100;
	`assert("DEBUG_ADDR_INC", 0, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 0, DEBUG_LD_DATA_EN)
	#100;
	`assert("DEBUG_ADDR_INC", 0, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 0, DEBUG_LD_DATA_EN)
	#100;
	`assert("DEBUG_ADDR_INC", 0, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 0, DEBUG_LD_DATA_EN)
	#100;
	`mark(4)
	`assert("COMMIT", 1 , COMMIT)
	`assert("DEBUG_ADDR_INC", 0, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 1, DEBUG_LD_DATA_EN)
	#100;
	`assert("DEBUG_ADDR_INC", 0, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 0, DEBUG_LD_DATA_EN)
	DEBUG_LD_DATAX = 0;
	#100;
	`assert("DEBUG_ADDR_INC", 0, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 0, DEBUG_LD_DATA_EN)
	#100;
	`assert("DEBUG_ADDR_INC", 0, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 0, DEBUG_LD_DATA_EN)
	#100;
	`mark(5)
	`assert("COMMIT", 1 , COMMIT)
	`assert("DEBUG_ADDR_INC", 0, DEBUG_ADDR_INC_EN)
	`assert("DEBUG_ADDR_LD_DATA", 0, DEBUG_LD_DATA_EN)
end

endmodule