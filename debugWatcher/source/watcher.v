`include "../../constants.v"

/**************************************************
* Watcher function and configuration registers
***************************************************/

module watcher (
	
	input CLK,
	input RESET,
	input DECODE, COMMIT,
	// Processor signals
	input [15:0] ADDR,
	// debugger 
	input         DEBUG_WR,
	input         DEBUG_EN_WATCH_START_AL,
	input         DEBUG_EN_WATCH_START_AH,
	input         DEBUG_EN_WATCH_END_AL,
	input         DEBUG_EN_WATCH_END_AH,
	input         DEBUG_WATCH_ENX,
	input [7:0]  DEBUG_DIN,
	
	output        DEBUG_IN_WATCH

);

wire [15:0] DEBUG_WATCH_START_ADDR;
wire [15:0] DEBUG_WATCH_END_ADDR;

/**************************************************************
* Configuration registers
**************************************************************/
wordRegister watchStartReg (

	.CLK(DEBUG_WRN),
	.RESET(RESET),
	.EN0(DEBUG_EN_WATCH_START_AL),
	.EN1(DEBUG_EN_WATCH_START_AH),
	.LD(1'b1),
	.DIN(DEBUG_DIN),
	.DOUT(DEBUG_WATCH_START_ADDR)

);

wordRegister watchEndReg (

	.CLK(DEBUG_WRN),
	.RESET(RESET),
	.EN0(DEBUG_EN_WATCH_END_AL),
	.EN1(DEBUG_EN_WATCH_END_AH),
	.LD(1'b1),
	.DIN(DEBUG_DIN),
	.DOUT(DEBUG_WATCH_END_ADDR)

);

addressWatcher watcherInst(
	.CLK(CLK),
	.RESET(RESET),
	.DECODE(DECODE),
	.COMMIT(COMMIT),
	.ADDR(ADDR),
	.DEBUG_WATCH_ENX(DEBUG_WATCH_ENX),
	.DEBUG_WATCH_START_ADDR(DEBUG_WATCH_START_ADDR),
	.DEBUG_WATCH_END_ADDR(DEBUG_WATCH_END_ADDR),
	.DEBUG_IN_WATCH(DEBUG_IN_WATCH)
);


endmodule