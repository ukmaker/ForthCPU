`include "../../constants.v"

/**************************************************
* Watch the address bus and provide 
* AT_BKP and IN_WATCH signals
***************************************************/

module watcher (
	
	input CLK,
	input RESET,
	input FETCH, DECODE, EXECUTE, COMMIT,
	
	input RD,
	
	input [15:0] ADDR,
	
	input         DEBUG_BKP_ENX,
	input         DEBUG_WATCH_ENX,
	input [15:0] DEBUG_BKP_ADDR,
	input [15:0] DEBUG_WATCH_START_ADDR,
	input [15:0] DEBUG_WATCH_END_ADDR,
	
	output reg DEBUG_AT_BKP,
	output reg DEBUG_IN_WATCH

);

always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		DEBUG_AT_BKP <= 0;
		DEBUG_IN_WATCH <= 0;
	end else begin
		// clear flags at the beginning of a cycle
		if(FETCH) begin
			DEBUG_AT_BKP   <= 0;
		end else if(DECODE) begin
			// Breakpoint check
			if(ADDR === DEBUG_BKP_ADDR) begin
				DEBUG_AT_BKP <= DEBUG_BKP_ENX;
			end
		end else if(EXECUTE) begin
			DEBUG_IN_WATCH <= 0;
		end else if(COMMIT & RD) begin
			if((ADDR >= DEBUG_WATCH_START_ADDR) && (ADDR <= DEBUG_WATCH_END_ADDR)) begin
				DEBUG_IN_WATCH <= DEBUG_WATCH_ENX;
			end
		end
	end
end


endmodule