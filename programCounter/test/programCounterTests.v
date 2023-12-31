`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module programCounterTestbench;

	reg CLK;
	reg RESET;
	reg HALTX;
	reg DEBUG_MODE;
	reg DEBUG_STOP;
	reg DEBUG_STEP_REQ;
	
	reg PC_LD_INT0X;
	reg PC_LD_INT1X;
	reg [1:0] PC_BASEX;
	reg [1:0] PC_OFFSETX;
	reg [2:0] PC_NEXTX;
	
	reg DEBUG_LD_BKP_EN;
	reg DEBUG_EN_BKPX;
	reg [15:0] DIN_BKP;
	
	reg [15:0] REGB_DOUT;
	reg [15:0] DIN;
	
	wire [15:0] HERE;
	wire [15:0] PC_A_NEXT;
	wire [15:0] PC_A;
	
	wire STOPPED, FETCH, DECODE, EXECUTE, COMMIT;
	wire DEBUG_STEP_ACK;
	wire PC_ENX;
	wire DEBUG_AT_BKP;

programCounter testInst (
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.COMMIT(COMMIT),
	.DECODE(DECODE),
	.PC_ENX(PC_ENX),
	.PC_LD_INT0X(PC_LD_INT0X),
	.PC_LD_INT1X(PC_LD_INT1X),
	.PC_BASEX(PC_BASEX),
	.PC_OFFSETX(PC_OFFSETX),
	.PC_NEXTX(PC_NEXTX),
	.DEBUG_LD_BKP_EN(DEBUG_LD_BKP_EN),
	.DEBUG_EN_BKPX(DEBUG_EN_BKPX),
	.DIN_BKP(DIN_BKP),

	.REGB_DOUT(REGB_DOUT),
	.DIN(DIN),
	.HERE(HERE),
	.PC_A_NEXT(PC_A_NEXT),
	.PC_A(PC_A),
	.DEBUG_AT_BKP(DEBUG_AT_BKP)
);

instructionPhaseDecoder phi(
	.CLK(CLK),
	.RESET(RESET),
	.HALTX(HALTX),
	.DEBUG_AT_BKP(DEBUG_AT_BKP),
	.DEBUG_STOP(DEBUG_STOP),
	.DEBUG_MODE(DEBUG_MODE),
	.DEBUG_STEP_REQ(DEBUG_STEP_REQ),
	
	.STOPPED(STOPPED),
	.FETCH(FETCH),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.DECODE(DECODE),
	
	.DEBUG_STEP_ACK(DEBUG_STEP_ACK),

	.PC_ENX(PC_ENX)

);

`define CYCLE #400

`define PC_INST(addr0, din, regb, base, offset, next, addr1) \
  `step(1, "FETCH") \
  #10; \
  `asserth("PC_A", addr0, PC_A) \
  `asserth("HERE", addr0+2, HERE) \
  #90; \
  `step(2, "DECODE") \
  #100; \
  PC_BASEX   = base; \
  PC_OFFSETX = offset; \
  PC_NEXTX   = next; \
  DIN        = din; \
  REGB_DOUT  = regb; \
  `step(3, "EXECUTE") \
  #100; \
  `step(4, "COMMIT") \
  #100; \
  \
  `step(5, "FETCH") \
  #10; \
  `asserth("PC_A", addr1, PC_A) \
  `asserth("HERE", addr1+2, HERE) \
  #90; \
  `step(6, "DECODE") \
  #100; \
  PC_BASEX   = `PC_BASEX_PC_A; \
  PC_OFFSETX = `PC_OFFSETX_2; \
  PC_NEXTX   = `PC_NEXTX_NEXT; \
  `step(7, "EXECUTE") \
  #100; \
  `step(8, "COMMIT") \
  #100; 
   

