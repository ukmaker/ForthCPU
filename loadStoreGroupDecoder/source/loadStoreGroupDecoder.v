/**
* Instruction formats
* 
*  F  E  D  C  B  A  9  8  7  6  5  4  3  2  1  0
*  0  0  ----------  X  X  ----------  ----------  Group 0: System
*  GPF      SYSF              ARGA        ARGB
*              
*              
*  0  1  -- ----  -------  ----------  ----------  Group 1: Load/Store
*  GPF   U5  OPF   MODEF       ARGA        ARGB
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
*  SRCF  - Load/store source field
*  OPF   - Load/store operation field
*  MODEF - Addressing mode field
*  SKIPF - Condition handling field
*  CCF   - Condition code select field
*  JPF   - Jump type field
*  ALUF  - ALU operation field
*  ARGF  - ALU argument type field
*
* MODEF  OPF
* 000    00     LD Ra,(Rb)
* 001    00     LD Ra,(HERE)
* 010    00     LD Ra,(Rb++)  // LSB of Rb ignored. ++2
* 011    00     LD Ra,(--Rb)  // LSB of Rb ignored. 2--
* 
* 100    00     LD Ra,(RB+U5.0) // Word addressing
* 101    00     LD Ra,(FP-U5.0)
* 110    00     LD Ra,(SP+U5.0)
* 111    00     LD Ra,(RS+U5.0)
*
* 000    01     LD_B Ra,(Rb)
* 001    01     LD_B Ra,(HERE)
* 010    01     LD_B Ra,(Rb++)
* 011    01     LD_B Ra,(--Rb)
* 
* 100    01     LD_B Ra,(RB+U5) // Byte addressing
* 101    01     LD_B Ra,(FP-U5)
* 110    01     LD_B Ra,(SP+U5)
* 111    01     LD_B Ra,(RS+U5)
*
* 000    00     ST Ra,(Rb)
* 001    00     ST Ra,(HERE)  // NOP
* 010    00     ST Ra,(Rb++)  // LSB of Rb ignored. ++2
* 011    00     ST Ra,(--Rb)  // LSB of Rb ignored. 2--
* 
* 100    00     ST Ra,(RB+U5.0) // Word addressing
* 101    00     ST Ra,(FP-U5.0)
* 110    00     ST Ra,(SP+U5.0)
* 111    00     ST Ra,(RS+U5.0)
*
* 000    01     ST_B Ra,(Rb)
* 001    01     ST_B Ra,(HERE)  // NOP
* 010    01     ST_B Ra,(Rb++)
* 011    01     ST_B Ra,(--Rb)
* 
* 100    01     ST_B Ra,(RB+U5) // Byte addressing
* 101    01     ST_B Ra,(FP-U5)
* 110    01     ST_B Ra,(SP+U5)
* 111    01     ST_B Ra,(RS+U5)

*
*/

