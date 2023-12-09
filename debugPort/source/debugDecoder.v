`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/*************************************************
* Decode DEBUG_OPX to provide register and memory 
* control signals
**************************************************/
module debugDecoder(
	
	input [3:0]       DEBUG_OP,
	input [3:0]       DEBUG_ARGX,
	
	output reg        DEBUG_ADDR_INCX,

	output reg        DEBUG_LD_DATAX,
	output reg [1:0] DEBUG_DATAX,
	
	output reg [1:0]  DEBUG_BUS_SEQX,
	output reg [3:0]  DEBUG_REG_SEQX,
	
	output reg [1:0]  DEBUG_CC_REGX,
	output reg [2:0]  DEBUG_PC_NEXTX

);

wire DEBUG_ADDR_INC   = DEBUG_OP[0];
wire [2:0] DEBUG_OPX = DEBUG_OP[3:1];

always @(*) begin
	
	case(DEBUG_OPX)
		`DEBUG_OPX_NONE: begin
			DEBUG_BUS_SEQX   = `BUS_SEQX_NONE;
			DEBUG_REG_SEQX   = `REG_SEQX_NONE;
			DEBUG_ADDR_INCX  = `DEBUG_ADDR_INCX_NONE;
			DEBUG_DATAX      = `DEBUG_DATAX_DIN;
			DEBUG_CC_REGX    = `CC_REGX_RUN;
			DEBUG_PC_NEXTX   = `PC_NEXTX_NEXT;
		end
		
		`DEBUG_OPX_RD_REG: begin
			DEBUG_BUS_SEQX   = `BUS_SEQX_NONE;
			DEBUG_REG_SEQX   = `REG_SEQX_RDB;
			DEBUG_ADDR_INCX  = DEBUG_ADDR_INC;
			DEBUG_DATAX      = `DEBUG_DATAX_REGB_DATA;
			DEBUG_CC_REGX    = `CC_REGX_RUN;
			DEBUG_PC_NEXTX   = `PC_NEXTX_NEXT;
		end
		
		`DEBUG_OPX_RD_CC: begin
			DEBUG_BUS_SEQX   = `BUS_SEQX_NONE;
			DEBUG_REG_SEQX   = `REG_SEQX_NONE;
			DEBUG_ADDR_INCX  = `DEBUG_ADDR_INCX_NONE;
			DEBUG_DATAX      = `DEBUG_DATAX_DIN;
			DEBUG_CC_REGX    = DEBUG_ARGX[1:0];
			DEBUG_PC_NEXTX   = `PC_NEXTX_NEXT;
		end
		
		`DEBUG_OPX_RD_PC: begin
			DEBUG_BUS_SEQX   = `BUS_SEQX_NONE;
			DEBUG_REG_SEQX   = `REG_SEQX_NONE;
			DEBUG_ADDR_INCX  = `DEBUG_ADDR_INCX_NONE;
			DEBUG_DATAX      = `DEBUG_DATAX_DIN;
			DEBUG_CC_REGX    = `CC_REGX_RUN;
			DEBUG_PC_NEXTX   = DEBUG_ARGX[2:0]; 
		end
		
		`DEBUG_OPX_RD_MEM: begin
			DEBUG_BUS_SEQX   = `BUS_SEQX_READ;
			DEBUG_REG_SEQX   = `REG_SEQX_NONE;
			DEBUG_ADDR_INCX  = DEBUG_ADDR_INC;
			DEBUG_DATAX      = `DEBUG_DATAX_DIN;
			DEBUG_CC_REGX    = `CC_REGX_RUN;
			DEBUG_PC_NEXTX   = `PC_NEXTX_NEXT;
		end
		
		`DEBUG_OPX_WR_MEM: begin
			DEBUG_BUS_SEQX   = `BUS_SEQX_WRITE;
			DEBUG_REG_SEQX   = `REG_SEQX_NONE;
			DEBUG_ADDR_INCX  = DEBUG_ADDR_INC;
			DEBUG_DATAX      = `DEBUG_DATAX_DIN;
			DEBUG_CC_REGX    = `CC_REGX_RUN;
			DEBUG_PC_NEXTX   = `PC_NEXTX_NEXT;
		end
		

		default: begin
			DEBUG_BUS_SEQX   = `BUS_SEQX_NONE;
			DEBUG_REG_SEQX   = `REG_SEQX_NONE;
			DEBUG_ADDR_INCX  = `DEBUG_ADDR_INCX_NONE;
			DEBUG_DATAX      = `DEBUG_DATAX_DIN;
			DEBUG_CC_REGX    = `CC_REGX_RUN;
			DEBUG_PC_NEXTX   = `PC_NEXTX_NEXT;
		end
	endcase
end

endmodule