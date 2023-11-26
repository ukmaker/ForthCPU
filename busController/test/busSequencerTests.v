`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"


module busSequencerTests;
	
	reg CLK;
	reg RESET;
	
	wire STOPPED, FETCH, DECODE, EXECUTE, COMMIT;
	
	reg A0;
	reg BYTEX;
	reg [1:0]  BUS_SEQX;

	
	wire RDN_BUF;
	wire WRN0_BUF;
	wire WRN1_BUF;
	reg          HALTX;
	reg  [15:0] DIN;
	wire [15:0] INSTRUCTION;
	wire         PC_ENX;
	
	reg  DEBUG_STOPX;
	reg  DEBUG_STEP_REQ;
	wire DEBUG_STEP_ACK;
	wire DEBUG_ACTIVE;
	

busSequencer testInst(

	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.A0(A0),
	.BYTEX(BYTEX),
	.BUS_SEQX(BUS_SEQX),
	.RDN_BUF(RDN_BUF),
	.WRN0_BUF(WRN0_BUF),
	.WRN1_BUF(WRN1_BUF)
);

instructionPhaseDecoder instPhi(
	.CLK(CLK),
	.DEBUG_STOPX(DEBUG_STOPX),
	.DEBUG_STEP_REQ(DEBUG_STEP_REQ),
	.DIN(DIN),
	.HALTX(HALTX),
	.RESET(RESET),
	
	.COMMIT(COMMIT),
	.DECODE(DECODE),
	.DEBUG_STEP_ACK(DEBUG_STEP_ACK),
	.DEBUG_ACTIVE(DEBUG_ACTIVE),
	.EXECUTE(EXECUTE),
	.FETCH(FETCH),
	.INSTRUCTION(INSTRUCTION),
	.PC_ENX(PC_ENX),
	.STOPPED(STOPPED)
);

always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 0;
	RESET = 0;
	A0 = 0;
	
	BYTEX = 0;
	BUS_SEQX = `BUS_SEQX_NONE;
	DEBUG_STOPX = 0;
	DEBUG_STEP_REQ = 0;
	HALTX = 1;
	DIN = 16'h0000;
	
	#5;
	RESET = 1;
	`TICKTOCK;
	HALTX = 0;
	DEBUG_STOPX = 0;
	RESET = 0;
	`TICKTOCK;
	`TICKTOCK;
	// FETCH
	`mark(1)
	`assert("N-> RDN_BUF",    0,               RDN_BUF)
	`assert("WRN0_BUF",       1,               WRN0_BUF)
	`assert("WRN1_BUF",       1,               WRN1_BUF)
	
	`TICKTOCK;
	// DECODE	`mark(2)
	`assert("RDN_BUF",    1,               RDN_BUF)
	`assert("WRN0_BUF",   1,               WRN0_BUF)
	`assert("WRN1_BUF",   1,               WRN1_BUF)
	
	`TICKTOCK;
	// EXECUTE
	`mark(4)
	`assert("RDN_BUF",    1,               RDN_BUF)
	`assert("WRN0_BUF",   1,               WRN0_BUF)
	`assert("WRN1_BUF",   1,               WRN1_BUF)
	
	`TICKTOCK;
	`mark(5)
	// COMMIT
	`assert("RDN_BUF",    1,               RDN_BUF)
	`assert("WRN0_BUF",   1,               WRN0_BUF)
	`assert("WRN1_BUF",   1,               WRN1_BUF)


	// FETCH
	BUS_SEQX = `BUS_SEQX_READ;
	`TICKTOCK;
	`mark(6)
	`assert("N-> RDN_BUF",    0,               RDN_BUF)
	`assert("WRN0_BUF",   1,               WRN0_BUF)
	`assert("WRN1_BUF",   1,               WRN1_BUF)
	
	`TICKTOCK;
	// DECODE // Rising edge on decode
	`mark(7)
	`assert("RDN_BUF",    1,               RDN_BUF)
	`assert("WRN0_BUF",   1,               WRN0_BUF)
	`assert("WRN1_BUF",   1,               WRN1_BUF)
	
	`TICKTOCK;
	// EXECUTE
	`mark(9)
	`assert("RDN_BUF",    0,               RDN_BUF)
	`assert("WRN0_BUF",   1,               WRN0_BUF)
	`assert("WRN1_BUF",   1,               WRN1_BUF)
	
	`TICKTOCK;
	// COMMIT
	`mark(10)
	`assert("RDN_BUF",    1,               RDN_BUF)
	`assert("WRN0_BUF",   1,               WRN0_BUF)
	`assert("WRN1_BUF",   1,               WRN1_BUF)

	// FETCH
	BUS_SEQX = `BUS_SEQX_WRITE;
	`TICKTOCK;
	`mark(12)
	`assert("N-> RDN_BUF",    0,               RDN_BUF)
	`assert("WRN0_BUF",   1,               WRN0_BUF)
	`assert("WRN1_BUF",   1,               WRN1_BUF)
	
	`TICKTOCK;
	// DECODE
	`mark(13)
	`assert("RDN_BUF",    1,               RDN_BUF)
	`assert("WRN0_BUF",   1,               WRN0_BUF)
	`assert("WRN1_BUF",   1,               WRN1_BUF)
	
	`TICKTOCK	// EXECUTE
	`mark(15)
	`assert("RDN_BUF",    1,               RDN_BUF)
	`assert("WRN0_BUF",   1,               WRN0_BUF)
	`assert("WRN1_BUF",   1,               WRN1_BUF)
	
	`TICKTOCK;
	// COMMIT
	`mark(16)
	`assert("RDN_BUF",    1,               RDN_BUF)
	`assert("WRN0_BUF",   0,               WRN0_BUF)
	`assert("WRN1_BUF",   0,               WRN1_BUF)
	


end

endmodule