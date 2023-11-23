`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"


module busSequencerTests;
	
	reg CLK;
	reg RESET;
	
	wire STOPPED, FETCH, DECODE, EXECUTE, COMMIT;
	
	reg DEBUG_STOPX;
	
	reg A0;
	reg BYTEX;
	
	reg [1:0] BUS_SEQX;
	
	wire RDN_BUF;
	wire WRN0_BUF;
	wire WRN1_BUF;

	reg          PC_ENX;
	reg  [15:0] DIN;
	wire [15:0] INSTRUCTION;


busSequencer testInst(

	.CLK(CLK),
	.RESET(RESET),
	.DECODE(DECODE),
	.COMMIT(COMMIT),
	.A0(A0),
	.BYTEX(BYTEX),
	.BUS_SEQX(BUS_SEQX),
	.RDN_BUF(RDN_BUF),
	.WRN0_BUF(WRN0_BUF),
	.WRN1_BUF(WRN1_BUF)
);

instructionPhaseDecoder phi(
	.CLK(CLK),
	.RESET(RESET),
	.STOPPED(STOPPED),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.DIN(DIN),
	.PC_ENX(PC_ENX),
	.INSTRUCTION(INSTRUCTION),
	.DEBUG_STOPX(DEBUG_STOPX)
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
	PC_ENX = 0;
	#50;
	RESET = 1;
	`TICKTOCK;
	PC_ENX = 1;
	DEBUG_STOPX = 0;
	RESET = 0;
	`TICKTOCK;
	// FETCH high here
	// Run a normal instruction fetch cycle
	`TICKTOCK;
	BUS_SEQX = `BUS_SEQX_FETCH;
	// DECODE
	`TICKTOCK;
	// EXECUTE - run a memory read
	BUS_SEQX = `BUS_SEQX_READ;
	`TICKTOCK;
	// COMMIT
	`TICKTOCK;
	// FETCH high here
	// Run a normal instruction fetch cycle
	`TICKTOCK;
	BUS_SEQX = `BUS_SEQX_FETCH;
	// DECODE
	`TICKTOCK;
	// EXECUTE - run a memory write
	BUS_SEQX = `BUS_SEQX_WRITE;
	`TICKTOCK;
	// COMMIT
	`TICKTOCK;
	// FETCH high here
	// Run a normal instruction fetch cycle
	`TICKTOCK;
	BUS_SEQX = `BUS_SEQX_FETCH;
	// DECODE
	`TICKTOCK;
	// EXECUTE - run an internal cycle
	BUS_SEQX = `BUS_SEQX_NONE;
	`TICKTOCK;
	// COMMIT
	`TICKTOCK;
	// FETCH high here
	// Run a normal instruction fetch cycle
	`TICKTOCK;
	BUS_SEQX = `BUS_SEQX_FETCH;
	// DECODE
	`TICKTOCK;
	// EXECUTE - run an internal cycle
	BUS_SEQX = `BUS_SEQX_NONE;
	`TICKTOCK;
	// COMMIT
	
end

endmodule