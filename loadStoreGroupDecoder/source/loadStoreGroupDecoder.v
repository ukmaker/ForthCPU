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
*  GPF   SRCF  LDSF  MODEF    ARGA        ARGB
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
*  SRCF  - Load/store source field
*  LDSF  - Load/store operation field
*  MODEF - Addressing mode field
*  SKIPF - Condition handling field
*  CCF   - Condition code select field
*  JPF   - Jump type field
*  ALUF  - ALU operation field
*  ARGF  - ALU argument type field
*
* MODEF  LDSF  INCF/SRCF
*  00     00    xx        LD Ra,(Rb)      ; LD Ra,(Rb++)    ; LD Ra,(--Rb)
*  01     00    xx        LD Ra,(FP-U6.0)
*  10     00    xx        LD Ra,(SP+U6.0)
*  11     00    xx        LD Ra,(RS+U6.0)

*  00     01    xx        LD_B Ra,(Rb)    ; LD_B Ra,(Rb++)    ; LD_B Ra,(--Rb)
*  01     01    xx        LD_B Ra,(FP-U6)
*  10     01    xx        LD_B Ra,(SP+U6)
*  11     01    xx        LD_B Ra,(RS+U6)

*  00     10    xx        ST Ra,(Rb)      ; ST Ra,(Rb++)      ; ST Ra,(--Rb)
*  01     10    xx        ST Ra,(FP-U6.0)
*  10     10    xx        ST Ra,(SP+U6.0)
*  11     10    xx        ST Ra,(RS+U6.0)

*  00     11    xx        ST_B Ra,(Rb)    ; ST_B Ra,(Rb++)    ; ST_B Ra,(--Rb)
*  01     11    xx        ST_B Ra,(FP-U6)
*  10     11    xx        ST_B Ra,(SP+U6)
*  11     11    xx        ST_B Ra,(RS+U6)

*
*/

