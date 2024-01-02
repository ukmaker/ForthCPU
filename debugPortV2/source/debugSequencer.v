`include "C:/Users/Duncan/git/ForthCPU/constants.v"
/******************************************************************
* Generate 
* - the load signal for the snooper
* - provide DEBUG_MR_ADDR_INCX at the right time (^CLK & FETCH)
*******************************************************************/

module debugSequencer(
	input CLK,
	input RESET,
	input FETCH,
	input EXECUTE,
	
	input DEBUG_OPX_INC,
	input DEBUG_MODE_SNOOP,
	
	output reg DEBUG_ADDR_INC_EN,
	output reg DEBUG_SNOOP_LD_EN,
	output reg DEBUG_DATA_OUT_SELX
);

always @(negedge CLK or posedge RESET) begin
	
	if(RESET) begin
		DEBUG_ADDR_INC_EN   <= 0;
		DEBUG_SNOOP_LD_EN   <= 0;
		DEBUG_DATA_OUT_SELX <= `DEBUG_DATA_OUT_SELX_INST;
	end else begin
		if(FETCH) begin
			DEBUG_ADDR_INC_EN   <= DEBUG_OPX_INC;
			DEBUG_SNOOP_LD_EN   <= DEBUG_MODE_SNOOP;
			DEBUG_DATA_OUT_SELX <= `DEBUG_DATA_OUT_SELX_INST;
		end else if(EXECUTE) begin
			DEBUG_DATA_OUT_SELX <= `DEBUG_DATA_OUT_SELX_DATA;
		end else begin
			DEBUG_ADDR_INC_EN   <= 0;
			DEBUG_SNOOP_LD_EN   <= 0;
			DEBUG_DATA_OUT_SELX <= `DEBUG_DATA_OUT_SELX_INST;
		end
	end
end

endmodule
	
	