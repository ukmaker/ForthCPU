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
	output reg REGA_EN,
	output reg REGB_EN,
	output reg REGA_WEN,
	output reg REGB_WEN,
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
wire [1:0] GROUPX;

assign GROUPX  = INSTRUCTION[15:14];
assign ALU_OPX = INSTRUCTION[13:10];
assign ARGF    = INSTRUCTION[9:8];
assign ARGA_X  = INSTRUCTION[7:4];
assign ARGB_X  = INSTRUCTION[3:0];

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
	
	//if(GROUPX == `GROUP_ARITHMETIC_LOGIC) begin
		case(ARGF) 
			`MODE_ALU_REG_REG: begin // ALU Ra,Rb
				ALUB_SRCX = `ALUB_SRCX_REG_B;
				RD_A = 1; RD_B = 1; WR_A = 1;
			end
			`MODE_ALU_REG_U4: begin // ALU Ra,U4
				ALUB_SRCX = `ALUB_SRCX_U4;
				RD_A = 1; WR_A = 1;
			end
			`MODE_ALU_REGA_U8: begin // ALU RA,U8
				REGA_ADDRX = `REGA_ADDRX_RA;
				ALUA_SRCX = `ALUA_SRCX_REG_A;
				ALUB_SRCX = `ALUB_SRCX_U8;
				RD_A = 1; WR_A = 1; RD_B = 0;
			end
			`MODE_ALU_REGA_S8: begin // ALU RA,S8
				REGA_ADDRX = `REGA_ADDRX_RA;
				REGB_ADDRX = `REGB_ADDRX_RB;
				ALUA_SRCX = `ALUA_SRCX_REG_A;
				ALUB_SRCX = `ALUB_SRCX_S8;
				RD_A = 1; RD_B = 1; WR_A = 1;
			end
		endcase
	//end
end

always @(posedge CLK) begin
	
	if(FETCH) begin
		CCL_LD <= 0;
		REGA_EN <= 0;
		REGB_EN <= 0;
		REGA_WEN <= 0; 
		REGB_WEN <= 0;		
	end 
	if(GROUPX == `GROUP_ARITHMETIC_LOGIC) begin
		if(DECODE) begin
			REGA_EN <= RD_A;
			REGB_EN <= RD_B;
			REGA_WEN <= 0;
			REGB_WEN <= 0;
		end else if(EXECUTE) begin
			REGA_EN <= RD_A;
			REGB_EN <= RD_B;
			REGA_WEN <= 0;
			REGB_WEN <= 0;
		end else if(COMMIT) begin
			if(ALU_OPX != `ALU_OPX_MOV) begin
				CCL_LD <= 1;
			end
			REGA_EN <= WR_A;
			REGB_EN <= WR_B;
			REGA_WEN <= WR_A;
			REGB_WEN <= WR_B;
		end
	end
end



endmodule