`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/**
* ALU including input muxes and CC latch
**/
/**
* The ALU and its output registers**/

module fullALU(
	
	input CLK,
	input RESET,
	
	input [15:0] REGA_DOUT,
	input [15:0] REGB_DOUT,
	input [3:0]  ALU_OPX,
	
	input [2:0] ALUA_SRCX,
	input [2:0] ALUB_SRCX,
	
	input [3:0] ARGA_X,
	input [3:0] ARGB_X,
	input        B5,

	input CCL_LD,
	
	output wire [15:0] ALU_R,
	output reg CC_ZERO,
	output reg CC_CARRY,
	output reg CC_SIGN,
	output reg CC_PARITY,
	output wire [15:0] ALUA_DATA,
	output wire [15:0] ALUB_DATA
);

wire CC_Z;
wire CC_S;
wire CC_P;
wire CC_C;

alu aluInst(
	.ALUX(ALU_OPX),
	.ARGA(ALUA_DATA),
	.ARGB(ALUB_DATA),
	.RESULT(ALU_R),
	.SIGN(CC_S),
	.CARRY(CC_C),
	.ZERO(CC_Z),
	.PARITY(CC_P)
);

aluAMux muxA(
	.U5({B5,ARGB_X}),
	.REGA_DOUT(REGA_DOUT),
	.ALUA_SRCX(ALUA_SRCX),
	.ALUA_DATA(ALUA_DATA)
);

aluBMux muxB(
	.REGB_DOUT(REGB_DOUT),
	.ALUB_SRCX(ALUB_SRCX),
	.ARGA_X(ARGA_X),
	.ARGB_X(ARGB_X),
	.ALUB_DATA(ALUB_DATA)

);

always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		CC_ZERO <= 0;
		CC_CARRY <= 0;
		CC_SIGN <= 0;
		CC_PARITY <= 0;
	end else if(CCL_LD == 1'b1) begin
		CC_ZERO   <= CC_Z;
		CC_CARRY  <= CC_C;
		CC_SIGN   <= CC_S;
		CC_PARITY <= CC_P;
	end
end

endmodule