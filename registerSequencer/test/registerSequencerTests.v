`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module registerSequencerTests;
	
	reg CLK;
	reg RESET;
	
	wire STOPPED;
	wire FETCH;
	wire DECODE;
	wire EXECUTE;
	wire COMMIT;
	
	reg [3:0] REG_SEQX;
	reg BYTEX;
	reg A0;
	reg HALTX;
	reg DEBUG_STOPX;
	reg DEBUG_STEP_REQ;
	
	wire DEBUG_ACTIVE;
	wire DEBUG_STEP_ACK;
	
	wire REGA_EN;
	wire REGA_WEN;
	wire REGB_EN;
	wire REGB_WEN;

	reg  [15:0] DIN;
	wire         PC_ENX;
	wire [15:0] INSTRUCTION;

	
registerSequencer testInst(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH), 
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.REG_SEQX(REG_SEQX),
	.BYTEX(BYTEX),
	.A0(A0),
	.REGA_EN(REGA_EN),
	.REGA_WEN(REGA_WEN),
	.REGB_EN(REGB_EN),
	.REGB_WEN(REGB_WEN)
);

instructionPhaseDecoder decoder(
	.CLK(CLK),
	.RESET(RESET),
	.DIN(DIN),
	.HALTX(HALTX),
	.PC_ENX(PC_ENX),
	.DEBUG_STOPX(DEBUG_STOPX),
	.DEBUG_STEP_REQ(DEBUG_STEP_REQ),
	.DEBUG_STEP_ACK(DEBUG_STEP_ACK),
	.DEBUG_ACTIVE(DEBUG_ACTIVE),
	.STOPPED(STOPPED),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.INSTRUCTION(INSTRUCTION)
);



// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 0; 
	`TICK;
	RESET = 1;
	DIN = 16'h0000;
	DEBUG_STOPX = 0;
	HALTX = 0;
	DEBUG_STEP_REQ = 0;
	REG_SEQX = `REG_SEQX_NONE;
	BYTEX = `BYTEX_WORD;
	A0 = 0;
	
	`TICKTOCK;
	RESET = 0;
	
	#95;
	`mark(0)
	`assert("FETCH cycle", 1, FETCH)
	
	// Fetch cycle
	`TICKTOCK;
	`mark(1)
	`assert("END of FETCH cycle", 0, FETCH)
	`assert("END of FETCH cycle", 1, DECODE)
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Decode
	`mark(2)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	//Execute
	`mark(3)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Commit
	`mark(4)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)

	REG_SEQX = `REG_SEQX_RDA_RDB;
	BYTEX = `BYTEX_WORD;
	A0 = 0;
	// Fetch cycle
	`mark(5)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Decode
	`mark(6)
	`TICKTOCK;
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      1, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	//Execute
	`mark(7)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Commit
	`mark(8)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	
	REG_SEQX = `REG_SEQX_RDA_RDB;
	BYTEX    = `BYTEX_BYTE;
	// Should ignore byte for Read Read
	// Fetch cycle
	`mark(9)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Decode
	`mark(10)
	`TICKTOCK;
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      1, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	//Execute
	`mark(11)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Commit
	`mark(12)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	
	
	REG_SEQX = `REG_SEQX_LDA_RDB;
	BYTEX    = `BYTEX_WORD;
	// Should update RA word
	// Fetch cycle
	`mark(13)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Decode
	`mark(14)
	`TICKTOCK;
	`TICK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      1, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	//Execute
	`mark(15)
	`TOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Commit
	`mark(16)
	`TICKTOCK;
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGA_WEN",     1, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	REG_SEQX = `REG_SEQX_LDA_RDB;
	BYTEX    = `BYTEX_BYTE;
	A0 = 0;
	// Should update RA low byte
	// Fetch cycle
	`mark(17)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Decode
	`mark(18)
	`TICKTOCK;
	`TICK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      1, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	//Execute
	`mark(19)
	`TOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Commit
	`mark(20)
	`TICKTOCK;
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGA_WEN",     1, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)

	REG_SEQX = `REG_SEQX_LDA_RDB;
	BYTEX    = `BYTEX_BYTE;
	A0 = 1;
	// Should update RA high byte
	// Fetch cycle
	`mark(21)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Decode
	`mark(22)
	`TICKTOCK;
	`TICK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      1, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	//Execute
	`mark(23)
	`TOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Commit
	`mark(24)
	`TICKTOCK;
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGA_WEN",     1, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)

	REG_SEQX = `REG_SEQX_LDA_UPB;
	BYTEX    = `BYTEX_WORD;
	A0 = 0;
	// Should update RA and RB word
	// Fetch cycle
	`mark(25)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Decode
	`mark(26)
	`TICKTOCK;
	`TICK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      1, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	//Execute
	`mark(27)
	`TOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Commit
	`mark(28)
	`TICKTOCK;
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGA_WEN",     1, REGA_WEN)
	`assert("REGB_EN",      1, REGB_EN)
	`assert("REGB_WEN",     1, REGB_WEN)

	REG_SEQX = `REG_SEQX_LDA_UPB;
	BYTEX    = `BYTEX_BYTE;
	A0 = 0;
	// Should update RA low byte and RB word
	// Fetch cycle
	`mark(29)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Decode
	`mark(30)
	`TICKTOCK;
	`TICK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      1, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	//Execute
	`mark(31)
	`TOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Commit
	`mark(32)
	`TICKTOCK;
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGA_WEN",     1, REGA_WEN)
	`assert("REGB_EN",      1, REGB_EN)
	`assert("REGB_WEN",     1, REGB_WEN)

	REG_SEQX = `REG_SEQX_LDA_UPB;
	BYTEX    = `BYTEX_BYTE;
	A0 = 1;
	// Should update RA high byte and RB word
	// Fetch cycle
	`mark(33)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Decode
	`mark(34)
	`TICKTOCK;
	`TICK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      1, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	//Execute
	`mark(35)
	`TOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Commit
	`mark(36)
	`TICKTOCK;
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGA_WEN",     1, REGA_WEN)
	`assert("REGB_EN",      1, REGB_EN)
	`assert("REGB_WEN",     1, REGB_WEN)


	REG_SEQX = `REG_SEQX_RDA_UPB;
	BYTEX    = `BYTEX_WORD;
	A0 = 1;
	// Should read RA and update RB
	// Fetch cycle
	`mark(37)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Decode
	`mark(38)
	`TICKTOCK;
	`TICK;
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      1, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	//Execute
	`mark(39)
	`TOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Commit
	`mark(40)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      1, REGB_EN)
	`assert("REGB_WEN",     1, REGB_WEN)



	REG_SEQX = `REG_SEQX_LDA_IMM;
	BYTEX    = `BYTEX_WORD;
	A0 = 1;
	// Should write A
	// Fetch cycle
	`mark(41)
	`TICKTOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Decode
	`mark(42)
	`TICKTOCK;
	`TICK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	//Execute
	`mark(43)
	`TOCK;
	`assert("REGA_EN",      0, REGA_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)
	// Commit
	`mark(44)
	`TICKTOCK;
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGA_WEN",     1, REGA_WEN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGB_WEN",     0, REGB_WEN)


end

endmodule