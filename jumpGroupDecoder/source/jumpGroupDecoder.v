`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`timescale 1 ns / 1 ns
/**
* Instruction formats
* 
*  F  E  D  C  B  A  9  8   7   6  5  4  3  2  1  0
*  1  0  ----  ----  ----  ---  -------  ----------  Group 2: Jumps
*  GPF   SKIPF CCF   JPF   JLF  X  X  X    ARGB
*
*  SKIPF: 00 - Always
*         01 - Always
*         10 - On CC
*         11 - On !CC
*
*  CCF:   00 - Z
*         01 - C
*         10 - S
*         11 - P
*
*  JPF:   00 - JP Rb
*         01 - JP (Rb)
*         10 - JP S16
*         11 - JR S16
*
*  JLF:    0 - No link
*          1 - Set link
*
*/
module jumpGroupDecoder(
	
	input [1:0] GROUPF,
	input [1:0] SKIPF,
	input [1:0] CCF,
	input [1:0] JPF,
    input        JLF,
	
	input CC_ZERO,
	input CC_CARRY,
	input CC_PARITY,
	input CC_SIGN,
	
	/**
	* Program counter control
	**/
	output reg [1:0] PC_OFFSETX,
	output reg [1:0] PC_BASEX,
	output reg [1:0] ADDR_BUSX,
	
	/**
	* Register file control
	**/
	output reg[1:0] REGA_ADDRX,
	output reg[2:0] REGB_ADDRX,
	output reg REGA_EN,
	output reg REGA_WEN,
	output reg REGB_EN,
	
	/**
	* ALU control
	**/
	output reg [2:0] ALUB_SRCX
	
);

reg         CC;
reg         CC_APPLY;
wire [1:0] CC_SELECTX;
wire        CC_INVERTX;
wire        CC_APPLYX;

assign CC_SELECTX = CCF;
assign CC_INVERTX = SKIPF[0];
assign CC_APPLYX  = SKIPF[1];

// Select the condition code
always @(*) begin
	
	PC_OFFSETX = `PC_OFFSETX_2;
	PC_BASEX   = `PC_BASEX_PC_A;
	ADDR_BUSX  = `ADDR_BUSX_PC_A;
	
	case(CC_SELECTX)
		`CC_SELECTX_Z: CC = CC_ZERO;
		`CC_SELECTX_C: CC = CC_CARRY;
		`CC_SELECTX_P: CC = CC_PARITY;
		`CC_SELECTX_S: CC = CC_SIGN;
	endcase
	
	CC_APPLY = ~CC_APPLYX | (CC_INVERTX ? ~CC : CC);
end

// Control the multiplexers
// These lines will be activated by the opxMultiplexer during COMMIT
always @(*) begin
	
	PC_OFFSETX = `PC_OFFSETX_2;
	PC_BASEX   = `PC_BASEX_PC_A;
	
	if(CC_APPLY) begin
		case(JPF)
			`MODE_JMP_ABS_REG: begin
				PC_OFFSETX = `PC_OFFSETX_0;
				PC_BASEX   = `PC_BASEX_REGB_DOUT;
			end
			
			`MODE_JMP_ABS_HERE: begin
				PC_OFFSETX = `PC_OFFSETX_DIN;
				PC_BASEX   = `PC_BASEX_0;
				ADDR_BUSX  = `ADDR_BUSX_HERE;
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

always @(*) begin
	
	ALUB_SRCX  = `ALUB_SRCX_REG_B;
	REGA_ADDRX = `REGA_ADDRX_RL;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	REGA_EN    = 0;
	REGA_WEN   = 0;
	REGB_EN    = 0;
	
	if(JLF == `JLF_LINK) begin
		REGA_EN  = 1;
		REGA_WEN = 1;
	end
	
	case(JPF)
		`MODE_JMP_ABS_REG: begin
			REGB_EN    = 1;
		end
		
		`MODE_JMP_ABS_HERE: begin
			// 	
		end

		`MODE_JMP_IND_REG: begin
			ALUB_SRCX = `ALUB_SRCX_S8;
			REGA_ADDRX = `REGA_ADDRX_RL;
			REGB_ADDRX = `REGB_ADDRX_ARGB;
			REGA_EN  = 0;
			REGA_WEN = 0;
			REGB_EN  = 1;
		end

		`MODE_JMP_REL_HERE: begin
			ALUB_SRCX = `ALUB_SRCX_U8H;
			REGA_ADDRX = `REGA_ADDRX_RL;
			REGB_ADDRX = `REGB_ADDRX_RB;
			REGA_EN  = 0;
			REGA_WEN = 0;
			REGB_EN  = 1;
		end
	endcase
end
	
endmodule