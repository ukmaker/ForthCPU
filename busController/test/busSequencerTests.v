`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"


module busSequencerTests;
	
	reg CLK;
	reg RESET;
	
	wire STOPPED, FETCH, DECODE, EXECUTE, COMMIT;
	
	reg A0;
	reg BYTEX;
	
	reg [2:0]  ADDR_BUSX_MUX;
	reg [1:0]  BUS_SEQX;
	reg [1:0]  PC_BASEX_MUX;
	reg [1:0]  PC_OFFSETX_MUX;
	
	wire [2:0]  ADDR_BUSX;
	wire [1:0]  PC_BASEX;
	wire [1:0]  PC_OFFSETX;
	
	wire RDN_BUF;
	wire WRN0_BUF;
	wire WRN1_BUF;

	reg          HALTX;
	reg  [15:0] DIN;
	wire [15:0] INSTRUCTION;
	wire         PC_ENX;

	
	reg DEBUG_STOPX;
	reg DEBUG_STEP_REQ;
	wire DEBUG_STEP_ACK;
	wire DEBUG_ACTIVE;
	

busSequencer testInst(

	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.DEBUG_ACTIVE(DEBUG_ACTIVE),
	.A0(A0),
	.ADDR_BUSX_MUX(ADDR_BUSX_MUX),
	.BYTEX(BYTEX),
	.BUS_SEQX(BUS_SEQX),
	.PC_BASEX_MUX(PC_BASEX_MUX),
	.PC_OFFSETX_MUX(PC_OFFSETX_MUX),
	.ADDR_BUSX(ADDR_BUSX),
	.PC_BASEX(PC_BASEX),
	.PC_OFFSETX(PC_OFFSETX),
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
	ADDR_BUSX_MUX = `ADDR_BUSX_PC_A;
	PC_BASEX_MUX = `PC_BASEX_PC_A;
	PC_OFFSETX_MUX = `PC_OFFSETX_0;
	
	BYTEX = 0;
	BUS_SEQX = `BUS_SEQX_NONE;
	DEBUG_STOPX = 0;
	DEBUG_STEP_REQ = 0;
	HALTX = 1;
	DIN = 16'h0000;
	
	#50;
	RESET = 1;
	`TICKTOCK;
	HALTX = 0;
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