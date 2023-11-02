/**
* Contains the multiplexers to choose the address source
* Also selects the correct data lines for word and byte writes
* and generates the appropriate write strobes
**/
`timescale 1 ns / 1 ns
`include "../../constants.v"

module busController(
	
	input CLK,
	input DECODE,
	input COMMIT,	
	
	/**
	* Address
	**/
	input [15:0] PC_A,
	input [15:0] ALU_R,
	input [15:0] ALUB_DATA,
	input [15:0] HERE,
	
	input [1:0] ADDR_BUSX,
	
	output reg [15:0] ADDR_BUF,

	/**
	* Data
	**/
	input [15:0] REGA_DOUT,
	input [1:0] DATA_BUSX,
	input BYTEX,
	input WRX,
	input RDX,

	output reg[15:0]DOUT_BUF,
	
	output reg HIGH_BYTEX,
	output reg RDN_BUF,
	output reg WRN0_BUF,
	output reg WRN1_BUF
	
);

reg  [15:0] DOUT_W;
wire [15:0] REGA_DOUT_L;

assign REGA_DOUT_L = {REGA_DOUT[7:0],8'h00};

always @(*) begin
	HIGH_BYTEX = BYTEX & ADDR_BUF[0];
	DOUT_W = HIGH_BYTEX ? REGA_DOUT_L : REGA_DOUT;
end

always @(*) begin
	case(ADDR_BUSX)
		`ADDR_BUSX_PC_A:      ADDR_BUF = PC_A;
		`ADDR_BUSX_ALU_R:     ADDR_BUF = ALU_R;
		`ADDR_BUSX_ALUB_DATA: ADDR_BUF = ALUB_DATA;
		default:              ADDR_BUF = HERE;
	endcase
end
	
always @(*) begin
	case(DATA_BUSX)
		`DATA_BUSX_REGA_DOUT:  DOUT_BUF = DOUT_W;
		default:               DOUT_BUF = ALU_R;
	endcase
end

always @(posedge CLK) begin
	WRN0_BUF <= ~WRX | (BYTEX &  ADDR_BUF[0]);
	WRN1_BUF <= ~WRX | (BYTEX & ~ADDR_BUF[0]);
end

always @(negedge CLK) begin
	if(DECODE) begin
		RDN_BUF <= 0;
	end else if(COMMIT) begin 
		RDN_BUF  <= ~RDX;
	end else begin
		RDN_BUF <= 1;
	end
end

endmodule