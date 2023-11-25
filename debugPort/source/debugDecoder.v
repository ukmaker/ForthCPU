`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/*************************************************
* Decode DEBUG_OPX to provide register and memory 
* control signals
**************************************************/
module debugDecoder(
	
	input CLK,
	input RESET,
	input STOPPED, FETCH, DECODE, EXECUTE, COMMIT,
	
	input [2:0]DEBUG_OPX,
	
	output reg DEBUG_ADDR_INCX,
	output reg DEBUG_ADDR_LDX,
	output reg DEBUG_STOPX,
	output reg DEBUG_ACKX,
	
	output reg [1:0] BUS_SEQX,
	output reg [2:0] REG_SEQX

);

always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
			DEBUG_STOPX     <= 1;
			DEBUG_OPX       <= `DEBUG_OPX_NONE;
			DEBUG_ADDR_INCX <= `DEBUG_ADDR_INCX_NONE;
			DEBUG_ADDR_LDX  <= `DEBUG_ADDR_LDX_NONE;
			BUS_SEQX        <= `BUS_SEQX_NONE;
			REG_SEQX        <= `REG_SEQX_NONE;		
	end else begin
		
		if(FETCH) begin
			
		
	case(DEBUG_OPX)
		`DEBUG_OPX_STOP: begin
			DEBUG_STOPX     <= 1;
			BUS_SEQX        <= `BUS_SEQX_NONE;
			REG_SEQX        <= `REG_SEQX_NONE;
		end
		
		`DEBUG_OPX_RD_REG: begin
			DEBUG_STOPX     <= 1;
		end
		
		`DEBUG_OPX_RD_CC: begin
			DEBUG_STOPX     <= 1;
		end
		
		`DEBUG_OPX_RD_PC: begin
			DEBUG_STOPX     <= 1;
		end
		
		`DEBUG_OPX_RD_MEM: begin
			DEBUG_STOPX     <= 1;
		end
		
		`DEBUG_OPX_WR_MEM: begin
			DEBUG_STOPX     <= 1;
		end
		
		// `DEBUG_OPX_NONE:
		default: begin
			DEBUG_STOPX     <= 0;
		end
	endcase
end

endmodule