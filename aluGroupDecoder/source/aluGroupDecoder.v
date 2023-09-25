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
	input [15:0] INSTRUCTION,
	
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
	output reg REGA_CLKEN,
	output reg REGB_CLKEN,
	output reg REGA_WEN,
	output reg REGB_WEN,
	
	/**
	* ALU
	**/
	output wire [3:0] ALU_OPX,        // ALU operation
	output reg       ALU_LD,
	output reg       CCL_LD,
	
	/**
	* Data Sources
	**/
	output reg        ALUA_SRCX,
	output reg [1:0] ALUA_CONSTX,
	
	output reg [2:0] ALUB_SRCX,
	
	/**
	* Arguments
	**/
	output wire [3:0] ARGA_X,
	output wire [3:0] ARGB_X,
	
	output reg [2:0] REGA_ADDRX,
	output reg [1:0] REGB_ADDRX

);

wire [1:0] ARGF;

assign ALU_OPX = INSTRUCTION[13:10];
assign ARGF = INSTRUCTION[9:8];
assign ARGA_X = INSTRUCTION[7:4];
assign ARGB_X = INSTRUCTION[3:0];

reg RD_A, RD_B, WR_A, WR_B;

// Combinational logic
// Setup the data sources
always @(*) 
begin

	ALUA_SRCX = `ALUA_SRCX_REG_A;
	ALUB_SRCX = `ALUB_SRCX_REG_B;
	RD_A = 0; RD_B = 0; WR_A = 0; WR_B = 0;
	REGA_ADDRX = `REGA_ADDRX_ARGA;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	
	case(ARGF) 
		`MODE_REG_REG: begin // ALU Ra,Rb
			ALUB_SRCX = `ALUB_SRCX_REG_B;
			RD_A = 1; RD_B = 1; WR_A = 1;
		end
		`MODE_REG_U4: begin // ALU Ra,U4
			ALUB_SRCX = `ALUB_SRCX_ARG_U4;
			RD_A = 1; WR_A = 1;
		end
		`MODE_REGB_U8: begin // ALU RB,U8
			REGA_ADDRX = `REGA_ADDRX_RB;
			ALUB_SRCX = `ALUB_SRCX_ARG_U8;
			RD_A = 1; WR_A = 1;
		end
		`MODE_REGA_U8RB: begin // ALU RA,U8.RB
			REGA_ADDRX = `REGA_ADDRX_RA;
			REGB_ADDRX = `REGB_ADDRX_RB;
			ALUB_SRCX = `ALUB_SRCX_U8_REG_B;
			RD_A = 1; RD_B = 1; WR_A = 1;
		end
	endcase
end

always @(posedge CLK) begin
	

	
	if(FETCH) begin
		ALU_LD = 0;
		CCL_LD = 0;
		REGA_CLKEN = 0;
		REGB_CLKEN = 0;
		REGA_WEN = 0; 
		REGB_WEN = 0;
		ALUA_CONSTX = `ALUA_CONSTX_ONE;		
	end else if(DECODE) begin
		REGA_CLKEN <= RD_A;
		REGB_CLKEN <= RD_B;
		REGA_WEN <= 0;
		REGB_WEN <= 0;
	end else if(EXECUTE) begin
		REGA_CLKEN <= WR_A;
		REGB_CLKEN <= WR_B;
		REGA_WEN <= WR_A;
		REGB_WEN <= WR_B;
		if(ALU_OPX != `ALU_OPX_MOV) begin
			ALU_LD <= 1;
			CCL_LD <= 1;
		end
	end else if(COMMIT) begin
		REGA_CLKEN <= 0;
		REGB_CLKEN <= 0;
		REGA_WEN <= 0;
		REGB_WEN <= 0;
		ALU_LD <= 0;
		CCL_LD <= 0;
	end
	
end



endmodule