`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/*************************************************
* Decode DEBUG_OPX to provide register and memory 
* control signals for DEBUG operations
* 
**************************************************/
module debugDecoder(
	input              DEBUG_ADDR_INC_I,
	input              DEBUG_EN_BKP_I,
	input [2:0]       DEBUG_OP_I,
	input [2:0]       DEBUG_ARG,
	
	output reg         DEBUG_ADDR_INCX,
	output reg         DEBUG_LD_DATAX,
	output reg         DEBUG_LD_ARGX,
	output reg [2:0]  DEBUG_DATAX,
	output reg         DEBUG_WR_BKPX,
	output reg         DEBUG_EN_BKPX,
	
	output reg [2:0]  DEBUG_ADDR_BUSX,
	output reg [1:0]  DEBUG_BUS_SEQX,
	output reg [1:0]  DEBUG_CC_REGX,
	output reg [3:0]  DEBUG_REG_SEQX,
	output reg [2:0]  DEBUG_PC_NEXTX
);

always @(*) begin
	DEBUG_ADDR_BUSX  = `ADDR_BUSX_DEBUG;
			
	case(DEBUG_OP_I)
		`DEBUG_OPX_WR_BKP: begin
			DEBUG_BUS_SEQX   = `BUS_SEQX_NONE;
			DEBUG_REG_SEQX   = `REG_SEQX_NONE;
			DEBUG_ADDR_INCX  = `DEBUG_ADDR_INCX_NONE;
			DEBUG_DATAX      = `DEBUG_DATAX_DIN;
			DEBUG_CC_REGX    = `CC_REGX_RUN;
			DEBUG_LD_DATAX   = `DEBUG_LD_DATAX_NONE;
			DEBUG_LD_ARGX    = `DEBUG_LD_ARGX_NONE;
			DEBUG_PC_NEXTX   = `PC_NEXTX_NEXT;
			DEBUG_WR_BKPX    = 1'b1;
			DEBUG_EN_BKPX    = DEBUG_EN_BKP_I;
		end
		
		`DEBUG_OPX_RD_REG: begin
			DEBUG_BUS_SEQX   = `BUS_SEQX_NONE;
			DEBUG_REG_SEQX   = `REG_SEQX_RDB;
			DEBUG_ADDR_INCX  = DEBUG_ADDR_INC_I;
			DEBUG_DATAX      = `DEBUG_DATAX_REGB_DATA;
			DEBUG_CC_REGX    = `CC_REGX_RUN;
			DEBUG_LD_DATAX   = `DEBUG_LD_DATAX_LD;
			DEBUG_LD_ARGX    = `DEBUG_LD_ARGX_NONE;
			DEBUG_PC_NEXTX   = `PC_NEXTX_NEXT;
			DEBUG_WR_BKPX    = 1'b0;
			DEBUG_EN_BKPX    = 1'b0;
		end
		
		`DEBUG_OPX_RD_CC: begin
			DEBUG_BUS_SEQX   = `BUS_SEQX_NONE;
			DEBUG_REG_SEQX   = `REG_SEQX_NONE;
			DEBUG_ADDR_INCX  = DEBUG_ADDR_INC_I;
			DEBUG_DATAX      = `DEBUG_DATAX_CC_DATA;
			DEBUG_CC_REGX    = DEBUG_ARG[1:0];
			DEBUG_LD_DATAX   = `DEBUG_LD_DATAX_LD;
			DEBUG_LD_ARGX    = `DEBUG_LD_ARGX_NONE;
			DEBUG_PC_NEXTX   = `PC_NEXTX_NEXT;
			DEBUG_WR_BKPX    = 1'b0;
			DEBUG_EN_BKPX    = 1'b0;
		end
		
		`DEBUG_OPX_RD_PC: begin
			DEBUG_ADDR_BUSX  = `ADDR_BUSX_PC_A;
			DEBUG_BUS_SEQX   = `BUS_SEQX_NONE;
			DEBUG_REG_SEQX   = `REG_SEQX_NONE;
			DEBUG_ADDR_INCX  = DEBUG_ADDR_INC_I;
			DEBUG_DATAX      = `DEBUG_DATAX_PC_A;
			DEBUG_CC_REGX    = `CC_REGX_RUN;
			DEBUG_LD_DATAX   = `DEBUG_LD_DATAX_LD;
			DEBUG_LD_ARGX    = `DEBUG_LD_ARGX_NONE;
			DEBUG_PC_NEXTX   = DEBUG_ARG;
			DEBUG_WR_BKPX    = 1'b0;
			DEBUG_EN_BKPX    = 1'b0;
		end
		
		`DEBUG_OPX_RD_INSTRUCTION: begin
			DEBUG_ADDR_BUSX  = `ADDR_BUSX_PC_A;
			DEBUG_BUS_SEQX   = `BUS_SEQX_READ;
			DEBUG_REG_SEQX   = `REG_SEQX_NONE;
			DEBUG_ADDR_INCX  = `DEBUG_ADDR_INCX_NONE;
			DEBUG_DATAX      = `DEBUG_DATAX_INSTRUCTION;
			DEBUG_CC_REGX    = `CC_REGX_RUN;
			DEBUG_LD_DATAX   = `DEBUG_LD_DATAX_LD;
			DEBUG_LD_ARGX    = `DEBUG_LD_ARGX_LD;
			DEBUG_PC_NEXTX   = `PC_NEXTX_NEXT;
			DEBUG_WR_BKPX    = 1'b0;
			DEBUG_EN_BKPX    = 1'b0;
		end
		
		`DEBUG_OPX_RD_MEM: begin
			DEBUG_BUS_SEQX   = `BUS_SEQX_READ;
			DEBUG_REG_SEQX   = `REG_SEQX_NONE;
			DEBUG_ADDR_INCX  = DEBUG_ADDR_INC_I;
			DEBUG_DATAX      = `DEBUG_DATAX_DIN;
			DEBUG_CC_REGX    = `CC_REGX_RUN;
			DEBUG_LD_DATAX   = `DEBUG_LD_DATAX_LD;
			DEBUG_LD_ARGX    = `DEBUG_LD_ARGX_NONE;
			DEBUG_PC_NEXTX   = `PC_NEXTX_NEXT;
			DEBUG_WR_BKPX    = 1'b0;
			DEBUG_EN_BKPX    = 1'b0;
		end
		
		`DEBUG_OPX_WR_MEM: begin
			DEBUG_BUS_SEQX   = `BUS_SEQX_WRITE;
			DEBUG_REG_SEQX   = `REG_SEQX_NONE;
			DEBUG_ADDR_INCX  = DEBUG_ADDR_INC_I;
			DEBUG_DATAX      = `DEBUG_DATAX_DIN;
			DEBUG_CC_REGX    = `CC_REGX_RUN;
			DEBUG_LD_DATAX   = `DEBUG_LD_DATAX_NONE;
			DEBUG_LD_ARGX    = `DEBUG_LD_ARGX_NONE;
			DEBUG_PC_NEXTX   = `PC_NEXTX_NEXT;
			DEBUG_WR_BKPX    = 1'b0;
			DEBUG_EN_BKPX    = 1'b0;
		end
		

		default: begin
			DEBUG_BUS_SEQX   = `BUS_SEQX_NONE;
			DEBUG_REG_SEQX   = `REG_SEQX_NONE;
			DEBUG_ADDR_INCX  = `DEBUG_ADDR_INCX_NONE;
			DEBUG_DATAX      = `DEBUG_DATAX_DIN;
			DEBUG_CC_REGX    = `CC_REGX_RUN;
			DEBUG_LD_DATAX   = `DEBUG_LD_DATAX_NONE;
			DEBUG_LD_ARGX    = `DEBUG_LD_ARGX_NONE;
			DEBUG_PC_NEXTX   = `PC_NEXTX_NEXT;
			DEBUG_WR_BKPX    = 1'b0;
			DEBUG_EN_BKPX    = 1'b0;
		end
	endcase
end

endmodule