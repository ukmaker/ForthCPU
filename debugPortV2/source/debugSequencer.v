`include "C:/Users/Duncan/git/ForthCPU/constants.v"
/******************************************************************
* Generate 
* - the load signal for the snooper
* - bus control signals
* - provide DEBUG_MR_ADDR_INCX at the right time (^CLK & FETCH)
*
* Sequence types are
*                      RD WR DEBUG_WR DIN_BUSX ADDR_BUSX
* - DEBUG_SEQ_NONE   : 0  0      0     NONE     NONE
* - DEBUG_SEQ_RD_REG : 0  0      1     NONE     NONE   
* - DEBUG_SEQ_WR_REG : 1  0      0     DEBUG_MD DEBUG_MA
* - DEBUG_SEQ_RD_MEM : 0  0      1     DEBUG_MD DEBUG_MA
* - DEBUG_SEQ_WR_MEM : 0  1      0     DEBUG_MD DEBUG_MA
*
*******************************************************************/

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
	
	