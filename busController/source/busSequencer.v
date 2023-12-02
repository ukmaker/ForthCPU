/**
* Controls the sequencing of bus signals
**/
`timescale 1 ns / 1 ns
`include "../../constants.v"

module busSequencer(
	
	input CLK,
	input RESET,

	input FETCH,
	input DECODE,
	input EXECUTE,
	input COMMIT,
	
	input A0,
	input BYTEX,

	input [1:0]  BUS_SEQX,
	
	input  [2:0] ADDR_BUSX,
	output reg [2:0] ADDR_BUSX_R,

	output reg RDN_BUF,
	output reg WRN0_BUF,
	output reg WRN1_BUF
);

wire NCLK;
assign NCLK = ~CLK;

always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		WRN0_BUF <= 1;
		WRN1_BUF <= 1;
	end else if(BUS_SEQX == `BUS_SEQX_WRITE && COMMIT) begin
		WRN0_BUF <= BYTEX &  A0;
		WRN1_BUF <= BYTEX & ~A0;
	end else begin
		WRN0_BUF <= 1;
		WRN1_BUF <= 1;
	end
end

always @(negedge CLK or posedge RESET) begin
	if(RESET) begin
		RDN_BUF <= 1;
	end else begin
		if(DECODE) begin
			// Instruction fetch
			RDN_BUF <= 0;
		end else if(BUS_SEQX == `BUS_SEQX_READ && COMMIT) begin
			RDN_BUF <= 0;
		end else begin
			RDN_BUF <= 1;
		end
	end
end


always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		ADDR_BUSX_R <= `ADDR_BUSX_PC_A;
	end else begin
		if(FETCH | DECODE) begin
			// Instruction fetch next
			ADDR_BUSX_R <= `ADDR_BUSX_PC_A;
		end else begin
			ADDR_BUSX_R <= ADDR_BUSX;
		end
	end
end


endmodule