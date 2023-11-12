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
*/

`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module aluGroupDecoder(
	
	input CLK,
	input RESET,
	input [13:0] INSTRUCTION,
	
	input FETCH,
	input DECODE,
	input EXECUTE,
	input COMMIT,
	
	/**
	* Outputs to control functional blocks
	* These are fed to the control_multiplexer and then to the
	* functional units
	* ALU, Register file, data sources, program counter
	**/
	/**
	* Register file
	**/
	output reg [2:0] REG_SEQX,
	output reg [1:0] REGA_ADDRX,
	output reg [2:0] REGB_ADDRX,
	
	/**
	* ALU
	**/
	output wire [3:0] ALU_OPX,        // ALU operation
	output reg         CCL_LD,
	
	/**
	* Data Sources
	**/
	output reg [2:0] ALUA_SRCX,
	output reg [2:0] ALUB_SRCX,
	
	/**
	* Arguments
	**/
	output wire [3:0] ARGA_X,
	output wire [3:0] ARGB_X

);

wire [1:0] ARGF;

assign ALU_OPX = INSTRUCTION[13:10];
assign ARGF    = INSTRUCTION[9:8];
assign ARGA_X  = INSTRUCTION[7:4];
assign ARGB_X  = INSTRUCTION[3:0];

// Combinational logic
// Setup the data sources
always @(*) 
begin

	ALUA_SRCX  = `ALUA_SRCX_REG_A;
	ALUB_SRCX  = `ALUB_SRCX_REG_B;
	REG_SEQX   = `REG_SEQX_NONE;
	REGA_ADDRX = `REGA_ADDRX_ARGA;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	
	CCL_LD = ALU_OPX != `ALU_OPX_MOV;


	case(ARGF) 
		`MODE_ALU_REG_REG: begin // ALU Ra,Rb
			ALUB_SRCX = `ALUB_SRCX_REG_B;
			REG_SEQX   = `REG_SEQX_LDA_RDB;
		end
		`MODE_ALU_REG_U4: begin // ALU Ra,U4
			ALUB_SRCX = `ALUB_SRCX_U4;
			REG_SEQX = `REG_SEQX_LDA_IMM;
		end
		`MODE_ALU_REGA_U8: begin // ALU RA,U8
			REGA_ADDRX = `REGA_ADDRX_RA;
			ALUA_SRCX = `ALUA_SRCX_REG_A;
			ALUB_SRCX = `ALUB_SRCX_U8;
			REG_SEQX = `REG_SEQX_LDA_IMM;
		end
		`MODE_ALU_REGA_S8: begin // ALU RA,S8
			REGA_ADDRX = `REGA_ADDRX_RA;
			REGB_ADDRX = `REGB_ADDRX_RB;
			ALUA_SRCX = `ALUA_SRCX_REG_A;
			ALUB_SRCX = `ALUB_SRCX_S8;
			REG_SEQX = `REG_SEQX_LDA_IMM;
		end
	endcase
end

endmodule