`include "../../constants.v"

/**************************************************
* Snoop the address and data buses
* and capture instruction and argument
* address and data.
***************************************************/

module snooper (
	
	input CLK,
	input RESET,
	input FETCH, DECODE, EXECUTE, COMMIT,
	
	input [15:0] DIN,
	input [15:0] ADDR,
	input         RD,
	input         WR,
	
	output reg [15:0] SNOOP_INST_ADDR,
	output reg [15:0] SNOOP_INST_DATA,
	output reg [15:0] SNOOP_ARG_ADDR,
	output reg [15:0] SNOOP_ARG_DATA,
	output reg         SNOOP_ARG_VALID

);

always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		SNOOP_INST_ADDR <= 16'h0000;
		SNOOP_INST_DATA <= 16'h0000;
		SNOOP_ARG_ADDR  <= 16'h0000;
		SNOOP_ARG_DATA  <= 16'h0000;
		SNOOP_ARG_VALID <= 0;
	end else begin
		if(DECODE) begin
			// Instruction capture
			SNOOP_INST_ADDR <= ADDR;
			SNOOP_INST_DATA <= DIN;
		end else if(COMMIT) begin
			if(RD | WR) begin
				// arg capture
				SNOOP_ARG_ADDR  <= ADDR;
				SNOOP_ARG_DATA  <= DIN;
				SNOOP_ARG_VALID <= 1'b1;
			end else begin
				SNOOP_ARG_VALID <= 1'b0;
			end
		end
	end
end


endmodule