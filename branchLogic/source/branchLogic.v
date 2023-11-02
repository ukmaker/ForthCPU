`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/**
* Branch logic generating the PC control signals
**/
module branchLogic(
	
	input CC_ZERO,
	input CC_CARRY,
	input CC_PARITY,
	input CC_SIGN,
	
	input [1:0] CC_SELECTX,
	input CC_INVERTX,
	input CC_APPLYX,
	input [1:0] JMPX,
	
	output reg [1:0] PC_OFFSETX,
	output reg [1:0] PC_BASEX
	
);

reg CC;
reg CC_APPLY;

always @(*) begin
	
	PC_OFFSETX = `PC_OFFSETX_2;
	PC_BASEX   = `PC_BASEX_PC_A;
	
	case(CC_SELECTX)
		`CC_SELECTX_Z: CC = CC_ZERO;
		`CC_SELECTX_C: CC = CC_CARRY;
		`CC_SELECTX_P: CC = CC_PARITY;
		`CC_SELECTX_S: CC = CC_SIGN;
	endcase
	
	CC_APPLY = ~CC_APPLYX | (CC_INVERTX ? ~CC : CC);
	
	if(CC_APPLY) begin
		case(JMPX)
			`MODE_JMP_ABS_REG: begin
				PC_OFFSETX = `PC_OFFSETX_DIN;
				PC_BASEX   = `PC_BASEX_0;
			end
			
			`MODE_JMP_ABS_HERE: begin
				PC_OFFSETX = `PC_OFFSETX_DIN;
				PC_BASEX   = `PC_BASEX_0;
			end
			
			`MODE_JMP_IND_REG: begin
				PC_OFFSETX = `PC_OFFSETX_DIN;
				PC_BASEX   = `PC_BASEX_0;
			end
			
			`MODE_JMP_REL_HERE: begin
				PC_OFFSETX = `PC_OFFSETX_DIN;
				PC_BASEX   = `PC_BASEX_PC_A;
			end
			
		endcase
	end
	
end
	
endmodule