`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module loadStoreGroupDecoder(
	
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
	
	/**
	* ALU
	**/
	output reg [3:0] ALU_OPX,        // ALU operation
	output reg       ALU_LD,
	output reg [1:0] ALUA_CONSTX,

	/**
	* Data Sources
	**/
	output reg [1:0] ALUA_SRCX,
	output reg [2:0] ALUB_SRCX,
	
	output reg [1:0] REGA_DINX,
	output reg [2:0] REGA_ADDRX,
	output reg [1:0] REGB_ADDRX,
	
	/**
	* Bus control
	**/
	output reg [1:0] DATA_BUSX,
	output reg       DATA_BUS_OEN,
	output reg [1:0] ADDR_BUSX
);
     
wire [1:0] INCF;
wire [1:0] LDSF;
wire [1:0] MODEF;
wire [3:0] ARGA;
wire [3:0] ARGB;

assign INCF = INSTRUCTION[13:12];
assign LDSF = INSTRUCTION[11:10];
assign MODEF = INSTRUCTION[9:8];
assign ARGA = INSTRUCTION[7:4];
assign ARGB = INSTRUCTION[3:0];

reg RD_A, RD_B, WR_A, WR_B, RD_M, WR_M;

// Combinational logic
// Setup the data sources
always @(*) begin
	
	REGA_EN = 0;
	REGB_EN = 0;
	REGA_WEN = 0; 
	REGB_WEN = 0;
	ALUA_SRCX = `ALUA_SRCX_REG_A;
	ALUB_SRCX = `ALUB_SRCX_REG_B;
	RD_A = 0; RD_B = 0; WR_A = 0; WR_B = 0;
	RD_M = 0; WR_M = 0;
	ALU_OPX = `ALU_OPX_MOV;
	ALU_LD = 0;
	ALUA_CONSTX = `ALUA_CONSTX_TWO;
	ADDR_BUSX = 0;
	DATA_BUSX = 0;
	DATA_BUS_OEN = 0;
	REGA_ADDRX = `REGA_ADDRX_ARGA;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	REGA_DINX = `REGA_DINX_ALUA_PP;
	
	// What operation is this?
	case(LDSF) 
		`LDS_LD: begin // LD x,(y) : NB x is ARGB, y is ARGA
			WR_B = 1;
			RD_A = 1;
			RD_M = 1;
		end
		`LDS_LDB: begin // LD x,(y) : NB x is ARGB, y is ARGA
			WR_B = 1;
			RD_A = 1;
			RD_M = 1;
		end
		`LDS_ST: begin // ST (x),y : NB x is ARGA, y is ARGB
			RD_A = 1;
			RD_B = 1;
			WR_M = 1;
		end
		`LDS_STB: begin // ST_B (x),y : NB x is ARGA, y is ARGB
			RD_A = 1;
			RD_B = 1;
			WR_M = 1;
		end
	endcase
			
	case(MODEF)
		`MODE_REG_REG: begin // LD x,(y) ; LD_B ; ST ; ST_B

			// Do we need the incrementer?
			case(INCF)
				`LDSF_PRE_DEC: begin
					// Address from the incrementer
					ADDR_BUSX = `ADDR_BUSX_ALUA_DIN;
					// After the adder
					ALUA_SRCX = `ALUA_SRCX_INCREMENTER;
					// write the address back to PortA
					WR_A = 1;
					REGA_DINX = `REGA_DINX_ALUA_PP;
					// Operation is -2
					ALUA_CONSTX = `ALUA_CONSTX_MINUS_TWO;
				end
				`LDSF_POST_INC: begin
					// Address from the incrementer
					ADDR_BUSX = `ADDR_BUSX_ALUA_DIN;
					// Before the adder
					ALUA_SRCX = `ALUA_SRCX_REG_A;
					// write the address back to PortA
					WR_A = 1;
					REGA_DINX = `REGA_DINX_ALUA_PP;
					// Operation is -2
					ALUA_CONSTX = `ALUA_CONSTX_TWO;
				end
				default: begin
					// Address from the incrementer
					ADDR_BUSX = `ADDR_BUSX_ALUA_DIN;
					// Before the adder
					ALUA_SRCX = `ALUA_SRCX_REG_A;
					// No writeback
				end
			endcase
		end
		`MODE_REG_FRAME: begin // LD x,(FP - U6)
			// No inc/dec in this mode.
			// Those bits are used for U6[5:4]
			REGA_ADDRX = `REGA_ADDRX_RFP;
			// Address from the ALU
			ADDR_BUSX = `ADDR_BUSX_ALU_R;
			// ALU adds
			ALU_OPX = `ALU_OPX_SUB;
			ALU_LD = 1;
			// U6
			if(LDSF == `LDS_LD || LDSF == `LDS_ST) begin
				// word address
				ALUB_SRCX = `ALUB_SRCX_ARG_U6_0;
			end else begin
				// byte address
				ALUB_SRCX = `ALUB_SRCX_ARG_U6;
			end
			// To REGA
			ALUA_SRCX = `ALUA_SRCX_REG_A;		
		end
		`MODE_REG_STACK: begin // LD x,(FP - U6)
			// No inc/dec in this mode.
			// Those bits are used for U6[5:4]
			REGA_ADDRX = `REGA_ADDRX_RSP;
			// Address from the ALU
			ADDR_BUSX = `ADDR_BUSX_ALU_R;
			// ALU adds
			ALU_OPX = `ALU_OPX_ADD;
			ALU_LD = 1;
			// U6
			if(LDSF == `LDS_LD || LDSF == `LDS_ST) begin
				// word address
				ALUB_SRCX = `ALUB_SRCX_ARG_U6_0;
			end else begin
				// byte address
				ALUB_SRCX = `ALUB_SRCX_ARG_U6;
			end
			// To REGA
			ALUA_SRCX = `ALUA_SRCX_REG_A;		
		end
		`MODE_REG_RETSTACK: begin // LD x,(FP - U6)
			// No inc/dec in this mode.
			// Those bits are used for U6[5:4]
			REGA_ADDRX = `REGA_ADDRX_RRS;
			// Address from the ALU
			ADDR_BUSX = `ADDR_BUSX_ALU_R;
			// ALU adds
			ALU_OPX = `ALU_OPX_ADD;
			ALU_LD = 1;
			// U6
			if(LDSF == `LDS_LD || LDSF == `LDS_ST) begin
				// word address
				ALUB_SRCX = `ALUB_SRCX_ARG_U6_0;
			end else begin
				// byte address
				ALUB_SRCX = `ALUB_SRCX_ARG_U6;
			end
			// To REGA
			ALUA_SRCX = `ALUA_SRCX_REG_A;		
		end
	endcase
end

always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
		REGA_EN <= 0;
		REGB_EN <= 0;
		REGA_WEN <= 0;
		REGB_WEN <= 0;	
	end else begin
		
		if(EXECUTE) begin
			REGA_EN <= RD_A;
			REGB_EN <= RD_B;
		end else if(COMMIT) begin
			REGA_EN <= WR_A;
			REGB_EN <= WR_B;
			REGA_WEN <= WR_A;
			REGB_WEN <= WR_B;
		end else begin
			REGA_EN <= 0;
			REGB_EN <= 0;
			REGA_WEN <= 0;
			REGB_WEN <= 0;
		end
	end
	
end

endmodule