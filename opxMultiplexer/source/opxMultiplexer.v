`include "../../constants.v"

/**
* Select the appropriate set of control signals 
* for the current instruction group
**/
module opxMultiplexer(
	
	input CLK,
	input RESET,

	input [1:0] INSTRUCTION_GROUP,
	
	input FETCH,
	input EXECUTE,

	
	input [3:0]  ALU_ALU_OPX,
	input [2:0]  ALU_ALUA_SRCX,
	input [2:0]  ALU_ALUB_SRCX,
	input         ALU_CCL_LD,
	input [1:0]  ALU_REGA_ADDRX,
	input [2:0]  ALU_REGB_ADDRX,
	input [3:0]  ALU_REG_SEQX,

	input [1:0]  LDS_ADDR_BUSX,
	input [3:0]  LDS_ALU_OPX,
	input [2:0]  LDS_ALUA_SRCX,
	input [2:0]  LDS_ALUB_SRCX,
	input         LDS_BYTEX,	
	input [1:0]  LDS_DATA_BUSX,	
	input [1:0]  LDS_PC_OFFSETX,
	input         LDS_RDX,
	input [3:0]  LDS_REG_SEQX,
	input [1:0]  LDS_REGA_ADDRX,
	input [1:0]  LDS_REGA_DINX,
	input [2:0]  LDS_REGB_ADDRX,
	input         LDS_WRX,

	input [1:0]  JMP_ADDR_BUSX,
	input [2:0]  JMP_ALUB_SRCX,
	input [1:0]  JMP_PC_BASEX,
	input [1:0]  JMP_PC_OFFSETX,
	input         JMP_RDX,
	input [3:0]  JMP_REG_SEQX,
	input [1:0]  JMP_REGA_DINX,
	input [1:0]  JMP_REGA_ADDRX,
	input [2:0]  JMP_REGB_ADDRX,


	
	/*********************************************
	* Combined outputs
	**********************************************/
	output reg [1:0]  ADDR_BUSX,
	output reg [3:0]  ALU_OPX,
	output reg [2:0]  ALUA_SRCX,
	output reg [2:0]  ALUB_SRCX,
	output reg	       BYTEX,
	output reg         CCL_LD,
	output reg [1:0]  DATA_BUSX,
	output reg [1:0]  PC_BASEX,
	output reg [1:0]  PC_OFFSETX,
	output reg	       RDX,
	output reg [1:0]  REGA_ADDRX,
	output reg [1:0]  REGA_DINX,
	output reg [3:0]  REG_SEQX,
	output reg [2:0]  REGB_ADDRX,
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
			CCL_LD        = 0;
			DATA_BUSX     = `DATA_BUSX_REGA_DOUT;
			PC_BASEX_R    = `PC_BASEX_PC_A;
			PC_OFFSETX_R  = `PC_OFFSETX_2;
			RDX           = `RDX_NONE;
			REG_SEQX      = `REG_SEQX_NONE;
			REGA_ADDRX    = `REGA_ADDRX_ARGA;
			REGA_DINX     = `REGA_DINX_DIN;
			REGB_ADDRX    = `REGB_ADDRX_ARGB;
			WRX           = `WRX_NONE;
		end
			
		`GROUP_LOAD_STORE: begin
			ALU_OPX       = LDS_ALU_OPX;
			ALUA_SRCX     = LDS_ALUA_SRCX;
			ALUB_SRCX     = LDS_ALUB_SRCX;
			BYTEX         = LDS_BYTEX;
			CCL_LD        = 0;
			DATA_BUSX     = LDS_DATA_BUSX;
			PC_BASEX_R    = `PC_BASEX_PC_A;
			PC_OFFSETX_R  = LDS_PC_OFFSETX;
			RDX           = LDS_RDX;
			REG_SEQX      = LDS_REG_SEQX;
			REGA_ADDRX    = LDS_REGA_ADDRX;
			REGA_DINX     = LDS_REGA_DINX;
			REGB_ADDRX    = LDS_REGB_ADDRX;
			WRX           = LDS_WRX;
		end
		
		`GROUP_JUMP: begin
			ALU_OPX       = `ALU_OPX_MOV;
			ALUA_SRCX     = `ALUA_SRCX_REG_A;
			ALUB_SRCX     = JMP_ALUB_SRCX;
			BYTEX         = `BYTEX_WORD;
			CCL_LD        = 0;
			DATA_BUSX     = `DATA_BUSX_REGA_DOUT;
			PC_BASEX_R    = JMP_PC_BASEX;
			PC_OFFSETX_R  = JMP_PC_OFFSETX;
			RDX           = JMP_RDX;
			REG_SEQX      = JMP_REG_SEQX;
			REGA_ADDRX    = JMP_REGA_ADDRX;
			REGA_DINX     = JMP_REGA_DINX;
			REGB_ADDRX    = JMP_REGB_ADDRX;
			WRX           = `WRX_NONE;
		end
		
		`GROUP_ARITHMETIC_LOGIC: begin
			ALU_OPX       = ALU_ALU_OPX;
			ALUA_SRCX     = ALU_ALUA_SRCX;
			ALUB_SRCX     = ALU_ALUB_SRCX;
			BYTEX         = `BYTEX_WORD;
			CCL_LD        = ALU_CCL_LD;
			DATA_BUSX     = `DATA_BUSX_ALU_R;
			PC_BASEX_R    = `PC_BASEX_PC_A;
			PC_OFFSETX_R  = `PC_OFFSETX_2;
			RDX           = `RDX_NONE;
			REG_SEQX      = ALU_REG_SEQX;
			REGA_ADDRX    = ALU_REGA_ADDRX;
			REGA_DINX     = `REGA_DINX_ALU_R;
			REGB_ADDRX    = ALU_REGB_ADDRX;
			WRX           = `WRX_NONE;
		end	
endcase
end


always @(posedge CLK or posedge RESET) begin
	
	if(RESET | FETCH) begin
		
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