`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/*********************************************
* Debugging interface provides control signals
* to the instruction phase decoder and
* the opxMultiplexer
* It takes data input from
* - the program counter
* - condition code registers
* - interrupt return registers
* - register file
* - data bus
*
* It can write words to the bus, with an autoincrementing address
*
* Interface is over an 8-bit data bus to save pins
**/

module debugPort(
	
	input             CLK,
	input             RESET,
	input [7:0]      DEBUG_DIN,
	output reg [7:0] DEBUG_DOUT,
	input             DEBUG_RD,
	input             DEBUG_WR,
	output [15:0]    DEBUG_MEM_ADDR,
	output [15:0]    DEBUG_MEM_DATA_OUT,
	input [15:0]     DEBUG_MEM_DATA_IN,
	input             DEBUG_INCX,
	output [2:0]     DEBUG_OPX,
	output            DEBUG_TRIG_WR,
	output            DEBUG_TRIG_RD,
	output [3:0]     DEBUG_REGX,
	output [1:0]     DEBUG_PCX,
	output [1:0]     DEBUG_CCX,
	input [15:0]     DEBUG_DIN_DIN,
	input [15:0]     DEBUG_REGA_DATA,
	input [15:0]     DEBUG_CC_DATA,
	input [15:0]     DEBUG_PC_A_NEXT,
	input             DEBUG_DOUT_LDX
	
);

/**
* Simple assigns for now
**/
assign DEBUG_TRIG_WR = DEBUG_WR;
assign DEBUG_TRIG_RD = DEBUG_RD;



endmodule