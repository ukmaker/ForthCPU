`include "C:/Users/Duncan/git/ForthCPU/constants.v"
/**************************************************
* Generates the data load and address increment
* signals for the debugPort.
* Driven by OPX signals decoded by the debugDecoder
***************************************************/

module debugSequencer(
	input CLK,
	input RESET,
	input FETCH,
	input DECODE,
	input EXECUTE,
	input COMMIT,
	
	input DEBUG_ADDR_INCX,
	input DEBUG_LD_ARGX,
	input DEBUG_LD_DATAX,
	input DEBUG_WR_BKPX,
	
	output reg DEBUG_ADDR_INC_EN,
	output reg DEBUG_LD_BKP_EN,
	output reg DEBUG_LD_DATA_EN,
	output reg DEBUG_LD_ARG_EN
);

always @(negedge CLK or posedge RESET) begin
	
	if(RESET) begin
		DEBUG_ADDR_INC_EN <= 0;
		DEBUG_LD_DATA_EN  <= 0;
	end else begin
		if(EXECUTE) begin
			DEBUG_ADDR_INC_EN <= DEBUG_ADDR_INCX;
			DEBUG_LD_DATA_EN  <= DEBUG_LD_DATAX;
		end else begin
			DEBUG_ADDR_INC_EN <= 0;
			DEBUG_LD_DATA_EN  <= 0;
		end
	end
end

always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
		DEBUG_LD_BKP_EN   <= 0;
	end else begin
		if(DECODE) begin
			DEBUG_LD_BKP_EN   <= DEBUG_WR_BKPX;
		end else begin
			DEBUG_LD_BKP_EN   <= 0; 
		end
	end
end

always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
		DEBUG_LD_ARG_EN   <= 0;
	end else begin
		if(COMMIT) begin
			DEBUG_LD_ARG_EN  <= DEBUG_LD_ARGX;
		end else begin
			DEBUG_LD_ARG_EN  <= 0;
		end
	end
end

endmodule
	
	