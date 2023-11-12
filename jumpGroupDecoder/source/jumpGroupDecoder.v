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
	
	input CLK,
	input RESET,
	input DECODE,
	input EXECUTE,
	input COMMIT,
	
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
	output reg[1:0] REGA_DINX,
	output reg[1:0] REGA_ADDRX,
	output reg[2:0] REGB_ADDRX,
	output reg [2:0] REG_SEQX,
	
	/**
	* ALU control
	**/
	output reg [2:0] ALUB_SRCX,

	/**
	* Bus control
	**/
	output reg        RDX
);

reg RD_M;

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
	
	if(CC_APPLY) begin
		case(JPF)
			`MODE_JMP_ABS_REG: begin
				PC_OFFSETX = `PC_OFFSETX_0;
				PC_BASEX   = `PC_BASEX_REGB_DOUT;
				ADDR_BUSX  = `ADDR_BUSX_PC_A;
			end
			
			`MODE_JMP_ABS_HERE: begin
				PC_OFFSETX = `PC_OFFSETX_DIN;
				PC_BASEX   = `PC_BASEX_0;
				ADDR_BUSX  = `ADDR_BUSX_HERE;
			end
			
			`MODE_JMP_IND_REG: begin
				PC_OFFSETX = `PC_OFFSETX_DIN;
				PC_BASEX   = `PC_BASEX_0;
				ADDR_BUSX  = `ADDR_BUSX_PC_A;
			end
			
			`MODE_JMP_REL_HERE: begin
				PC_OFFSETX = `PC_OFFSETX_DIN;
				PC_BASEX   = `PC_BASEX_PC_A;
				ADDR_BUSX  = `ADDR_BUSX_HERE;
			end
		endcase
	end	else begin
		case(JPF)
			`MODE_JMP_ABS_REG: begin
				PC_OFFSETX = `PC_OFFSETX_2;
				PC_BASEX   = `PC_BASEX_PC_A;
				ADDR_BUSX  = `ADDR_BUSX_PC_A;
			end
			
			`MODE_JMP_ABS_HERE: begin
				PC_OFFSETX = `PC_OFFSETX_4;
				PC_BASEX   = `PC_BASEX_PC_A;
				ADDR_BUSX  = `ADDR_BUSX_PC_A;
			end
			
			`MODE_JMP_IND_REG: begin
				PC_OFFSETX = `PC_OFFSETX_2;
				PC_BASEX   = `PC_BASEX_PC_A;
				ADDR_BUSX  = `ADDR_BUSX_PC_A;
			end
			
			`MODE_JMP_REL_HERE: begin
				PC_OFFSETX = `PC_OFFSETX_4;
				PC_BASEX   = `PC_BASEX_PC_A;
				ADDR_BUSX  = `ADDR_BUSX_PC_A;
			end
		endcase
	end
end

always @(*) begin
	
	ALUB_SRCX  = `ALUB_SRCX_REG_B;
	REGA_DINX  = `REGA_DINX_HERE;
	REGA_ADDRX = `REGA_ADDRX_RL;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	REG_SEQX   = `REG_SEQX_NONE;
	RD_M = 0;
	
	if(CC_APPLY)  begin
		
		case(JPF)
			`MODE_JMP_ABS_REG: begin
				REG_SEQX = JLF ? `REG_SEQX_LDA_RDB : `REG_SEQX_RDB;
			end
			
			`MODE_JMP_ABS_HERE: begin
				REG_SEQX = JLF ? `REG_SEQX_LDA_RDB : `REG_SEQX_NONE;
				RD_M = 1;	
			end

			`MODE_JMP_IND_REG: begin
				ALUB_SRCX  = `ALUB_SRCX_S8;
				REGA_ADDRX = `REGA_ADDRX_RL;
				REGB_ADDRX = `REGB_ADDRX_ARGB;
				REG_SEQX   = JLF ? `REG_SEQX_LDA_RDB : `REG_SEQX_RDB;
			end

			`MODE_JMP_REL_HERE: begin
				ALUB_SRCX  = `ALUB_SRCX_U8H;
				REGA_ADDRX = `REGA_ADDRX_RL;
				REGB_ADDRX = `REGB_ADDRX_RB;
				REG_SEQX   = JLF ? `REG_SEQX_LDA_RDB : `REG_SEQX_NONE;
				RD_M = 1;	
			end
		endcase
	end
end


always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
		RDX <= 0;
	end else begin
		
		if(DECODE) begin
			RDX <= RD_M;
		end else if(EXECUTE) begin
			RDX <= RD_M;
		end else if(COMMIT) begin
			RDX <= RD_M;
		end else begin
			RDX <= 0;
		end
	end
	
end
	
endmodule