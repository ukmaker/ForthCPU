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
	input [13:8] INSTRUCTION,
	
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
	* Bus control
	**/
	output reg [1:0] DATA_BUSX,
	output reg        RDX,
	output reg        WRX,
	output reg        BYTEX,
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

reg RD_A, RD_B, WR_A, WR_B, RD_M, WR_M, BYTE_OP;

// Combinational logic
// Setup the data sources
always @(*) begin
	
	ALUA_SRCX = `ALUA_SRCX_REG_A;
	ALUB_SRCX = `ALUB_SRCX_REG_B;
	RD_A = 0; RD_B = 0; WR_A = 0; WR_B = 0;
	RD_M = 0; WR_M = 0; BYTE_OP = 0;
	ALU_OPX = `ALU_OPX_ADD;
	ADDR_BUSX = 0;
	DATA_BUSX = 0;
	REGA_DINX  = `REGA_DINX_ALU_R;
	REGA_ADDRX = `REGA_ADDRX_ARGA;
	REGB_ADDRX = `REGB_ADDRX_ARGB;
	REGA_BYTE_ENX = 2'b11;
	REGB_BYTE_ENX = 2'b11;
	
	// What operation is this?
	case(LDSF) 
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
		`MODE_LDS_REG_MEM: begin // LD x,(y) ; LD_B ; ST ; ST_B

			// Do we need the incrementer?
			case(INCF)
				`LDSINCF_PRE_DEC: begin
					// Address from the ALU
					ADDR_BUSX = `ADDR_BUSX_ALU_R;
					// After the adder
					ALUA_SRCX = `ALUA_SRCX_MINUS_TWO;
					// write the address back to PortB
					WR_B = 1;
					// Operation is -2
					ALU_OPX = `ALU_OPX_ADD;
				end
				`LDSINCF_POST_INC: begin
					// Address from the register
					ADDR_BUSX = `ADDR_BUSX_ALUB_DATA;
					// Before the adder
					ALUA_SRCX = `ALUA_SRCX_TWO;
					// write the address back to PortB
					WR_B = 1;
					// Operation is +2
					ALU_OPX = `ALU_OPX_ADD;
				end
				default: begin
					// Address from the register
					ADDR_BUSX = `ADDR_BUSX_ALUB_DATA;
					// Before the adder
					ALUA_SRCX = `ALUA_SRCX_ZERO;
					// No writeback
				end
			endcase
		end
		`MODE_LDS_REG_FRAME: begin // LD x,(FP + S6)
			// No inc/dec in this mode.
			// Those bits are used for S6[5:4]
			REGB_ADDRX = `REGB_ADDRX_RFP;
			// Address from the ALU
			ADDR_BUSX = `ADDR_BUSX_ALU_R;
			// ALU adds
			ALU_OPX = `ALU_OPX_ADD;
			// S6
			if(LDSF == `LDSOPF_LD || LDSF == `LDSOPF_ST) begin
				// word address
				ALUA_SRCX = `ALUA_SRCX_S6_0;
			end else begin
				// byte address
				ALUA_SRCX = `ALUA_SRCX_S6;
			end
			// To REGB
			ALUB_SRCX = `ALUB_SRCX_REG_B;		
		end
		`MODE_LDS_REG_STACK: begin // LD x,(SP + U6)
			// No inc/dec in this mode.
			// Those bits are used for S6[5:4]
			REGB_ADDRX = `REGB_ADDRX_RSP;
			// Address from the ALU
			ADDR_BUSX = `ADDR_BUSX_ALU_R;
			// ALU adds
			ALU_OPX = `ALU_OPX_ADD;
			// S6
			if(LDSF == `LDSOPF_LD || LDSF == `LDSOPF_ST) begin
				// word address
				ALUA_SRCX = `ALUA_SRCX_S6_0;
			end else begin
				// byte address
				ALUA_SRCX = `ALUA_SRCX_S6;
			end
			// To REGB
			ALUB_SRCX = `ALUB_SRCX_REG_B;		
		end
		`MODE_LDS_REG_RETSTACK: begin // LD x,(RS + S6)
			// No inc/dec in this mode.
			// Those bits are used for S6[5:4]
			REGB_ADDRX = `REGB_ADDRX_RRS;
			// Address from the ALU
			ADDR_BUSX = `ADDR_BUSX_ALU_R;
			// ALU adds
			ALU_OPX = `ALU_OPX_ADD;
			// S6
			if(LDSF == `LDSOPF_LD || LDSF == `LDSOPF_ST) begin
				// word address
				ALUA_SRCX = `ALUA_SRCX_S6_0;
			end else begin
				// byte address
				ALUA_SRCX = `ALUA_SRCX_S6;
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
		
		if(DECODE) begin
			REGA_EN <= WR_A | RD_A;
			REGB_EN <= WR_B | RD_B;
			RDX <= RD_M;
			BYTEX <= BYTE_OP;
		end else if(EXECUTE) begin
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