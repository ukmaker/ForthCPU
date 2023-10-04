`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/**
* ALU including input muxes and CC latch
**/
/**
* The ALU and its output registers**/

module fullALU(
	
	input CLK,
	input RESET,
	
	input [15:0] ALUA_DIN,
	input [15:0] ALUB_DIN,
	input [3:0]  ALU_OPX,
	
	input [1:0] ALUA_SRCX,
	input [2:0] ALUB_SRCX,
	
	input [3:0] ARGA_X,
	input [3:0] ARGB_X,
	input [1:0] LDSINCF,

	input CCL_LD,
	
	output wire [15:0] ALU_R,
	output wire [3:0] CCN,
	output wire [15:0] ALUA_DATA,
	output wire [15:0] ALUB_DATA
);

wire [3:0] CC;
reg [3:0] CCD;


alu aluInst(
	.ALUX(ALU_OPX),
	.ARGA(ALUA_DATA),
	.ARGB(ALUB_DATA),
	.RESULT(ALU_R),
	.SIGN(CC[0]),
	.CARRY(CC[1]),
	.ZERO(CC[2]),
	.PARITY(CC[3])
);

aluAMux muxA(
	.ALUA_DIN(ALUA_DIN),
	.ALUA_SRCX(ALUA_SRCX),
	.ALUA_DATA(ALUA_DATA)
);

aluBMux muxB(
	.ALUB_DIN(ALUB_DIN),
	.ALUB_SRCX(ALUB_SRCX),
	.ARGA_X(ARGA_X),
	.ARGB_X(ARGB_X),
	.LDSINCF(LDSINCF),
	.ALUB_DATA(ALUB_DATA)

);

always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		CCD <= 4'b0000;
	end else if(CCL_LD == 1'b1) begin
		CCD <= CC;
	end
end

assign CCN = CCD;

endmodule