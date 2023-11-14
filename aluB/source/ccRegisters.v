`include "C:/Users/Duncan/git/ForthCPU/constants.v"
/***************************************************
* The CC register and its alternates used during
* interrupt handling
****************************************************/

module ccRegisters(
	
	input CLK,
	input RESET,
	input FETCH,
	input CCL_LD,
	input CCL_ENRX,
	input CCL_EN0X,
	input CCL_EN1X,
	input [1:0] CC_REGX,
	
	input       [3:0] CCIN,
	output reg  [3:0] CCOUT
	
);

// The registers
reg [3:0] CC_RUN_REG;
reg [3:0] CC_INT0_REG;
reg [3:0] CC_INT1_REG;


always @(*) begin
	case(CC_REGX)
		`CC_REGX_RUN:  CCOUT = CC_RUN_REG;
		`CC_REGX_INT0: CCOUT = CC_INT0_REG;
		`CC_REGX_INT1: CCOUT = CC_INT1_REG;
		default:       CCOUT = CC_RUN_REG;
	endcase
end

always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		CC_RUN_REG  <= 4'b0000;
		CC_INT0_REG <= 4'b0000;
		CC_INT1_REG <= 4'b0000;
	end else begin
		if(FETCH & CCL_LD) begin
			if(CCL_ENRX) CC_RUN_REG  <= CCIN;
			if(CCL_EN0X) CC_INT0_REG <= CCIN;
			if(CCL_EN1X) CC_INT1_REG <= CCIN;
		end
	end
end
		

endmodule