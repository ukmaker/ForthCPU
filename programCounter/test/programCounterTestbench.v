`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module programCounterTestbench;
	
reg CLK;
reg RESET;
reg PC_ENX;

reg PC_LD_INT0X;
reg PC_LD_INT1X;
reg PC_BASEX;
reg [1:0] PC_OFFSETX;
reg PC_HEREX;

reg [15:0] PC_D;
reg [2:0]  PC_NEXTX;

wire [15:0] HERE;
wire [15:0] PC_A_NEXT;
wire [15:0] PC_A;

reg  [15:0] DIN;
wire [15:0] INSTRUCTION;
	
programCounter testInstance(
	.CLK(CLK),
	.RESET(RESET),
	.PC_ENX(PC_ENX),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.PC_HEREX(PC_HEREX),
	.PC_D(PC_D),
	.PC_LD_INT0X(PC_LD_INT0X),
	.PC_LD_INT1X(PC_LD_INT1X),
	.PC_BASEX(PC_BASEX),
	.PC_OFFSETX(PC_OFFSETX),
	.PC_NEXTX(PC_NEXTX),
	.HERE(HERE),
	.PC_A_NEXT(PC_A_NEXT),
	.PC_A(PC_A)
);

instructionPhaseDecoder phi(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.PC_ENX(PC_ENX),
	.INSTRUCTION(INSTRUCTION),
	.DIN(DIN)
);


// clk gen
always begin
	#50 CLK = ~CLK;
end


initial begin
	CLK = 0; 
	`TICK;
	RESET = 1;
	PC_ENX = 0;
	PC_D = 16'h1234;
	PC_HEREX = 0;
	DIN = 16'hfedc;

	`TICKTOCK;
	`TICK;
	RESET = 0; 

	PC_ENX = 1;

	PC_LD_INT0X = `PC_LD_INT0X_NONE;
	PC_LD_INT1X = `PC_LD_INT1X_NONE;
	PC_NEXTX    = `PC_NEXTX_NEXT;
	PC_BASEX    = `PC_BASEX_PC_A;
	PC_OFFSETX  = `PC_OFFSETX_2;
	`TOCK;	
	`TICKTOCK;
	`TICKTOCK;
	
	#10
	`mark(1)
	`assert("PC=0", 16'h0000, PC_A)
	

	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`mark(2)
	`assert("PC=2", 16'h0002, PC_A)
	
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`mark(3)
	`assert("PC=4", 16'h0004, PC_A)
	
	// Do a relative jump
	PC_OFFSETX = `PC_OFFSETX_PC_D;
	
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`mark(4)
	`assert("PC=0", 16'h1238, PC_A)

	// Do an absolute jump
	PC_OFFSETX = `PC_OFFSETX_PC_D;
	PC_BASEX   = `PC_BASEX_0;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`mark(5)
	`assert("PC=0", 16'h1234, PC_A)

	// Run for two cycles
	PC_BASEX = `PC_BASEX_PC_A;
	PC_OFFSETX = `PC_OFFSETX_2;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`mark(6)
	`assert("PC=1236", 16'h1236, PC_A)
	
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`mark(7)
	`assert("PC=1238", 16'h1238, PC_A)
	
	// Skip a word for a load
	PC_BASEX = `PC_BASEX_PC_A;
	PC_OFFSETX = `PC_OFFSETX_2;
	PC_HEREX = 1;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	PC_HEREX = 0;
	PC_OFFSETX = `PC_OFFSETX_2;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`mark(8)
	`assert("HERE=123a", 16'h123a, HERE)
	`assert("PC=123c", 16'h123c, PC_A)
	
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`mark(9)
	`assert("PC=123e", 16'h123e, PC_A)
	PC_OFFSETX = `PC_OFFSETX_2;
	
	// INT1
	PC_LD_INT1X = `PC_LD_INT1X_LD;
	PC_NEXTX    = `PC_NEXTX_INTV1;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`mark(10)
	`assert("PC=0008", 16'h0008, PC_A)
	// RETI INT1
	PC_LD_INT1X = `PC_LD_INT1X_NONE;
	PC_NEXTX    = `PC_NEXTX_INTR1;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`mark(11)
	`assert("PC=1240", 16'h1240, PC_A)
	
	// INT0
	PC_LD_INT0X = `PC_LD_INT0X_LD;
	PC_NEXTX    = `PC_NEXTX_INTV0;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`mark(12)
	`assert("PC=0004", 16'h0004, PC_A)
	// RETI INT1
	PC_LD_INT0X = `PC_LD_INT0X_NONE;
	PC_NEXTX    = `PC_NEXTX_INTR0;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`mark(13)
	`assert("PC=1242", 16'h1242, PC_A)


end

endmodule
