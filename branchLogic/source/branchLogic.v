`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/**
* Branch logic generating the PC control signals
**/
module branchLogic(
	
	input CCZ,
	input CCC,
	input CCP,
	input CCS,
	
	input [1:0] CC_SELECTX,
	input CC_INVERTX,
	input CC_APPLYX,
	input JMPX,
	input JRX,
	
	output reg PC_OFFSETX,
	output reg PC_BASEX
	
);

reg CC;
reg CC_APPLY;

always @(*) begin
	
	case(CC_SELECTX)
		`CC_SELECTX_Z: CC = CCZ;
		`CC_SELECTX_C: CC = CCC;
		`CC_SELECTX_P: CC = CCP;
		`CC_SELECTX_S: CC = CCS;
	endcase
	
	CC_APPLY = ~CC_APPLYX | (CC_INVERTX ? ~CC : CC);
	PC_OFFSETX = JMPX & CC_APPLY;
	PC_BASEX   = JMPX & JRX & CC_APPLY;	
	
end
	
endmodule