`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`timescale 1 ns / 1 ns
/**
* Instruction formats
* 
*  F  E  D  C  B  A  9  8  7  6  5  4  3  2  1  0
*  0  0  ----------  X  X  ----------  ----------  Group 0: System
*  GPF      SYSF              ARGA        ARGB
*              
*              
*  0  1  ----  ----  ----  ----------  ----------  Group 1: Load/Store
*  GPF   INCF  LDSF  MODEF    ARGA        ARGB
*
*
*  1  0  ----  ----  ----  ----------  ----------  Group 2: Jumps
*  GPF   SKIPF JPF   CCF      ARGA        ARGB
*
*
*  1  1  ----------  ----  ----------  ----------  Group 3: ALU
*  GPF      ALUF     ARGF     ARGA        ARGB
*              
*  GPF   - Instruction group field
*  SYSF  - System operation field
*  INCF  - Increment/decrement field
*  LDSF  - Load/store operation field
*  MODEF - Addressing mode field
*  SKIPF - Condition handling field
*  CCF   - Condition code select field
*  JPF   - Jump type field
*  ALUF  - ALU operation field
*  ARGF  - ALU argument type field
*
* Instruction types
* JP/JR Rb
* JP/JR U8H.RBL
*/
module jumpGroupDecoder(
	
	input CLK,
	input RESET,
	input [15:0] INSTRUCTION,
	
	input FETCH,
	input DECODE,
	input EXECUTE,
	input COMMIT,
	
	/**
	* Program counter control
	**/
	output reg PC_EN,
	output wire JRX,
	output reg JMP_X,
	output reg CC_APPLYX,
	output wire CC_INVERTX,
	output wire [1:0] CC_SELECTX,
	
	/**
	* Register file control
	**/
	output reg[1:0] REGB_ADDRX,
	/**
	* ALU control
	**/
	output reg [2:0] ALUB_SRCX
	
	
);

wire [1:0] GROUPF;
wire [1:0] SKIPF;
wire [1:0] JPF;


assign GROUPF= INSTRUCTION[15:14];
assign SKIPF = INSTRUCTION[13:12];
assign JPF   = INSTRUCTION[11:10];
assign CC_SELECTX   = INSTRUCTION[9:8];

assign CC_INVERTX = SKIPF[0];
assign JRX = JPF[1];

always @(*) begin
	if(GROUPF == `GROUP_JUMP) begin
		JMP_X = ~SKIPF[1];
		CC_APPLYX = ~JMP_X;
	end else begin
		CC_APPLYX = 0;
		JMP_X = 0;
	end
	
	if(INSTRUCTION == `INSTRUCTION_HALT) begin
		PC_EN = 0;
	end else begin
		PC_EN = 1;
	end
	
	if(JPF[0]) begin
		ALUB_SRCX = `ALUB_SRCX_U8_REG_B;
		REGB_ADDRX = `REGB_ADDRX_RB;
	end else begin
		ALUB_SRCX = `ALUB_SRCX_REG_B;
		REGB_ADDRX = `REGB_ADDRX_ARGB;
	end
end
	
endmodule