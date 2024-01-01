`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/**
* ALU including input muxes and CC latch
**/
/**
* The ALU and its output registers**/

module fullALU(
	
	input CLK,
	input RESET,
	input FETCH,
	
	input [15:0] REGA_DOUT,
	input [15:0] REGB_DOUT,
	input [3:0]  ALU_OPX,
	
	input [2:0] ALUA_SRCX,
	input [2:0] ALUB_SRCX,
	
	input [3:0] ARGAX,
	input [3:0] ARGBX,
	input        B5,

	input CCL_LD,
	input CCL_ENRX,
	input CCL_EN0X,
	input CCL_EN1X,
	input [1:0] CC_REGX,
	
	output wire [15:0] ALU_R,
	output wire CC_ZERO,
	output wire CC_CARRY,
	output wire CC_SIGN,
	output wire CC_PARITY
);

wire CC_Z;
wire CC_S;
wire CC_P;
wire CC_C;
wire [15:0] ALUA_DATA;
wire [15:0] ALUB_DATA;

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
	.U5({B5,ARGBX}),
	.REGA_DOUT(REGA_DOUT),
	.ALUA_SRCX(ALUA_SRCX),
	.ALUA_DATA(ALUA_DATA)
);

aluBMux muxB(
	.REGB_DOUT(REGB_DOUT),
	.ALUB_SRCX(ALUB_SRCX),
	.ARGA_X(ARGAX),
	.ARGB_X(ARGBX),
	.ALUB_DATA(ALUB_DATA)

);

ccRegisters ccRegs(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.CCL_LD(CCL_LD),
	.CCL_ENRX(CCL_ENRX),
	.CCL_EN0X(CCL_EN0X),
	.CCL_EN1X(CCL_EN1X),
	.CC_REGX(CC_REGX),
	.CCIN({CC_P,CC_S,CC_C,CC_Z}),
	.CCOUT({CC_PARITY,CC_SIGN,CC_CARRY,CC_ZERO})
);

endmodule