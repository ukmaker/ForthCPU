`include "../../constants.v"

/**
* Select the appropriate set of control signals 
* for the current instruction group
**/
module opxMultiplexer(
	
	input CLK,
	input RESET,
	input [15:0] INSTRUCTION,
	
	input FETCH,
	input DECODE,
	input EXECUTE,
	input COMMIT,
	
	input [3:0]  ALU_ALU_OPX,
	input [2:0]  ALU_ALUA_SRCX,
	input [2:0]  ALU_ALUB_SRCX,	input [1:0]  ALU_DATA_BUSX,
	input [1:0]  ALU_REGA_ADDRX,
	input [1:0]  ALU_REGA_DINX,
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

	input [2:0]   JMP_ALUB_SRCX,
	input [1:0]   JMP_REGA_ADDRX,
	input [2:0]   JMP_REGB_ADDRX,
	input          JMP_REGA_EN,
	input          JMP_REGA_WEN,
	input          JMP_REGB_EN,
	
	/*********************************************
	* Combined outputs
	**********************************************/
	output reg [1:0]  ADDR_BUSX,
	output reg [3:0]  ALU_OPX,
	output reg [2:0]  ALUA_SRCX,
	output reg [2:0]  ALUB_SRCX,
	output reg	       BYTEX,
	output reg [1:0]  DATA_BUSX,
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

wire [1:0] GROUPF;

assign GROUPF = INSTRUCTION[15:14];

always @(*) begin
	
	case(GROUPF)
		`GROUP_SYSTEM: begin
			ALU_OPX      = `ALU_OPX_MOV;
			ALUA_SRCX    = `ALUA_SRCX_REG_A;
			ALUB_SRCX    = `ALUB_SRCX_REG_B;
			DATA_BUSX    = `DATA_BUSX_ALU_R;
			DATA_BUS_OEN = 0;
			REGA_EN      = 0;
			REGA_WEN     = 0;
			REGA_ADDRX   = `REGA_ADDRX_ARGA;
			REGA_DINX    = `REGA_DINX_ALU_R;
			REGB_EN      = 0;
			REGB_WEN     = 0;
			REGB_ADDRX   = `REGA_ADDRX_ARGA;
		end
			
		`GROUP_LOAD_STORE: begin
			ALU_OPX      = LDS_ALU_OPX;
			ALUA_SRCX    = LDS_ALUA_SRCX;
			ALUB_SRCX    = LDS_ALUB_SRCX;
			DATA_BUSX    = LDS_DATA_BUSX;
			DATA_BUS_OEN = LDS_DATA_BUS_OEN;
			REGA_EN      = LDS_REGA_EN;
			REGA_WEN     = LDS_REGA_WEN;
			REGA_ADDRX   = LDS_REGA_ADDRX;
			REGA_DINX    = LDS_REGA_DINX;
			REGB_EN      = LDS_REGB_EN;
			REGB_WEN     = LDS_REGB_WEN;
			REGB_ADDRX   = LDS_REGB_ADDRX;
		end
			
		`GROUP_JUMP:begin
			ALU_OPX      = `ALU_OPX_MOV;
			ALUA_SRCX    = `ALUA_SRCX_REG_A;
			ALUB_SRCX    = PCC_ALUB_SRCX;
			DATA_BUSX    = `DATA_BUSX_ALU_R;
			DATA_BUS_OEN = 0;
			REGA_EN      = 0;
			REGA_WEN     = 0;
			REGA_ADDRX   = `REGA_ADDRX_ARGA;
			REGA_DINX    = `REGA_DINX_ALU_R;
			REGB_EN      = 0;
			REGB_WEN     = 0;
			REGB_ADDRX   = PCC_REGB_ADDRX;
		end
			
		`GROUP_ARITHMETIC_LOGIC: begin
			ALU_OPX      = ALU_ALU_OPX;
			ALUA_SRCX    = ALU_ALUA_SRCX;
			ALUB_SRCX    = ALU_ALUB_SRCX;
			DATA_BUSX    = ALU_DATA_BUSX;
			DATA_BUS_OEN = ALU_DATA_BUS_OEN;
			REGA_EN      = ALU_REGA_EN;
			REGA_WEN     = ALU_REGA_WEN;
			REGA_ADDRX   = ALU_REGA_ADDRX;
			REGA_DINX    = ALU_REGA_DINX;
			REGB_EN      = ALU_REGB_EN;
			REGB_WEN     = ALU_REGB_WEN;
			REGB_ADDRX   = ALU_REGB_ADDRX;
		end	
	endcase
end


always @(posedge CLK) begin
	
	if(FETCH) begin
		ADDR_BUSX <= `ADDR_BUSX_PC_A;
	end else begin
		case(GROUPF)
			`GROUP_SYSTEM: begin
				ADDR_BUSX    <= LDS_ADDR_BUSX;
			end
				
			`GROUP_LOAD_STORE: begin
				ADDR_BUSX    <= LDS_ADDR_BUSX;
			end
				
			`GROUP_JUMP:begin
				ADDR_BUSX    <= LDS_ADDR_BUSX;
			end
				
			`GROUP_ARITHMETIC_LOGIC: begin
				ADDR_BUSX    <= ALU_ADDR_BUSX;
			end	
		endcase
	end
end
endmodule