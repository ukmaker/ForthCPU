`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module generalGroupDecoderTests;
	
reg  CLK;
reg  RESET;
reg [15:0] DIN;wire [15:0] INSTRUCTION;

wire FETCH, DECODE, EXECUTE, COMMIT;
wire EIX, DIX, RETIX, PC_ENX;


instructionPhaseDecoder decoder(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.DIN(DIN),
	.INSTRUCTION(INSTRUCTION),
	.PC_ENX(PC_ENX)
);

generalGroupDecoder generalGroupDecoderInst(
	.CLK(CLK),
	.RESET(RESET),
	.INSTRUCTION(INSTRUCTION),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	
	.EIX(EIX),
	.DIX(DIX),
	.RETIX(RETIX),
	.PC_ENX(PC_ENX)
);

reg [15:0] INSTR;

// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 0; 
	`TICK;
	RESET = 1;
	DIN = 16'h0000;

	`TICKTOCK;
	#5 RESET = 0;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;


	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGB_U8,8'haf};	
	`NFETCH(   1, 16'h0000, INSTR, "MOV RB,0x00af")
	`assert("PC_ENX", 1, PC_ENX)
	`assert("EIX",    0, EIX)
	`assert("DIX",    0, DIX)
	`assert("RETIX",  0, RETIX)
	`DECODE(  2, "")  
	`EXECUTE( 3, "") `TICKTOCK;
	`COMMIT(  4, "") `TICKTOCK;


	INSTR = {`GROUP_SYSTEM,3'b000, `GEN_OP_NOP, 8'h00 };	
	`NFETCH(   5, 16'h0000, INSTR, "NOP")
	`assert("PC_ENX", 1, PC_ENX)
	`assert("EIX",    0, EIX)
	`assert("DIX",    0, DIX)
	`assert("RETIX",  0, RETIX)
	`DECODE(  6, "")  
	`EXECUTE( 7, "") `TICKTOCK;
	`COMMIT(  8, "") `TICKTOCK;



	INSTR = {`GROUP_SYSTEM,3'b000, `GEN_OP_EI, 8'h00 };	
	`NFETCH(   9, 16'h0000, INSTR, "EI")
	`DECODE(  10, "")  
	`assert("PC_ENX", 1, PC_ENX)
	`assert("EIX",    1, EIX)
	`assert("DIX",    0, DIX)
	`assert("RETIX",  0, RETIX)
	`EXECUTE( 11, "") `TICKTOCK;
	`COMMIT(  12, "") `TICKTOCK;



	INSTR = {`GROUP_SYSTEM,3'b000, `GEN_OP_DI, 8'h00 };	
	`NFETCH(   13, 16'h0000, INSTR, "DI")
	`DECODE(  14, "")  	
	`assert("PC_ENX", 1, PC_ENX)
	`assert("EIX",    0, EIX)
	`assert("DIX",    1, DIX)
	`assert("RETIX",  0, RETIX)
	`EXECUTE( 15, "") `TICKTOCK;
	`COMMIT(  16, "") `TICKTOCK;



	INSTR = {`GROUP_SYSTEM,3'b000, `GEN_OP_RETI, 8'h00 };	
	`NFETCH(   17, 16'h0000, INSTR, "RETI")
	`DECODE(  18, "")  
	`assert("PC_ENX", 1, PC_ENX)
	`assert("EIX",    0, EIX)
	`assert("DIX",    0, DIX)
	`assert("RETIX",  1, RETIX)
	`EXECUTE( 19, "") `TICKTOCK;
	`COMMIT(  20, "") `TICKTOCK;



	INSTR = {`GROUP_SYSTEM,3'b000, `GEN_OP_HALT, 8'h00 };	
	`NFETCH(   21, 16'h0000, INSTR, "HALT")
	`DECODE(  22, "")  
	`assert("PC_ENX", 1, PC_ENX)
	`assert("EIX",    0, EIX)
	`assert("DIX",    0, DIX)
	`assert("RETIX",  0, RETIX)
	`EXECUTE( 23, "") `TICKTOCK;
	`COMMIT(  24, "") `TICKTOCK;
	`assert("PC_ENX", 0, PC_ENX)

end

endmodule