/**
* Contains the multiplexers to choose the address source
* Also selects the correct data lines for word and byte writes
* and generates the appropriate write strobes
**/
`timescale 1 ns / 1 ns
`include "../../constants.v"

module busController(
	
	input CLK,
	input RESET,
	
	
	/**
	* Address
	**/
	input [15:0] PC_A,
	input [15:0] ALU_R,
	input [15:0] ALUB_DATA,
	
	input [1:0] ADDR_BUSX,
	
	output reg [15:0] ADDR_BUF,

	/**
	* Data
	**/
	input [15:0] ALUA_DATA,
	input [1:0] DATA_BUSX,
	input BYTEX,
	input WRX,
	input RDX,

	output reg[15:0]DOUT_BUF,
	
	output reg HIGH_BYTEX,
	output reg DBUS_OEN,
	output reg RDN_BUF,
	output reg WRN0_BUF,
	output reg WRN1_BUF
	
);

reg  [15:0] DOUT_W;
wire [15:0] ALUA_DATAL;

assign ALUA_DATAL = {ALUA_DATA[7:0],8'h00};

always @(*) begin
	HIGH_BYTEX = BYTEX & ADDR_BUF[0];
	DOUT_W = HIGH_BYTEX ? ALUA_DATAL : ALUA_DATA;
end

always @(*) begin
	case(ADDR_BUSX)
		`ADDR_BUSX_PC_A:      ADDR_BUF = PC_A;
		`ADDR_BUSX_ALU_R:     ADDR_BUF = ALU_R;
		`ADDR_BUSX_ALUB_DATA: ADDR_BUF = ALUB_DATA;
		default:              ADDR_BUF = ALUB_DATA;
	endcase
end
	
always @(*) begin
	case(DATA_BUSX)
		`DATA_BUSX_ALUA_DATA:  DOUT_BUF = DOUT_W;
		default:               DOUT_BUF = ALU_R;
	endcase
end

always @(posedge CLK) begin
	WRN0_BUF <= ~WRX | (BYTEX &  ADDR_BUF[0]);
	WRN1_BUF <= ~WRX | (BYTEX & ~ADDR_BUF[0]);
	DBUS_OEN <= ~RDX & WRX;
end

always @(negedge CLK) begin
	RDN_BUF  <= ~RDX;
end

endmodule