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
	/**
	* Bus cycle
	**/
	input [1:0] BUS_SEQX,
	
	/**
	* OPX
	**/
	input [2:0]  ADDR_BUSX,
	
	/**
	* Address
	**/
	input [15:0]      DEBUG_MA,
	input [15:0]      PC_A,
	input [15:0]      ALU_R,
	input [15:0]      ALUB_DATA,
	input [15:0]      HERE,
	output reg [15:0] ADDR_BUF,

	/**
	* Data
	**/
	input [15:0]     DEBUG_MD,
	input [15:0]     REGA_DOUT,
	input [1:0]      DATA_BUSX,
	input             BYTEX,
	output reg[15:0] DOUT_BUF,
	
	output reg HIGH_BYTEX,
	output RDN_BUF,
	output WRN0_BUF,
	output WRN1_BUF
	
);
	
reg [15:0] DOUT_W;
reg [15:0] DOUT_L;
wire[2:0]  ADDR_BUSX_R;

busSequencer sequencer(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	
	.A0(ADDR_BUF[0]),
	.BYTEX(BYTEX),
	.ADDR_BUSX(ADDR_BUSX),
	.ADDR_BUSX_R(ADDR_BUSX_R),
	
	.BUS_SEQX(BUS_SEQX),
	.RDN_BUF(RDN_BUF),
	.WRN0_BUF(WRN0_BUF),
	.WRN1_BUF(WRN1_BUF)
);

always @(*) begin
	case(DATA_BUSX)
		`DATA_BUSX_ALU_R:      DOUT_W = ALU_R;
		`DATA_BUSX_DEBUG:      DOUT_W = DEBUG_MD;
		`DATA_BUSX_REGA_DOUT:  DOUT_W = REGA_DOUT;
		default:               DOUT_W = ALU_R;
	endcase
	DOUT_L = {DOUT_W[7:0], 8'h00};
	HIGH_BYTEX = BYTEX & ADDR_BUF[0];
	DOUT_BUF   = HIGH_BYTEX ? DOUT_L : DOUT_W;
end

always @(*) begin
	case(ADDR_BUSX_R)
		`ADDR_BUSX_PC_A:      ADDR_BUF = PC_A;
		`ADDR_BUSX_ALU_R:     ADDR_BUF = ALU_R;
		`ADDR_BUSX_ALUB_DATA: ADDR_BUF = ALUB_DATA;
		`ADDR_BUSX_DEBUG:     ADDR_BUF = DEBUG_MA;
		`ADDR_BUSX_HERE:      ADDR_BUF = HERE;
		default:              ADDR_BUF = HERE;
	endcase
end

endmodule