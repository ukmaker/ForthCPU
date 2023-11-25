/**
* Contains the multiplexers to choose the address source
* Also selects the correct data lines for word and byte writes
* and generates the appropriate write strobes
**/
`timescale 1 ns / 1 ns
`include "../../constants.v"

module busController(
	
	input CLK,
	input FETCH,
	input DECODE,
	input EXECUTE,
	input COMMIT,
	input DEBUG_ACTIVE,
	/**
	* Bus cycle
	**/
	input [1:0] BUS_SEQX,
	
	/**
	* OPX
	**/
	input [2:0]  ADDR_BUSX_MUX,
	input [1:0]  PC_BASEX_MUX,
	input [1:0]  PC_OFFSETX_MUX,
	
	/**
	* Address
	**/
	input [15:0]      PC_A,
	input [15:0]      ALU_R,
	input [15:0]      ALUB_DATA,
	input [15:0]      HERE,
	output reg [15:0] ADDR_BUF,

	/**
	* Data
	**/
	input [15:0]     REGA_DOUT,
	input [1:0]      DATA_BUSX,
	input             BYTEX,
	output reg[15:0] DOUT_BUF,
	
	output reg HIGH_BYTEX,
	output RDN_BUF,
	output WRN0_BUF,
	output WRN1_BUF
	
);

wire [2:0] ADDR_BUSX;
wire [1:0] PC_BASEX;
wire [1:0] PC_OFFSETX;

	
reg [15:0] DOUT_W;
reg [15:0] DOUT_L;

busSequencer sequencer(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.DEBUG_ACTIVE(DEBUG_ACTIVE),
	
	.A0(ADDR_BUF[0]),
	.BYTEX(BYTEX),
	
	.ADDR_BUSX_MUX(ADDR_BUSX_MUX),
	.PC_BASEX_MUX(PC_BASEX_MUX),
	.PC_OFFSETX_MUX(PC_OFFSETX_MUX),
	
	.ADDR_BUSX(ADDR_BUSX),
	.PC_BASEX(PC_BASEX),
	.PC_OFFSETX(PC_OFFSETX),
	
	.BUS_SEQX(BUS_SEQX),
	.RDN_BUF(RDN_BUF),
	.WRN0_BUF(WRN0_BUF),
	.WRN1_BUF(WRN1_BUF)
);




always @(*) begin
	case(DATA_BUSX)
		`DATA_BUSX_REGA_DOUT:  DOUT_W = REGA_DOUT;
		default:               DOUT_W = ALU_R;
	endcase
	DOUT_L = {DOUT_W[7:0], 8'h00};
	HIGH_BYTEX = BYTEX & ADDR_BUF[0];
	DOUT_BUF   = HIGH_BYTEX ? DOUT_L : DOUT_W;
end

always @(*) begin
	case(ADDR_BUSX)
		`ADDR_BUSX_PC_A:      ADDR_BUF = PC_A;
		`ADDR_BUSX_ALU_R:     ADDR_BUF = ALU_R;
		`ADDR_BUSX_ALUB_DATA: ADDR_BUF = ALUB_DATA;
		default:              ADDR_BUF = HERE;
	endcase
end

endmodule