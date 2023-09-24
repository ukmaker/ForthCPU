`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/**
* The whole ALU block including the
* - ALU
* - output registers
* - B input mux
* - A input incrementer
**/

module fullALU(
	
	input CLK,
	input RESET,
	
	input [15:0] REGA_DOUT,
	input [15:0] REGB_DOUT,
	
	input [3:0] ALU_OPX,
	input [3:0] ARGA_X,
	input [3:0] ARGB_X,
	input       ALUA_SRCX,
	input [2:0] ALUB_SRCX,
	input [1:0] ALUA_CONSTX,
	input [1:0] LDS_SRCX,
	input ALU_LD,
	input CCL_LD,
	
	output wire [15:0] ALUA_DATA,
	output wire [15:0] ALUB_DATA,
	output wire [15:0] ALU_R,
	output wire [15:0] ALUA_PP,
	output wire [3:0]  CCN
	
);

aluBMux aluBMuxInst(

	.REGB_DOUT(REGB_DOUT),
	.ARGA_X(ARGA_X),
	.ARGB_X(ARGB_X),
	.ALUB_SRCX(ALUB_SRCX),
	.ARGB(ALUB_DATA),
	.LDS_SRCX(LDS_SRCX)
);


aluBlock aluBlockInst(
	.CLK(CLK),
	.RESET(RESET),
	.ARGA(ALUA_DATA),
	.ARGB(ALUB_DATA),
	.ALU_OPX(ALU_OPX),
	.ALU_LD(ALU_LD),
	.CCL_LD(CCL_LD),
	.ALU_R(ALU_R),
	.CCN(CCN)
);

incrementer incInst(
	.ALUA_SRCX(ALUA_SRCX),
	.REGA_DOUT(REGA_DOUT),
	.ALUA_CONSTX(ALUA_CONSTX),
	.ALUA_DIN(ALUA_DATA),
	.ALUA_PP(ALUA_PP)
);


endmodule
	
	