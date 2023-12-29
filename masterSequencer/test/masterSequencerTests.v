`timescale 1 ns / 1 ns

`include "../../constants.v"
`include "../../testSetup.v"


module masterSequencerTests;
	
	reg CLK;
	reg RESET;
	// input DEBUG_MODE_RESET;
	reg DEBUG_REQ;
	reg DEBUG_MODE_STOP;
	reg DEBUG_MODE_INC;
	reg DEBUG_AT_BKP;
	reg DEBUG_IN_WATCH;
	reg HALTX;
	
	wire STOPPED;
	wire FETCH;
	wire DECODE;
	wire EXECUTE;
	wire COMMIT;
	
	wire DEBUG_ACK;
	wire DEBUG_MR_ADDR_INCX;
	wire HALTED;
	wire PC_ENX;
	
	wire DEBUG_ACTIVE;
	
	masterSequencer testArticle(
		.CLK(CLK),
		.RESET(RESET),
		// input DEBUG_MODE_RESET;
		.DEBUG_REQ(DEBUG_REQ),
		.DEBUG_MODE_STOP(DEBUG_MODE_STOP),
		.DEBUG_MODE_INC(DEBUG_MODE_INC),
		.DEBUG_AT_BKP(DEBUG_AT_BKP),
		.DEBUG_IN_WATCH(DEBUG_IN_WATCH),
		.HALTX(HALTX),
		
		.STOPPED(STOPPED),
		.FETCH(FETCH),
		.DECODE(DECODE),
		.EXECUTE(EXECUTE),
		.COMMIT(COMMIT),
		
		.DEBUG_ACK(DEBUG_ACK),
		.DEBUG_MR_ADDR_INCX(DEBUG_MR_ADDR_INCX),
		.HALTED(HALTED),
		.PC_ENX(PC_ENX),
		
		.DEBUG_ACTIVE(DEBUG_ACTIVE)
	);

`define assertDebugStopped \
	`assert("STOPPED",       1'b1, STOPPED) \
	`assert("FETCH",         1'b0, FETCH) \
	`assert("DECODE",        1'b0, DECODE) \
	`assert("EXECUTE",       1'b0, EXECUTE) \
	`assert("COMMIT",        1'b0, COMMIT) \
	`assert("PC_ENX",        1'b0, PC_ENX) \
	`assert("DEBUG_ACTIVE",  1'b1, DEBUG_ACTIVE) \
	`assert("DEBUG_ACK",     1'b0, DEBUG_ACK)

`define assertDebugAckStopped \
	`assert("STOPPED",       1'b1, STOPPED) \
	`assert("FETCH",         1'b0, FETCH) \
	`assert("DECODE",        1'b0, DECODE) \
	`assert("EXECUTE",       1'b0, EXECUTE) \
	`assert("COMMIT",        1'b0, COMMIT) \
	`assert("PC_ENX",        1'b0, PC_ENX) \
	`assert("DEBUG_ACTIVE",  1'b1, DEBUG_ACTIVE) \
	`assert("DEBUG_ACK",     1'b1, DEBUG_ACK)
	
`define assertDebugFetch \
	`assert("STOPPED",       1'b0, STOPPED) \
	`assert("FETCH",         1'b1, FETCH) \
	`assert("DECODE",        1'b0, DECODE) \
	`assert("EXECUTE",       1'b0, EXECUTE) \
	`assert("COMMIT",        1'b0, COMMIT) \
	`assert("PC_ENX",        1'b0, PC_ENX) \
	`assert("DEBUG_ACTIVE",  1'b1, DEBUG_ACTIVE) \
	`assert("DEBUG_ACK",     1'b0, DEBUG_ACK)
	
`define assertDebugDecode \
	`assert("STOPPED",       1'b0, STOPPED) \
	`assert("FETCH",         1'b0, FETCH) \
	`assert("DECODE",        1'b1, DECODE) \
	`assert("EXECUTE",       1'b0, EXECUTE) \
	`assert("COMMIT",        1'b0, COMMIT) \
	`assert("PC_ENX",        1'b0, PC_ENX) \
	`assert("DEBUG_ACTIVE",  1'b1, DEBUG_ACTIVE) \
	`assert("DEBUG_ACK",     1'b0, DEBUG_ACK)
	
`define assertDebugExecute \
	`assert("STOPPED",       1'b0, STOPPED) \
	`assert("FETCH",         1'b0, FETCH) \
	`assert("DECODE",        1'b0, DECODE) \
	`assert("EXECUTE",       1'b1, EXECUTE) \
	`assert("COMMIT",        1'b0, COMMIT) \
	`assert("PC_ENX",        1'b0, PC_ENX) \
	`assert("DEBUG_ACTIVE",  1'b1, DEBUG_ACTIVE) \
	`assert("DEBUG_ACK",     1'b0, DEBUG_ACK)

`define assertDebugCommit \
	`assert("STOPPED",       1'b0, STOPPED) \
	`assert("FETCH",         1'b0, FETCH) \
	`assert("DECODE",        1'b0, DECODE) \
	`assert("EXECUTE",       1'b0, EXECUTE) \
	`assert("COMMIT",        1'b1, COMMIT) \
	`assert("PC_ENX",        1'b0, PC_ENX) \
	`assert("DEBUG_ACTIVE",  1'b1, DEBUG_ACTIVE) \
	`assert("DEBUG_ACK",     1'b0, DEBUG_ACK)



`define assertStopped \
	`assert("STOPPED",       1'b1, STOPPED) \
	`assert("FETCH",         1'b0, FETCH) \
	`assert("DECODE",        1'b0, DECODE) \
	`assert("EXECUTE",       1'b0, EXECUTE) \
	`assert("COMMIT",        1'b0, COMMIT) \
	`assert("PC_ENX",        1'b0, PC_ENX) \
	`assert("DEBUG_ACTIVE",  1'b0, DEBUG_ACTIVE) \
	`assert("DEBUG_ACK",     1'b0, DEBUG_ACK)

`define assertFetch \
	`assert("STOPPED",       1'b0, STOPPED) \
	`assert("FETCH",         1'b1, FETCH) \
	`assert("DECODE",        1'b0, DECODE) \
	`assert("EXECUTE",       1'b0, EXECUTE) \
	`assert("COMMIT",        1'b0, COMMIT) \
	`assert("DEBUG_ACTIVE",  1'b0, DEBUG_ACTIVE) \
	`assert("DEBUG_ACK",     1'b0, DEBUG_ACK)
	
`define assertDecode \
	`assert("STOPPED",       1'b0, STOPPED) \
	`assert("FETCH",         1'b0, FETCH) \
	`assert("DECODE",        1'b1, DECODE) \
	`assert("EXECUTE",       1'b0, EXECUTE) \
	`assert("COMMIT",        1'b0, COMMIT) \
	`assert("DEBUG_ACTIVE",  1'b0, DEBUG_ACTIVE) \
	`assert("DEBUG_ACK",     1'b0, DEBUG_ACK)

`define assertExecute \
	`assert("STOPPED",       1'b0, STOPPED) \
	`assert("FETCH",         1'b0, FETCH) \
	`assert("DECODE",        1'b0, DECODE) \
	`assert("EXECUTE",       1'b1, EXECUTE) \
	`assert("COMMIT",        1'b0, COMMIT) \
	`assert("DEBUG_ACTIVE",  1'b0, DEBUG_ACTIVE) \
	`assert("DEBUG_ACK",     1'b0, DEBUG_ACK)

`define assertCommit \
	`assert("STOPPED",       1'b0, STOPPED) \
	`assert("FETCH",         1'b0, FETCH) \
	`assert("DECODE",        1'b0, DECODE) \
	`assert("EXECUTE",       1'b0, EXECUTE) \
	`assert("COMMIT",        1'b1, COMMIT) \
	`assert("DEBUG_ACTIVE",  1'b0, DEBUG_ACTIVE) \
	`assert("DEBUG_ACK",     1'b0, DEBUG_ACK)

always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 1;
	RESET = 1;
	DEBUG_REQ = 0;
	DEBUG_MODE_STOP = 0;
	DEBUG_MODE_INC = 0;
	DEBUG_AT_BKP = 0;
	DEBUG_IN_WATCH = 0;
	HALTX = 0;
	#10;
	`TICKTOCK;
	`assertStopped
	`TICKTOCK;
	RESET = 0;
	`TICKTOCK;
	`assertFetch
	`TICKTOCK;
	`assertDecode
	`TICKTOCK;
	`assertExecute
	`TICKTOCK;
	`assertCommit
	`TICKTOCK;
	`assertFetch
	// debug
	DEBUG_MODE_STOP = 1;
	`TICKTOCK;
	`assertDebugStopped
	`TICKTOCK;
	`assertDebugStopped
	// Trigger a debug step
	$display("Debug req");
	DEBUG_REQ = 1;
	`TICKTOCK;
	`assertDebugDecode
	`TICKTOCK;
	`assertDebugExecute
	`TICKTOCK;
	`assertDebugCommit
	`TICKTOCK;
	`assertDebugFetch	
	`TICKTOCK;
	`assertDebugAckStopped	
	`TICKTOCK;
	`assertDebugStopped	
	`TICKTOCK;
	`assertDebugStopped	
	`TICKTOCK;
	`assertDebugStopped	
	DEBUG_REQ = 0;
	`TICKTOCK;
	`assertDebugStopped	
	// Trigger another debug step
	$display("Debug req 2");
	DEBUG_REQ = 1;
	`TICKTOCK;
	`assertDebugDecode
	`TICKTOCK;
	`assertDebugExecute
	`TICKTOCK;
	`assertDebugCommit
	`TICKTOCK;
	`assertDebugFetch	
	`TICKTOCK;
	`assertDebugAckStopped	
	`TICKTOCK;
	`assertDebugStopped	
	`TICKTOCK;
	`assertDebugStopped	
	`TICKTOCK;
	`assertDebugStopped	
	DEBUG_REQ = 0;
	`TICKTOCK;
	`assertDebugStopped	
	// Normal running
	DEBUG_MODE_STOP = 0;
	`TICKTOCK;
	`TICKTOCK;
	`assertDecode
	`TICKTOCK;
	`assertExecute
	`TICKTOCK;
	`assertCommit
	`TICKTOCK;
	`assertFetch
	`TICKTOCK;
	`assertDecode
	`TICKTOCK;
	`assertExecute
	`TICKTOCK;
	`assertCommit
	`TICKTOCK;
	`assertFetch
	// Stop for breakpoint
	DEBUG_AT_BKP = 1;
	`TICKTOCK;
	`assertDebugStopped	
	`TICKTOCK;
	`assertDebugStopped	
	`TICKTOCK;
	`assertDebugStopped	
	`TICKTOCK;
	`assertDebugStopped		
	// Trigger another debug step
	$display("Debug req 2");
	DEBUG_REQ = 1;
	`TICKTOCK;
	`assertDebugDecode
	`TICKTOCK;
	`assertDebugExecute
	`TICKTOCK;
	`assertDebugCommit
	`TICKTOCK;
	`assertDebugFetch	
	`TICKTOCK;
	`assertDebugAckStopped	
	`TICKTOCK;
	`assertDebugStopped	
	`TICKTOCK;
	`assertDebugStopped	
	`TICKTOCK;
	`assertDebugStopped	
	DEBUG_REQ = 0;
	`TICKTOCK;
	`assertDebugStopped	
	// Normal running
	DEBUG_AT_BKP = 0;
	`TICKTOCK;
	`TICKTOCK;
	`assertDecode
	`TICKTOCK;
	`assertExecute
	`TICKTOCK;
	`assertCommit
	`TICKTOCK;
	`assertFetch
	`TICKTOCK;
	`assertDecode
	`TICKTOCK;
	`assertExecute
	`TICKTOCK;
	`assertCommit
	`TICKTOCK;
	`assertFetch

	// Stop for watch
	DEBUG_IN_WATCH = 1;
	`TICKTOCK;
	`assertDebugStopped	
	`TICKTOCK;
	`assertDebugStopped	
	`TICKTOCK;
	`assertDebugStopped	
	`TICKTOCK;
	`assertDebugStopped		
	// Trigger another debug step
	$display("Debug req 3");
	DEBUG_REQ = 1;
	`TICKTOCK;
	`assertDebugDecode
	`TICKTOCK;
	`assertDebugExecute
	`TICKTOCK;
	`assertDebugCommit
	`TICKTOCK;
	`assertDebugFetch	
	`TICKTOCK;
	`assertDebugAckStopped	
	`TICKTOCK;
	`assertDebugStopped	
	`TICKTOCK;
	`assertDebugStopped	
	`TICKTOCK;
	`assertDebugStopped	
	DEBUG_REQ = 0;
	`TICKTOCK;
	`assertDebugStopped	
	// Normal running
	DEBUG_IN_WATCH = 0;
	`TICKTOCK;
	`TICKTOCK;
	`assertDecode
	`TICKTOCK;
	`assertExecute
	`TICKTOCK;
	`assertCommit
	`TICKTOCK;
	`assertFetch
	`TICKTOCK;
	`assertDecode
	`TICKTOCK;
	`assertExecute
	`TICKTOCK;
	`assertCommit
	`TICKTOCK;
	`assertFetch
end

endmodule