always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK               = 1;
	RESET             = 1;
	HALTX             = 1'b0;
	PC_LD_INT0X       = 1'b0;
	PC_LD_INT1X       = 1'b0;
	PC_BASEX          = 2'b00;
	PC_OFFSETX        = `PC_OFFSETX_0;
	PC_NEXTX          = 3'b000;
	DEBUG_MODE        = 1'b0;
	DEBUG_STOP        = 1'b0;
	DEBUG_LD_BKP_EN   = 1'b0;
	DEBUG_STEP_REQ    = 1'b0;
	DEBUG_EN_BKPX     = 1'b0;
	REGB_DOUT         = 16'h5678;
	DIN               = 16'h2222;
	DIN_BKP           = 16'hbbea;
	`TICKTOCK;
	`TICKTOCK;
	RESET = 0;
	`CYCLE;
	`CYCLE;
	// We should be stuck at the reset address
	`assert("HERE",         16'h0000, HERE)
	`assert("PC_A",         16'hfffe, PC_A)
	`assert("PC_A_NEXT",    16'hfffe, PC_A_NEXT)
	// Now start the PC running
	PC_OFFSETX        = `PC_OFFSETX_2;
	`TICKTOCK;
	#10;
	`assert("HERE",         16'h0002, HERE)
	`assert("PC_A",         16'h0000, PC_A)
	`assert("PC_A_NEXT",    16'h0002, PC_A_NEXT)
	`assert("DEBUG_AT_BKP", 1'b0,     DEBUG_AT_BKP)
	#90;
	`TICKTOCK;
	`TICKTOCK;
	// a jump or HERE instruction
	PC_OFFSETX        = `PC_OFFSETX_4;
	`TICKTOCK;
	#10;
	`assert("HERE",         16'h0006, HERE)
	`assert("PC_A",         16'h0004, PC_A)
	`assert("PC_A_NEXT",    16'h0008, PC_A_NEXT)
	`assert("DEBUG_AT_BKP", 1'b0,     DEBUG_AT_BKP)
	#90;
	`TICKTOCK;
	`TICKTOCK;
	// a normal instruction
	PC_OFFSETX        = `PC_OFFSETX_2;
	`TICKTOCK;
	#10;
	`assert("HERE",         16'h0008, HERE)
	`assert("PC_A",         16'h0006, PC_A)
	`assert("PC_A_NEXT",    16'h0008, PC_A_NEXT)
	`assert("DEBUG_AT_BKP", 1'b0,     DEBUG_AT_BKP)
	#90;
	`TICKTOCK;
	`TICKTOCK;
	// a jump relative
	PC_OFFSETX        = `PC_OFFSETX_DIN;
	`TICKTOCK;
	#10;
	`assert("HERE",         16'h222a, HERE)
	`assert("PC_A",         16'h2228, PC_A)
	`assert("PC_A_NEXT",    16'h444a, PC_A_NEXT)
	`assert("DEBUG_AT_BKP", 1'b0,     DEBUG_AT_BKP)
	#90;
	`TICKTOCK;
	`TICKTOCK;
	
	// a normal instruction
	PC_OFFSETX        = `PC_OFFSETX_2;
	`TICKTOCK;
	#10;
	`assert("HERE",         16'h222c, HERE)
	`assert("PC_A",         16'h222a, PC_A)
	`assert("PC_A_NEXT",    16'h222c, PC_A_NEXT)
	`assert("DEBUG_AT_BKP", 1'b0,     DEBUG_AT_BKP)
	#90;
	`TICKTOCK;
	`TICKTOCK;
	
	// A JMP absolute
	PC_OFFSETX        = `PC_OFFSETX_DIN;
	PC_BASEX          = `PC_BASEX_0;
	DIN               = 16'h1234;
	`TICKTOCK;
	#10;
	`assert("HERE",         16'h1236, HERE)
	`assert("PC_A",         16'h1234, PC_A)
	`assert("PC_A_NEXT",    16'h1234, PC_A_NEXT)
	`assert("DEBUG_AT_BKP", 1'b0,     DEBUG_AT_BKP)
	#90;
	`TICKTOCK;
	`TICKTOCK;
	// a normal instruction
	PC_OFFSETX        = `PC_OFFSETX_2;
	PC_BASEX          = `PC_BASEX_PC_A;
	`TICKTOCK;
	#10;
	`assert("HERE",         16'h1238, HERE)
	`assert("PC_A",         16'h1236, PC_A)
	`assert("PC_A_NEXT",    16'h1238, PC_A_NEXT)
	`assert("DEBUG_AT_BKP", 1'b0,     DEBUG_AT_BKP)
	#90;
	`TICKTOCK;
	`TICKTOCK;
	
	// JP (Rb)
	PC_OFFSETX        = `PC_OFFSETX_0;
	PC_BASEX          = `PC_BASEX_REGB_DOUT;
	DIN               = 16'h1234;
	`TICKTOCK;
	#10;
	`assert("HERE",         16'h567a, HERE)
	`assert("PC_A",         16'h5678, PC_A)
	`assert("PC_A_NEXT",    16'h5678, PC_A_NEXT)
	`assert("DEBUG_AT_BKP", 1'b0,     DEBUG_AT_BKP)
	#90;
	`TICKTOCK;
	`TICKTOCK;
	// a normal instruction
	PC_OFFSETX        = `PC_OFFSETX_2;
	PC_BASEX          = `PC_BASEX_PC_A;
	`TICKTOCK;
	#10;
	`assert("HERE",         16'h567c, HERE)
	`assert("PC_A",         16'h567a, PC_A)
	`assert("PC_A_NEXT",    16'h567c, PC_A_NEXT)
	`assert("DEBUG_AT_BKP", 1'b0,     DEBUG_AT_BKP)
	#90;
	`TICKTOCK;
	`TICKTOCK;
	
	// Set a breakpoint
	DEBUG_MODE        = 1'b0;
	DEBUG_STOP        = 1'b0;
	DEBUG_LD_BKP_EN   = 1'b1;
	DEBUG_STEP_REQ    = 1'b0;
	DEBUG_EN_BKPX     = 1'b0;	
	// a normal instruction
	PC_OFFSETX        = `PC_OFFSETX_2;
	PC_BASEX          = `PC_BASEX_PC_A;
	`TICKTOCK;
	DEBUG_LD_BKP_EN   = 1'b0;
	#10;
	`assert("HERE",         16'h567e, HERE)
	`assert("PC_A",         16'h567c, PC_A)
	`assert("PC_A_NEXT",    16'h567e, PC_A_NEXT)
	`assert("DEBUG_AT_BKP", 1'b0,     DEBUG_AT_BKP)
	#90;
	`TICKTOCK;
	`TICKTOCK;	
	// Activate the breakpoint
	DEBUG_LD_BKP_EN   = 1'b1;
	DEBUG_EN_BKPX     = 1'b1;	
	// a normal instruction
	PC_OFFSETX        = `PC_OFFSETX_2;
	PC_BASEX          = `PC_BASEX_PC_A;
	`TICKTOCK;
	DEBUG_LD_BKP_EN   = 1'b0;
	#10;
	`assert("HERE",         16'h5680, HERE)
	`assert("PC_A",         16'h567e, PC_A)
	`assert("PC_A_NEXT",    16'h5680, PC_A_NEXT)
	`assert("DEBUG_AT_BKP", 1'b0,     DEBUG_AT_BKP)
	#90;
	`TICKTOCK;
	`TICKTOCK;	
	`TICKTOCK;	

	// A JMP absolute
	`PC_INST(16'h5680, 16'hbbe8, 16'hfeef, `PC_BASEX_0, `PC_OFFSETX_DIN, `PC_NEXTX_NEXT, 16'hbbe8)

end

endmodule
