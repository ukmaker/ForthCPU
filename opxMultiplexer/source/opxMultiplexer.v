`include "../../constants.v"

/**
* Select the appropriate set of control signals 
* for the current instruction group
**/
module opxMultiplexer(
	
	input CLK,

	input [1:0] INSTRUCTION_GROUP,
	
	input FETCH,
	input EXECUTE,

	
	input [3:0]  ALU_ALU_OPX,
	input [2:0]  ALU_ALUA_SRCX,
	input [2:0]  ALU_ALUB_SRCX,
	input [1:0]  ALU_REGA_ADDRX,
	input         ALU_REGA_EN,
	input [2:0]  ALU_REGB_ADDRX,
	input         ALU_REGB_EN,
	input         ALU_REGA_WEN,
	input         ALU_REGB_WEN,

	input [1:0]  LDS_ADDR_BUSX,
	input [3:0]  LDS_ALU_OPX,
	input [2:0]  LDS_ALUA_SRCX,
	input [2:0]  LDS_ALUB_SRCX,
	input         LDS_BYTEX,	
	input [1:0]  LDS_DATA_BUSX,	
	input [1:0]  LDS_PC_OFFSETX,
	input         LDS_RDX,
	input         LDS_REGA_EN,
	input         LDS_REGA_WEN,
	input [1:0]  LDS_REGA_ADDRX,
	input [1:0]  LDS_REGA_BYTE_ENX,
	input [1:0]  LDS_REGA_DINX,
	input         LDS_REGB_EN,
	input         LDS_REGB_WEN,
	input [2:0]  LDS_REGB_ADDRX,
	input [1:0]  LDS_REGB_BYTE_ENX,
	input         LDS_WRX,

	input [1:0]  JMP_ADDR_BUSX,
	input [2:0]  JMP_ALUB_SRCX,
	input [1:0]  JMP_REGA_ADDRX,
	input [2:0]  JMP_REGB_ADDRX,
	input         JMP_REGA_EN,
	input         JMP_REGA_WEN,
	input         JMP_REGB_EN,
	
	input [1:0]  JMP_PC_BASEX,
	input [1:0]  JMP_PC_OFFSETX,
	
	/*********************************************
	* Combined outputs
	**********************************************/
	output reg [1:0]  ADDR_BUSX,
	output reg [3:0]  ALU_OPX,
	output reg [2:0]  ALUA_SRCX,
	output reg [2:0]  ALUB_SRCX,
	output reg	       BYTEX,
	output reg [1:0]  DATA_BUSX,
	output reg [1:0]  PC_BASEX,
	output reg [1:0]  PC_OFFSETX,
	output reg	       RDX,
	output reg         REGA_EN,
	output reg         REGA_WEN,
	output reg [1:0]  REGA_ADDRX,
	output reg [1:0]  REGA_BYTE_ENX,
	output reg [1:0]  REGA_DINX,
	output reg         REGB_EN,
	output reg         REGB_WEN,
	output reg [2:0]  REGB_ADDRX,
	output reg [1:0]  REGB_BYTE_ENX,
	output reg	       WRX

);

reg [1:0] PC_BASEX_R;
reg [1:0] PC_OFFSETX_R;

always @(*) begin
			
	case(INSTRUCTION_GROUP)
		`GROUP_SYSTEM: begin
			ALU_OPX       = `ALU_OPX_MOV;
			ALUA_SRCX     = `ALUA_SRCX_REG_A;
			ALUB_SRCX     = `ALUB_SRCX_REG_B;
			BYTEX         = `BYTEX_WORD;
			DATA_BUSX     = `DATA_BUSX_REGA_DOUT;
			PC_BASEX_R    = `PC_BASEX_PC_A;
			PC_OFFSETX_R  = `PC_OFFSETX_2;
			RDX           = `RDX_NONE;
			REGA_EN       = `REG_EN_NONE;
			REGA_WEN      = `REG_WEN_NONE;
			REGA_ADDRX    = `REGA_ADDRX_ARGA;
			REGA_BYTE_ENX = `REG_BYTE_ENX_NONE;
			REGA_DINX     = `REGA_DINX_DIN;
			REGB_EN       = `REG_EN_NONE;
			REGB_WEN      = `REG_WEN_NONE;
			REGB_ADDRX    = `REGB_ADDRX_ARGB;
			REGB_BYTE_ENX = `REG_BYTE_ENX_NONE;
			WRX           = `WRX_NONE;
		end
			
		`GROUP_LOAD_STORE: begin
			ALU_OPX       = LDS_ALU_OPX;
			ALUA_SRCX     = LDS_ALUA_SRCX;
			ALUB_SRCX     = LDS_ALUB_SRCX;
			BYTEX         = LDS_BYTEX;
			DATA_BUSX     = LDS_DATA_BUSX;
			PC_BASEX_R    = `PC_BASEX_PC_A;
			PC_OFFSETX_R  = LDS_PC_OFFSETX;
			RDX           = LDS_RDX;
			REGA_EN       = LDS_REGA_EN;
			REGA_WEN      = LDS_REGA_WEN;
			REGA_ADDRX    = LDS_REGA_ADDRX;
			REGA_BYTE_ENX = LDS_REGA_BYTE_ENX;
			REGA_DINX     = LDS_REGA_DINX;
			REGB_EN       = LDS_REGB_EN;
			REGB_WEN      = LDS_REGB_WEN;
			REGB_ADDRX    = LDS_REGB_ADDRX;
			REGB_BYTE_ENX = LDS_REGB_BYTE_ENX;
			WRX           = LDS_WRX;
		end
		
		`GROUP_JUMP: begin
			ALU_OPX       = `ALU_OPX_MOV;
			ALUA_SRCX     = `ALUA_SRCX_REG_A;
			ALUB_SRCX     = JMP_ALUB_SRCX;
			BYTEX         = `BYTEX_WORD;
			DATA_BUSX     = `DATA_BUSX_REGA_DOUT;
			PC_BASEX_R    = JMP_PC_BASEX;
			PC_OFFSETX_R  = JMP_PC_OFFSETX;
			RDX           = `RDX_NONE;
			REGA_EN       = JMP_REGA_EN;
			REGA_WEN      = JMP_REGA_WEN;
			REGA_ADDRX    = JMP_REGA_ADDRX;
			REGA_BYTE_ENX = `REG_BYTE_ENX_BOTH;
			REGA_DINX     = `REGA_DINX_DIN;
			REGB_EN       = JMP_REGB_EN;
			REGB_WEN      = `REG_WEN_NONE;
			REGB_ADDRX    = JMP_REGB_ADDRX;
			REGB_BYTE_ENX = `REG_BYTE_ENX_BOTH;
			WRX           = `WRX_NONE;
		end
		
		`GROUP_ARITHMETIC_LOGIC: begin
			ALU_OPX       = ALU_ALU_OPX;
			ALUA_SRCX     = ALU_ALUA_SRCX;
			ALUB_SRCX     = ALU_ALUB_SRCX;
			BYTEX         = `BYTEX_WORD;
			DATA_BUSX     = `DATA_BUSX_ALU_R;
			PC_BASEX_R    = `PC_BASEX_PC_A;
			PC_OFFSETX_R  = `PC_OFFSETX_2;
			RDX           = `RDX_NONE;
			REGA_EN       = ALU_REGA_EN;
			REGA_WEN      = ALU_REGA_WEN;
			REGA_ADDRX    = ALU_REGA_ADDRX;
			REGA_BYTE_ENX = `REG_BYTE_ENX_BOTH;
			REGA_DINX     = `REGA_DINX_ALU_R;
			REGB_EN       = ALU_REGB_EN;
			REGB_WEN      = ALU_REGB_WEN;
			REGB_ADDRX    = ALU_REGB_ADDRX;
			REGB_BYTE_ENX = `REG_BYTE_ENX_BOTH;
			WRX           = `WRX_NONE;
		end	
endcase
end


always @(posedge CLK) begin
	
	if(FETCH) begin
		
		ADDR_BUSX <= `ADDR_BUSX_PC_A;
		// Always generate the next address for HERE
		PC_BASEX   <= `PC_BASEX_PC_A;
		PC_OFFSETX <= `PC_OFFSETX_2;
		
	end else if(EXECUTE) begin
		
		PC_BASEX   <= PC_BASEX_R;
		PC_OFFSETX <= PC_OFFSETX_R;
		
		case(INSTRUCTION_GROUP)
			`GROUP_SYSTEM: begin
				ADDR_BUSX    <= `ADDR_BUSX_PC_A;
			end
				
			`GROUP_LOAD_STORE: begin
				ADDR_BUSX    <= LDS_ADDR_BUSX;
			end
				
			`GROUP_JUMP:begin
				ADDR_BUSX    <= JMP_ADDR_BUSX;
			end
				
			`GROUP_ARITHMETIC_LOGIC: begin
				ADDR_BUSX    <= `ADDR_BUSX_PC_A;
			end	
		endcase
	end
end
endmodule