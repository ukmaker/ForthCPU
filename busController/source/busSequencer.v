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
	input DEBUG_ACTIVE,
	
	input A0,
	input BYTEX,
	
	input [2:0]  ADDR_BUSX_MUX,
	input [1:0]  BUS_SEQX,
	input [1:0]  PC_BASEX_MUX,
	input [1:0]  PC_OFFSETX_MUX,	
	output reg [2:0]  ADDR_BUSX,
	output reg [1:0]  PC_BASEX,
	output reg [1:0]  PC_OFFSETX,
	
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

always @(posedge NCLK or posedge RESET) begin
	if(RESET) begin
		RDN_BUF <= 1;
	end else begin
		if(BUS_SEQX == `BUS_SEQX_FETCH && DECODE) begin
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
	
	if(DEBUG_ACTIVE) begin
		
		ADDR_BUSX = `ADDR_BUSX_DEBUG;
		
	end else if(RESET | FETCH) begin
		
		ADDR_BUSX <= `ADDR_BUSX_PC_A;
		// Always generate the next address for HERE
		PC_BASEX   <= `PC_BASEX_PC_A;
		PC_OFFSETX <= `PC_OFFSETX_2;
		
	end else if(EXECUTE) begin
		
		PC_BASEX   <= PC_BASEX_MUX;
		PC_OFFSETX <= PC_OFFSETX_MUX;
		ADDR_BUSX  <= ADDR_BUSX_MUX;

	end
end

endmodule