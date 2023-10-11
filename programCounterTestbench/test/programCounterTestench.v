`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"
/**
*  1  0  ----  ----  ----  ----------  ----------  Group 2: Jumps
*  GPF   SKIPF JPF   CCF      ARGA        ARGB
**/

module programCounterTestbench;
	
		
	reg CLK;
	reg RESET;
	wire FETCH, DECODE, EXECUTE, COMMIT;
	reg [15:0] INSTRUCTION;
	
	wire PC_EN;
	wire JRX;
	wire JMP_X;
	wire CC_APPLYX;
	wire CC_INVERTX;
	wire [1:0] CC_SELECTX;
	wire [1:0] REGB_ADDRX;
	wire [2:0] ALUB_SRCX;
	wire [15:0] PC_A;
	wire [15:0] PC_A_NEXT;
	
	wire [2:0] PC_NEXTX;
	
	reg [15:0] PC_D;

	reg CC_SIGN;
	reg CC_CARRY;
	reg CC_ZERO;
	reg CC_PARITY;
	
	reg EIX, DIX, INT0, INT1;
	wire PC_LD_INT0X;
	wire PC_LD_INT1X;


programCounter counter(

	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.PC_ENX(PC_EN),
	.PC_LD_INT0X(PC_LD_INT0X),
	.PC_LD_INT1X(PC_LD_INT1X),
	.PC_BASEX(PC_BASEX),
	.PC_OFFSETX(PC_OFFSETX),
	.PC_D(PC_D),
	.PC_NEXTX(PC_NEXTX),
	.PC_A_NEXT(PC_A_NEXT),
	.PC_A(PC_A)
);

branchLogic branchLogicInst(

	.CC_SIGN(CC_SIGN),
	.CC_CARRY(CC_CARRY),
	.CC_ZERO(CC_ZERO),
	.CC_PARITY(CC_PARITY),
	.CC_SELECTX(CC_SELECTX),
	.CC_INVERTX(CC_INVERTX),
	.CC_APPLYX(CC_APPLYX),
	
	.JRX(JRX),
	.JMPX(JMP_X),
	
	.PC_OFFSETX(PC_OFFSETX),
	.PC_BASEX(PC_BASEX)
);

jumpGroupDecoder jumpDecoder(

	.CLK(CLK),
	.RESET(RESET),
	.INSTRUCTION(INSTRUCTION),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.PC_EN(PC_EN),
	.JRX(JRX),
	.JMP_X(JMP_X),
	.CC_APPLYX(CC_APPLYX),
	.CC_INVERTX(CC_INVERTX),
	.CC_SELECTX(CC_SELECTX),
	.REGB_ADDRX(REGB_ADDRX),
	.ALUB_SRCX(ALUB_SRCX)
);

interruptStateMachine interruptStateMachineInst(
	.CLK(CLK),
	.RESET(RESET),
	.COMMIT(COMMIT),
	.RETIX(RETIX),
	.EIX(EIX),
	.DIX(DIX),
	.INT0(INT0),
	.INT1(INT1),
	.PC_NEXTX(PC_NEXTX),
	.PC_LD_INT0(PC_LD_INT0X),
	.PC_LD_INT1(PC_LD_INT1X)
);


instructionPhaseDecoder phaseDecoder(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT)
);	

// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	#10
	CLK = 0; 
	`TICK;
	 RESET = 1;
	 INSTRUCTION = 16'h0000;
	 PC_D = 16'habcd;
	 EIX = 0;
	 DIX = 0;
	 INT0 = 0;
	 INT1 = 0;
	 
	 `TICK;
	 `TICK;
	 
	 RESET = 0;  
	 CC_SIGN = 0;
	 CC_ZERO = 0;
	 CC_PARITY = 0;
	 CC_CARRY = 0;
	 
	 `TICKTOCK;
	 `TICKTOCK;
	 
	 /************************************************************************
	 * Test program
	 * NOP
	 * NOP
	 * JR        0x34
	 * JR        0xbc.RB PC_D=0xbcde
	 * JR[C]     0x56 C=0
	 * JR[C]     0x58 C=1
	 * JR[NC]    0x7a C=0
	 * JR[NC]    0x7c C=1
	 * JP          R3 PC_D=0x245e
	 * JP     0x23.RB PC_D=0x2460
	 * JP[Z]       R4 PC_D=0x1002 Z=0
	 * JP[Z]       R4 PC_D=0x1004 Z=1
	 * JP[NZ]      R5 PC_D=0x2006 Z=0
	 * JP[NZ]      R5 PC_D=0x2008 Z=1
	 *************************************************************************/
	// Start FETCH
	`TICKTOCK;  
	`mark(1)
	`assert("PC_A", 16'h0000, PC_A)
	/************************************************************************************
	* NOP
	*************************************************************************************/
	INSTRUCTION = `INSTRUCTION_NOP;
	`TICKTOCK;   
	`mark(2)
	`assert("JRX",       0, JRX)
	`assert("JMP_X",     0, JMP_X)
	`assert("CC_APPLYX", 0, CC_APPLYX)
	`assert("CC_INVERTX", 0, CC_INVERTX)
	`assert("ALUB_SRCX",  `ALUB_SRCX_REG_B, ALUB_SRCX)
	`assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	`TICKTOCK; 
	`TICKTOCK;  
	`TICKTOCK;  
	`mark(3)
	`assert("PC_A", 16'h0002, PC_A)	
	
	/************************************************************************************
	* NOP
	*************************************************************************************/
	INSTRUCTION = `INSTRUCTION_NOP;
	`TICKTOCK;   
	`mark(4)
	`assert("JRX",       0, JRX)
	`assert("JMP_X",     0, JMP_X)
	`assert("CC_APPLYX", 0, CC_APPLYX)
	`assert("CC_INVERTX", 0, CC_INVERTX)
	`assert("ALUB_SRCX",  `ALUB_SRCX_REG_B, ALUB_SRCX)
	`assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	`TICKTOCK; 
	`TICKTOCK;  
	`TICKTOCK;  
	`mark(5)
	`assert("PC_A", 16'h0004, PC_A)
	 
	/************************************************************************************
	* JR        0x34
	*************************************************************************************/
	INSTRUCTION = {`GROUP_JUMP,`SKIPF_NONE,`JPF_REL_S8,`CC_SELECTX_Z,8'h34};	 
	`TICKTOCK;   
	`mark(6)
	`assert("JRX",   1, JRX)
	`assert("JMP_X", 1, JMP_X)
	`assert("CC_APPLYX", 0, CC_APPLYX)
	`assert("CC_INVERTX", 0, CC_INVERTX)
	`assert("ALUB_SRCX",  `ALUB_SRCX_S8, ALUB_SRCX)
	`assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	`TICKTOCK; 
	 PC_D = 16'h0034;
	`TICKTOCK;  
	`TICKTOCK;  
	`mark(7)
	`assert("PC_A", 16'h0038, PC_A)

	/************************************************************************************
	* JR     0xbc.RB PC_D=0xbcde -> PC_A = 0038+bcde = bd16
	*************************************************************************************/
	 INSTRUCTION = {`GROUP_JUMP,`SKIPF_NONE,`JPF_REL_U8H,`CC_SELECTX_Z,8'hbc};	 
	 `TICKTOCK;   
	`mark(8)
	 `assert("JRX",   1, JRX)
	 `assert("JMP_X", 1, JMP_X)
	 `assert("CC_APPLYX", 0, CC_APPLYX)
	 `assert("CC_INVERTX", 0, CC_INVERTX)
	 `assert("ALUB_SRCX",  `ALUB_SRCX_U8H, ALUB_SRCX)
	 `assert("REGB_ADDRX", `REGB_ADDRX_RB,      REGB_ADDRX)
	 `TICKTOCK; 
	 PC_D = 16'hbcde;
	 `TICKTOCK;  
	 `TICKTOCK;  
	`mark(9)
	 `assert("PC_A", 16'hbd16, PC_A)
	 
	/************************************************************************************
	* JR[C]     0x56 C=0
	*************************************************************************************/
	INSTRUCTION = {`GROUP_JUMP,`SKIPF_SKIP,`JPF_REL_S8,`CC_SELECTX_C, 8'h56};	 
	CC_CARRY = 0;
	`TICKTOCK;   
	`mark(10)
	`assert("JRX",   1, JRX)
	`assert("JMP_X", 0, JMP_X)
	`assert("CC_APPLYX", 1, CC_APPLYX)
	`assert("CC_INVERTX", 0, CC_INVERTX)
	`assert("ALUB_SRCX",  `ALUB_SRCX_S8, ALUB_SRCX)
	`assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	`TICKTOCK; 
	PC_D = 16'h0056;
	`TICKTOCK;  
	`TICKTOCK;  
	`mark(11)
	`assert("PC_A", 16'hbd18, PC_A)

	 
	/************************************************************************************
	* JR[C]     0x58 C=1
	*************************************************************************************/
	INSTRUCTION = {`GROUP_JUMP,`SKIPF_SKIP,`JPF_REL_S8,`CC_SELECTX_C, 8'h58};	 
	CC_CARRY = 1;
	`TICKTOCK;   
	`mark(10)
	`assert("JRX",   1, JRX)
	`assert("JMP_X", 0, JMP_X)
	`assert("CC_APPLYX", 1, CC_APPLYX)
	`assert("CC_INVERTX", 0, CC_INVERTX)
	`assert("ALUB_SRCX",  `ALUB_SRCX_S8, ALUB_SRCX)
	`assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	`TICKTOCK; 
	PC_D = 16'h0058;
	`TICKTOCK;  
	`TICKTOCK;  
	`mark(11)
	`assert("PC_A", 16'hbd70, PC_A)



end
	
endmodule