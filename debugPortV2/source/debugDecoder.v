`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/*************************************************
* Decode DEBUG_OPX to provide register and memory 
* control signals for DEBUG operations
*
* DEBUG_OPX
* ------------------------------
* 
* 
**************************************************/
module debugDecoder(
	input [2:0]       DEBUG_OPX,
	
	output reg [1:0]  DATA_BUSX,
	output reg [2:0]  ADDR_BUSX,
	output reg [1:0]  BUS_SEQX,
	output reg [1:0]  CC_REGX,
	output reg [3:0]  REG_SEQX,
	output reg [2:0]  PC_NEXTX,
	output reg         DEBUG_LD_BKP_EN
);

always @(*) begin
			
	case(DEBUG_OPX)
		
		`DEBUG_OPX_RD_REG: begin
			ADDR_BUSX  = `ADDR_BUSX_DEBUG;
			BUS_SEQX   = `BUS_SEQX_DEBUG_DOUT;
			CC_REGX    = `CC_REGX_RUN;
			PC_NEXTX   = `PC_NEXTX_NEXT;
			REG_SEQX   = `REG_SEQX_RDB;
			DEBUG_LD_BKP_EN = 1'b0;
		end
		
		`DEBUG_OPX_RD_CC: begin
			ADDR_BUSX  = `ADDR_BUSX_DEBUG;
			BUS_SEQX   = `BUS_SEQX_DEBUG_DOUT;
			CC_REGX    = `CC_REGX_RUN;
			PC_NEXTX   = `PC_NEXTX_NEXT;
			REG_SEQX   = `REG_SEQX_RDB;
			DEBUG_LD_BKP_EN = 1'b0;
		end
		
		`DEBUG_OPX_RD_PC: begin
			ADDR_BUSX  = `ADDR_BUSX_DEBUG;
			BUS_SEQX   = `BUS_SEQX_DEBUG_DOUT;
			CC_REGX    = `CC_REGX_RUN;
			PC_NEXTX   = `PC_NEXTX_NEXT;
			REG_SEQX   = `REG_SEQX_RDB;
			DEBUG_LD_BKP_EN = 1'b0;
		end
		
		`DEBUG_OPX_RD_INST: begin
			ADDR_BUSX  = `ADDR_BUSX_DEBUG;
			BUS_SEQX   = `BUS_SEQX_ARGRD;
			CC_REGX    = `CC_REGX_RUN;
			PC_NEXTX   = `PC_NEXTX_NEXT;
			REG_SEQX   = `REG_SEQX_RDB;
			DEBUG_LD_BKP_EN = 1'b0;
		end
		
		`DEBUG_OPX_RD_MEM: begin
			ADDR_BUSX  = `ADDR_BUSX_DEBUG;
			BUS_SEQX   = `BUS_SEQX_ARGRD;
			CC_REGX    = `CC_REGX_RUN;
			PC_NEXTX   = `PC_NEXTX_NEXT;
			REG_SEQX   = `REG_SEQX_RDB;
			DEBUG_LD_BKP_EN = 1'b0;
		end
		
		`DEBUG_OPX_WR_MEM: begin
			ADDR_BUSX  = `ADDR_BUSX_DEBUG;
			BUS_SEQX   = `BUS_SEQX_ARGWR;
			CC_REGX    = `CC_REGX_RUN;
			PC_NEXTX   = `PC_NEXTX_NEXT;
			REG_SEQX   = `REG_SEQX_RDB;
			DEBUG_LD_BKP_EN = 1'b0;
		end
		
		`DEBUG_OPX_WR_BKP: begin
			ADDR_BUSX  = `ADDR_BUSX_DEBUG;
			BUS_SEQX   = `BUS_SEQX_ARGWR;
			CC_REGX    = `CC_REGX_RUN;
			PC_NEXTX   = `PC_NEXTX_NEXT;
			REG_SEQX   = `REG_SEQX_RDB;
			DEBUG_LD_BKP_EN = 1'b1;
		end
		

		default: begin
			ADDR_BUSX  = `ADDR_BUSX_DEBUG;
			BUS_SEQX   = `BUS_SEQX_IDLE;
			CC_REGX    = `CC_REGX_RUN;
			PC_NEXTX   = `PC_NEXTX_NEXT;
			REG_SEQX   = `REG_SEQX_RDB;
			DEBUG_LD_BKP_EN = 1'b0;
		end
	endcase
end

endmodule