`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module loadStoreGroupDecoder(
	
	input CLK,
	input RESET,
	
	input [1:0] OPF,
	input [2:0] MODEF,

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

	/**
	* Data Sources
	**/
	output reg [2:0] ALUA_SRCX,
	output reg [2:0] ALUB_SRCX,
	
	output reg [1:0] REGA_DINX,
	output reg [1:0] REGA_ADDRX,
	output reg [2:0] REGB_ADDRX,
	output reg [1:0] REGA_BYTE_ENX,
	output reg [1:0] REGB_BYTE_ENX,
	
	/**
	* Program counter
	**/
	output reg [1:0] PC_OFFSETX,
	
	/**
	* Bus control
	**/
	output reg [1:0] DATA_BUSX,
	output reg        RDX,
	output reg        WRX,
	output reg        BYTEX,
	output reg [1:0] ADDR_BUSX
);

reg RD_A, RD_B, WR_A, WR_B, RD_M, WR_M, BYTE_OP;

// Combinational logic
// Setup the data sources
always @(*) begin
	
	ALUA_SRCX = `ALUA_SRCX_REG_A;
	ALUB_SRCX = `ALUB_SRCX_REG_B;
	RD_A = 0; RD_B = 0; WR_A = 0; WR_B = 0;
	RD_M = 0; WR_M = 0; BYTE_OP = 0;
	ALU_OPX       = `ALU_OPX_ADD;
	ADDR_BUSX     = 0;
	DATA_BUSX     = 0;
	REGA_DINX     = `REGA_DINX_DIN;
	REGA_ADDRX    = `REGA_ADDRX_ARGA;
	REGB_ADDRX    = `REGB_ADDRX_ARGB;
	REGA_BYTE_ENX = 2'b11;
	REGB_BYTE_ENX = 2'b11;
	PC_OFFSETX    = `PC_OFFSETX_2;
	
	// What operation is this?
	case(OPF) 
		`LDSOPF_LD: begin // LD Ra,(Rb) 
			WR_A = 1;
			RD_B = 1;
			RD_M = 1;
		end
		`LDSOPF_LDB: begin // LD_B x,(y)
			WR_A = 1;
			RD_B = 1;
			RD_M = 1;
			BYTE_OP = 1;
			REGA_DINX  = `REGA_DINX_BYTE;
		end
		`LDSOPF_ST: begin // ST (Ra),Rb
			RD_A = 1;
			RD_B = 1;
			WR_M = 1;
			DATA_BUSX = `DATA_BUSX_REGA_DOUT;
		end
		`LDSOPF_STB: begin // ST_B (Ra),Rb
			RD_A = 1;
			RD_B = 1;
			WR_M = 1;
			DATA_BUSX = `DATA_BUSX_REGA_DOUT;
			BYTE_OP = 1;
		end
	endcase
			
	case(MODEF)
		`MODE_LDS_REG_REG: begin // LD x,(y) ; LD_B ; ST ; ST_B
			// Address from the register
			ADDR_BUSX = `ADDR_BUSX_ALUB_DATA;
			// Before the adder
			ALUA_SRCX = `ALUA_SRCX_ZERO;
			// No writeback
		end
		
		`MODE_LDS_REG_HERE: begin
			// Address from the register
			ADDR_BUSX = `ADDR_BUSX_HERE;
			// Before the adder
			ALUA_SRCX = `ALUA_SRCX_ZERO;
			// No writeback
			PC_OFFSETX    = `PC_OFFSETX_4;
		end
		
		`MODE_LDS_REG_REG_INC: begin
			// Address from the register
			ADDR_BUSX = `ADDR_BUSX_ALUB_DATA;
			// Before the adder
			ALUA_SRCX = BYTE_OP ? `ALUA_SRCX_ONE : `ALUA_SRCX_TWO;
			ALUB_SRCX = `ALUB_SRCX_REG_B;
			// write the address back to PortB
			WR_B = 1;
			// Operation is +2
			ALU_OPX = `ALU_OPX_ADD;
		end
		
		`MODE_LDS_REG_REG_DEC: begin
			// Address from the ALU
			ADDR_BUSX = `ADDR_BUSX_ALU_R;
			// After the adder
			ALUA_SRCX = BYTE_OP ? `ALUA_SRCX_MINUS_ONE : `ALUA_SRCX_MINUS_TWO;
			ALUB_SRCX = `ALUB_SRCX_REG_B;
			// write the address back to PortB
			WR_B = 1;
			// Operation is -2
			ALU_OPX = `ALU_OPX_ADD;
		end
		
		`MODE_LDS_REG_RB: begin // LD x,(RB + U5)
			REGB_ADDRX = `REGB_ADDRX_RB;
			// Address from the ALU
			ADDR_BUSX = `ADDR_BUSX_ALU_R;
			// ALU adds
			ALU_OPX = `ALU_OPX_ADD;
			// S5
			if(OPF == `LDSOPF_LD || OPF == `LDSOPF_ST) begin
				// word address
				ALUA_SRCX = `ALUA_SRCX_U5_0;
			end else begin
				// byte address
				ALUA_SRCX = `ALUA_SRCX_U5;
			end
			// To REGB
			ALUB_SRCX = `ALUB_SRCX_REG_B;		
		end
		
		`MODE_LDS_REG_FP: begin // LD x,(FP + U5)
			REGB_ADDRX = `REGB_ADDRX_RFP;
			// Address from the ALU
			ADDR_BUSX = `ADDR_BUSX_ALU_R;
			// ALU adds
			ALU_OPX = `ALU_OPX_ADD;
			// U5
			if(OPF == `LDSOPF_LD || OPF == `LDSOPF_ST) begin
				// word address
				ALUA_SRCX = `ALUA_SRCX_U5_0;
			end else begin
				// byte address
				ALUA_SRCX = `ALUA_SRCX_U5;
			end
			// To REGB
			ALUB_SRCX = `ALUB_SRCX_REG_B;		
		end
		
		`MODE_LDS_REG_SP: begin // LD x,(SP + U5)
			REGB_ADDRX = `REGB_ADDRX_RSP;
			// Address from the ALU
			ADDR_BUSX = `ADDR_BUSX_ALU_R;
			// ALU adds
			ALU_OPX = `ALU_OPX_ADD;
			// U5
			if(OPF == `LDSOPF_LD || OPF == `LDSOPF_ST) begin
				// word address
				ALUA_SRCX = `ALUA_SRCX_U5_0;
			end else begin
				// byte address
				ALUA_SRCX = `ALUA_SRCX_U5;
			end
			// To REGB
			ALUB_SRCX = `ALUB_SRCX_REG_B;		
		end
		`MODE_LDS_REG_RS: begin // LD x,(RS + U5)
			REGB_ADDRX = `REGB_ADDRX_RRS;
			// Address from the ALU
			ADDR_BUSX = `ADDR_BUSX_ALU_R;
			// ALU adds
			ALU_OPX = `ALU_OPX_ADD;
			// U5
			if(OPF == `LDSOPF_LD || OPF == `LDSOPF_ST) begin
				// word address
				ALUA_SRCX = `ALUA_SRCX_U5_0;
			end else begin
				// byte address
				ALUA_SRCX = `ALUA_SRCX_U5;
			end
			// To REGB
			ALUB_SRCX = `ALUB_SRCX_REG_B;		
		end
	endcase
end

always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
		REGA_EN <= 0;
		REGB_EN <= 0;
		REGA_WEN <= 0;
		REGB_WEN <= 0;	
		RDX <= 0;
		WRX <= 0;
		BYTEX <= 0;
	end else begin
		
		//if(DECODE) begin
		//	REGA_EN <= WR_A | RD_A;
		//	REGB_EN <= WR_B | RD_B;
		//	RDX <= RD_M;
		//	BYTEX <= BYTE_OP;
		//end else 
		if(EXECUTE) begin
			REGA_EN <= WR_A | RD_A;
			REGB_EN <= WR_B | RD_B;
			RDX <= RD_M;
			BYTEX <= BYTE_OP;
			WRX <= WR_M;
		end else if(COMMIT) begin
			REGA_EN <= WR_A | RD_A;
			REGB_EN <= WR_B | RD_B;
			RDX <= RD_M;
			BYTEX <= BYTE_OP;
			WRX <= 0;
			REGA_WEN <= WR_A;
			REGB_WEN <= WR_B;
		end else begin
			REGA_EN <= 0;
			REGB_EN <= 0;
			REGA_WEN <= 0;
			REGB_WEN <= 0;
			RDX <= 0;
			WRX <= 0;
			BYTEX <= 0;
		end
	end
	
end

endmodule