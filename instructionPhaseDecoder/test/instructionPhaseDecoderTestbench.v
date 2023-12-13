`timescale 1 ns / 1 ns

`include "../../constants.v"
`include "../../testSetup.v"


module instruction_phase_decoder_testbench;

parameter CLOCK_CYCLE = 20;

wire STOPPED, FETCH, DECODE, EXECUTE, COMMIT;

reg CLK, RESET;

reg HALTX;
wire PC_ENX;
reg DEBUG_STOP;
reg DEBUG_MODE;
reg DEBUG_STEP_REQ;
wire DEBUG_ACTIVE;
wire DEBUG_STEP_ACK;


instructionPhaseDecoder ipd(
	.CLK(CLK),
	.RESET(RESET),
	
	.HALTX(HALTX),
	.PC_ENX(PC_ENX),
	
	.DEBUG_MODE(DEBUG_MODE),
	.DEBUG_STOP(DEBUG_STOP),
	.DEBUG_STEP_REQ(DEBUG_STEP_REQ),
	.DEBUG_STEP_ACK(DEBUG_STEP_ACK),
	.DEBUG_ACTIVE(DEBUG_ACTIVE),
	
	.STOPPED(STOPPED),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT)
);

// clk gen
always
	#50 CLK = ~CLK;
	
initial begin
	
	CLK = 0;
	RESET = 0;
	HALTX = 0;
	DEBUG_STOP = 0;
	DEBUG_MODE = 0; 
	DEBUG_STEP_REQ = 0;
	`TICKTOCK;
	RESET = 1;
	`TICKTOCK;
	RESET = 0;
	`TICKTOCK;
	`assert("FETCH", 1'b1, FETCH)
	`TICKTOCK;
	`assert("DECODE", 1'b1, DECODE)
	`TICKTOCK;
	`assert("EXECUTE", 1'b1, EXECUTE)
	`TICKTOCK;
	`assert("COMMIT", 1'b1, COMMIT)
	`TICKTOCK;
	`assert("FETCH", 1'b1, FETCH)
	`TICKTOCK;
	// ignore debug stop until end of the cycle
	DEBUG_STOP = 1;
	`assert("DECODE", 1'b1, DECODE)
	`TICKTOCK;
	`assert("EXECUTE", 1'b1, EXECUTE)
	`TICKTOCK;
	`assert("COMMIT", 1'b1, COMMIT)
	`TICKTOCK;
	`assert("FETCH", 1'b1, FETCH)
	`TICKTOCK;
	`assert("STOPPED", 1'b1, STOPPED)
	`TICKTOCK;
	`assert("STOPPED", 1'b1, STOPPED)
	`TICKTOCK;
	`assert("STOPPED", 1'b1, STOPPED)
	`TICKTOCK;
	// Run a debug cycle
	DEBUG_STEP_REQ = 1;
	DEBUG_MODE = 1;
	`TICKTOCK;
	`assert("DECODE", 1'b1, DECODE)
	`TICKTOCK;
	`assert("EXECUTE", 1'b1, EXECUTE)
	`TICKTOCK;
	`assert("COMMIT", 1'b1, COMMIT)
	`TICKTOCK;
	`assert("FETCH", 1'b1, FETCH)
	`TICKTOCK;
	`assert("DEBUG_STEP_ACK", 1'b1, DEBUG_STEP_ACK)
	`assert("STOPPED", 1'b1, STOPPED)
	`TICKTOCK;
	`assert("STOPPED", 1'b1, STOPPED)
	`TICKTOCK;
	DEBUG_STEP_REQ = 0;
	`TICKTOCK;
	`assert("DEBUG_STEP_ACK", 1'b0, DEBUG_STEP_ACK)
	`TICKTOCK;
	// Run a single step cycle
	DEBUG_STEP_REQ = 1;
	DEBUG_MODE = 0;
	`TICKTOCK;
	`assert("DECODE", 1'b1, DECODE)
	`TICKTOCK;
	`assert("EXECUTE", 1'b1, EXECUTE)
	`TICKTOCK;
	`assert("COMMIT", 1'b1, COMMIT)
	`TICKTOCK;
	`assert("FETCH", 1'b1, FETCH)
	`TICKTOCK;
	`assert("DEBUG_STEP_ACK", 1'b1, DEBUG_STEP_ACK)
	`assert("STOPPED", 1'b1, STOPPED)
	`TICKTOCK;
	`assert("STOPPED", 1'b1, STOPPED)
	`TICKTOCK;
	DEBUG_STEP_REQ = 0;
	`TICKTOCK;
	`assert("DEBUG_STEP_ACK", 1'b0, DEBUG_STEP_ACK)
	`TICKTOCK;
	// back to normal running
	DEBUG_STOP = 0;
	`TICKTOCK;
	`assert("STOPPED", 1'b1, STOPPED)
	`TICKTOCK;
	`assert("DECODE", 1'b1, DECODE)
	`TICKTOCK;
	`assert("EXECUTE", 1'b1, EXECUTE)
	`TICKTOCK;
	`assert("COMMIT", 1'b1, COMMIT)
	`TICKTOCK;
	`assert("FETCH", 1'b1, FETCH)
	
end

endmodule