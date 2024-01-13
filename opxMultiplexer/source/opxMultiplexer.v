`include "../../constants.v"

/**
* Select the appropriate set of control signals 
* for the current instruction group
*
*                     +--------------------+
*	                  |                    |
*	GROUPX      ----->|                    |
*                     |                    |
*                     |                    |
*                     |                    |
*   DEBUG_OPX   ----->|                    |-----> ALU_OPX
*   ALU_OPX     ----->|                    |
*   INT_OPX     ----->|                    |-----> PC_OPX
*   JMP_OPX     ----->|                    |
*   LDS_OPX     ----->|                    |-----> REG_SEQX
*                     |                    |
*   CLK         ----->|                    |-----> BUS_SEQX
*   PHI         ----->|                    |
*                     |                    |-----> DATA_BUSX
*                     +--------------------+
*
**/
module opxMultiplexer(

	input [2:0] INSTRUCTION_GROUP,
		
	input [3:0]  ALU_ALU_OPX,
	input [2:0]  ALU_ALUA_SRCX,
	input [2:0]  ALU_ALUB_SRCX,
	input         ALU_CCL_LD,
	input [1:0]  ALU_REGA_ADDRX,
	input [2:0]  ALU_REGB_ADDRX,
	input [3:0]  ALU_REG_SEQX,
	
	input [2:0]  DEBUG_ADDR_BUSX,
	input [1:0]  DEBUG_BUS_SEQX,
	input [1:0]  DEBUG_CC_REGX,
	input         DEBUG_MODEX,
	input [2:0]  DEBUG_PC_NEXTX,
	input [3:0]  DEBUG_REG_SEQX,
	
	input [1:0]  INT_CC_REGX,
	input [2:0]  INT_PC_NEXTX,

	input [2:0]  JMP_ADDR_BUSX,
	input [2:0]  JMP_ALUB_SRCX,
	input [1:0]  JMP_BUS_SEQX,
	input [1:0]  JMP_PC_BASEX,
	input [1:0]  JMP_PC_OFFSETX,
	input [3:0]  JMP_REG_SEQX,
	input [1:0]  JMP_REGA_DINX,
	input [1:0]  JMP_REGA_ADDRX,
	input [2:0]  JMP_REGB_ADDRX,

	input [2:0]  LDS_ADDR_BUSX,
	input [3:0]  LDS_ALU_OPX,
	input [2:0]  LDS_ALUA_SRCX,
	input [2:0]  LDS_ALUB_SRCX,
	input [1:0]  LDS_BUS_SEQX,
	input         LDS_BYTEX,	
	input [1:0]  LDS_DATA_BUSX,	
	input [1:0]  LDS_PC_OFFSETX,
	input [3:0]  LDS_REG_SEQX,
	input [1:0]  LDS_REGA_ADDRX,
	input [1:0]  LDS_REGA_DINX,
	input [2:0]  LDS_REGB_ADDRX,
	
	/*********************************************
	* Combined outputs
	**********************************************/
	output reg [2:0]  ADDR_BUSX,
	output reg [3:0]  ALU_OPX,
	output reg [2:0]  ALUA_SRCX,
	output reg [2:0]  ALUB_SRCX,
	output reg [1:0]  BUS_SEQX,
	output reg	       BYTEX,
	output reg         CCL_LD,
	output reg [1:0]  CC_REGX,
	output reg [1:0]  DATA_BUSX,
	output reg [1:0]  PC_BASEX,
	output reg [2:0]  PC_NEXTX,
	output reg [1:0]  PC_OFFSETX,
	output reg [3:0]  REG_SEQX,
	output reg [1:0]  REGA_ADDRX,
	output reg [1:0]  REGA_DINX,
	output reg [2:0]  REGB_ADDRX

);

always @(*) begin
		
	CC_REGX       = INT_CC_REGX;
	PC_NEXTX      = INT_PC_NEXTX;	

	case(INSTRUCTION_GROUP)
		`GROUPX_SYS: begin
			ADDR_BUSX     = `ADDR_BUSX_PC_A;
			ALU_OPX       = `ALU_OPX_MOV;
			ALUA_SRCX     = `ALUA_SRCX_REG_A;
			ALUB_SRCX     = `ALUB_SRCX_REG_B;
			BUS_SEQX      = `BUS_SEQX_IDLE;
			BYTEX         = `BYTEX_WORD;
			CCL_LD        = 0;
			DATA_BUSX     = `DATA_BUSX_REGA_DOUT;
			PC_BASEX      = `PC_BASEX_PC_A;
			PC_OFFSETX    = `PC_OFFSETX_2;
			REG_SEQX      = `REG_SEQX_NONE;
			REGA_ADDRX    = `REGA_ADDRX_ARGA;
			REGA_DINX     = `REGA_DINX_DIN;
			REGB_ADDRX    = `REGB_ADDRX_ARGB;
		end
			
		`GROUPX_LDS: begin
			ADDR_BUSX     = LDS_ADDR_BUSX;
			ALU_OPX       = LDS_ALU_OPX;
			ALUA_SRCX     = LDS_ALUA_SRCX;
			ALUB_SRCX     = LDS_ALUB_SRCX;
			BUS_SEQX      = LDS_BUS_SEQX;
			BYTEX         = LDS_BYTEX;
			CCL_LD        = 0;
			DATA_BUSX     = LDS_DATA_BUSX;
			PC_BASEX      = `PC_BASEX_PC_A;
			PC_OFFSETX    = LDS_PC_OFFSETX;
			REG_SEQX      = LDS_REG_SEQX;
			REGA_ADDRX    = LDS_REGA_ADDRX;
			REGA_DINX     = LDS_REGA_DINX;
			REGB_ADDRX    = LDS_REGB_ADDRX;
		end
		
		`GROUPX_JMP: begin
			ADDR_BUSX     = JMP_ADDR_BUSX;
			ALU_OPX       = `ALU_OPX_MOV;
			ALUA_SRCX     = `ALUA_SRCX_REG_A;
			ALUB_SRCX     = JMP_ALUB_SRCX;
			BUS_SEQX      = JMP_BUS_SEQX;
			BYTEX         = `BYTEX_WORD;
			CCL_LD        = 0;
			DATA_BUSX     = `DATA_BUSX_REGA_DOUT;
			PC_BASEX      = JMP_PC_BASEX;
			PC_OFFSETX    = JMP_PC_OFFSETX;
			REG_SEQX      = JMP_REG_SEQX;
			REGA_ADDRX    = JMP_REGA_ADDRX;
			REGA_DINX     = JMP_REGA_DINX;
			REGB_ADDRX    = JMP_REGB_ADDRX;
		end
		
		`GROUPX_ALU: begin
			ADDR_BUSX     = `ADDR_BUSX_PC_A;
			ALU_OPX       = ALU_ALU_OPX;
			ALUA_SRCX     = ALU_ALUA_SRCX;
			ALUB_SRCX     = ALU_ALUB_SRCX;
			BUS_SEQX      = `BUS_SEQX_IDLE;
			BYTEX         = `BYTEX_WORD;
			CCL_LD        = ALU_CCL_LD;
			DATA_BUSX     = `DATA_BUSX_ALU_R;
			PC_BASEX      = `PC_BASEX_PC_A;
			PC_OFFSETX    = `PC_OFFSETX_2;
			REG_SEQX      = ALU_REG_SEQX;
			REGA_ADDRX    = ALU_REGA_ADDRX;
			REGA_DINX     = `REGA_DINX_ALU_R;
			REGB_ADDRX    = ALU_REGB_ADDRX;
		end	
		
		`GROUPX_DBG: begin
			ADDR_BUSX     = DEBUG_ADDR_BUSX;
			ALU_OPX       = `ALU_OPX_MOV;
			ALUA_SRCX     = `ALUA_SRCX_REG_A;
			ALUB_SRCX     = `ALUB_SRCX_REG_B;
			BUS_SEQX      = DEBUG_BUS_SEQX;
			BYTEX         = `BYTEX_WORD;
			CCL_LD        = 0;
			CC_REGX       = DEBUG_CC_REGX;
			DATA_BUSX     = `DATA_BUSX_REGA_DOUT;
			PC_BASEX      = `PC_BASEX_PC_A;
			PC_NEXTX      = DEBUG_PC_NEXTX;
			PC_OFFSETX    = `PC_OFFSETX_2;
			REG_SEQX      = DEBUG_REG_SEQX;
			REGB_ADDRX    = `REGB_ADDRX_ARGB;
			REGA_DINX     = `REGA_DINX_DIN;
			REGA_ADDRX    = `REGA_ADDRX_ARGA;	
		end
	endcase
end
endmodule