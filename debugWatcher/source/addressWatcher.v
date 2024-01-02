`include "../../constants.v"

/**************************************************
* Watch the address bus and provide 
* AT_BKP and IN_WATCH signals
***************************************************/

module addressWatcher (
	
	input CLK,
	input RESET,
	input DECODE, COMMIT,
	
	input [15:0] ADDR,
	
	input         DEBUG_WATCH_ENX,
	input [15:0] DEBUG_WATCH_START_ADDR,
	input [15:0] DEBUG_WATCH_END_ADDR,
	
	output reg DEBUG_IN_WATCH

);

always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		DEBUG_IN_WATCH <= 0;
	end else begin
		if(DECODE) begin
			DEBUG_IN_WATCH <= 0;
		end else if(COMMIT) begin
			if((ADDR >= DEBUG_WATCH_START_ADDR) && (ADDR <= DEBUG_WATCH_END_ADDR)) begin
				DEBUG_IN_WATCH <= DEBUG_WATCH_ENX;
			end
		end
	end
end


endmodule