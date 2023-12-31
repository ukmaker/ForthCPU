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
	input [5:0] ALU_INSTRUCTION,
	
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
	output reg [3:0] REG_SEQX,
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
	output reg [2:0] ALUB_SRCX

);

wire [1:0] ARGF;
reg  [3:0] REGA_OP;
reg         IMM;

assign ALU_OPX = ALU_INSTRUCTION[5:2];
assign ARGF    = ALU_INSTRUCTION[1:0];

// Combinational logic
// Setup the data sources
always @(*) 
begin

	ALUA_SRCX  = `ALUA_SRCX_REG_A;
	ALUB_SRCX  = `ALUB_SRCX_REG_B;
	REG_SEQX   = `REG_SEQX_NONE;
	REGA_ADDRX = `REGA_ADDRX_ARGA;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	
	CCL_LD  = ALU_OPX != `ALU_OPX_MOV;
	IMM     = ARGF    != `MODE_ALU_REG_REG;
	
	if(ALU_OPX == `ALU_OPX_CMP || ALU_OPX == `ALU_OPX_BIT) begin
		
		REG_SEQX = IMM ? `REG_SEQX_RDA_IMM : `REG_SEQX_RDA_RDB;
		
	end else if(ALU_OPX == `ALU_OPX_MOV) begin
		
		REG_SEQX = IMM ? `REG_SEQX_LDA_IMM : `REG_SEQX_LDA_RDB;
		
	end else begin
		
		REG_SEQX = IMM ? `REG_SEQX_UPA_IMM : `REG_SEQX_UPA_RDB;
		
	end
	
	

	case(ARGF) 
		`MODE_ALU_REG_REG: begin // ALU Ra,Rb
			ALUB_SRCX  = `ALUB_SRCX_REG_B;	
		end
		`MODE_ALU_REG_U4: begin // ALU Ra,U4
			ALUB_SRCX  = `ALUB_SRCX_U4;
		end
		`MODE_ALU_REGA_U8: begin // ALU RA,U8
			REGA_ADDRX = `REGA_ADDRX_RA;
			ALUA_SRCX  = `ALUA_SRCX_REG_A;
			ALUB_SRCX  = `ALUB_SRCX_U8;
		end
		`MODE_ALU_REGA_S8: begin // ALU RA,S8
			REGA_ADDRX = `REGA_ADDRX_RA;
			REGB_ADDRX = `REGB_ADDRX_RB;
			ALUA_SRCX  = `ALUA_SRCX_REG_A;
			ALUB_SRCX  = `ALUB_SRCX_S8;
		end
	endcase
end

endmodule