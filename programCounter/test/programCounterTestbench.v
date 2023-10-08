`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module programCounterTestbench;
	
reg CLK;
reg RESET;
reg PC_ENX;
reg FETCH;

reg PC_LD_INT0X;
reg PC_LD_INT1X;
reg PC_BASEX;
reg PC_OFFSETX;

reg [15:0] PC_D;
reg [2:0] PC_NEXTX;

wire [15:0] PC_A_NEXT;
wire [15:0] PC_A;
	
programCounter testInstance(

.CLK(CLK),
.RESET(RESET),
.PC_ENX(PC_ENX),
.FETCH(FETCH),
.PC_D(PC_D),
.PC_LD_INT0X(PC_LD_INT0X),
.PC_LD_INT1X(PC_LD_INT1X),
.PC_BASEX(PC_BASEX),
.PC_OFFSETX(PC_OFFSETX),
.PC_NEXTX(PC_NEXTX),
.PC_A_NEXT(PC_A_NEXT),
.PC_A(PC_A)
);


// clk gen
always begin
	#50 CLK = ~CLK;
end


initial begin
	#(10) CLK = 0; 
	`TICK;
	RESET = 1;
	PC_ENX = 0;
	FETCH = 0;
	PC_D = 16'h1234;

	`TICKTOCK;
	RESET = 0;  
	PC_ENX = 1;
	FETCH = 1;
	PC_LD_INT0X = `PC_LD_INT0X_NONE;
	PC_LD_INT1X = `PC_LD_INT1X_NONE;
	PC_NEXTX    = `PC_NEXTX_NEXT;
	PC_BASEX    = `PC_BASEX_PC_A;
	PC_OFFSETX  = `PC_OFFSETX_2;
	
	`TICKTOCK;
	`assert("PC=2", 16'h0002, PC_A)
	
	`TICKTOCK;
	`assert("PC=4", 16'h0004, PC_A)
	
	// Do a relative jump
	PC_OFFSETX = `PC_OFFSETX_PC_D;
	
	`TICKTOCK;
	`assert("PC=0", 16'h1238, PC_A)

	// Do an absolute jump
	PC_OFFSETX = `PC_OFFSETX_PC_D;
	PC_BASEX   = `PC_BASEX_0;
	`TICKTOCK;
	`assert("PC=0", 16'h1234, PC_A)

	// Run for two cycles
	PC_BASEX = `PC_BASEX_PC_A;
	PC_OFFSETX = `PC_OFFSETX_2;
	`TICKTOCK;
	`assert("PC=1236", 16'h1236, PC_A)
	
	`TICKTOCK;
	`assert("PC=1238", 16'h1238, PC_A)
	
	// INT1
	PC_LD_INT1X = `PC_LD_INT1X_LD;
	PC_NEXTX    = `PC_NEXTX_INTV1;
	`TICKTOCK;
	`assert("PC=0008", 16'h0008, PC_A)
	// RETI INT1
	PC_LD_INT1X = `PC_LD_INT1X_NONE;
	PC_NEXTX    = `PC_NEXTX_INTR1;
	`TICKTOCK;
	`assert("PC=123a", 16'h123a, PC_A)
	
	// INT0
	PC_LD_INT0X = `PC_LD_INT0X_LD;
	PC_NEXTX    = `PC_NEXTX_INTV0;
	`TICKTOCK;
	`assert("PC=0004", 16'h0004, PC_A)
	// RETI INT1
	PC_LD_INT0X = `PC_LD_INT0X_NONE;
	PC_NEXTX    = `PC_NEXTX_INTR0;
	`TICKTOCK;
	`assert("PC=123c", 16'h123c, PC_A)


end

endmodule
