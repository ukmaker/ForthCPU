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
	
	reg [15:0] PC_D;

	reg CC_SIGN;
	reg CC_CARRY;
	reg CC_ZERO;
	reg CC_PARITY;


programCounter counter(

	.CLK(CLK),
	.RESET(RESET),
	.PC_EN(PC_EN),
	.COMMIT(COMMIT),
	.PC_D(PC_D),
	.JRX(JRX),
	.CC_SIGN(CC_SIGN),
	.CC_CARRY(CC_CARRY),
	.CC_ZERO(CC_ZERO),
	.CC_PARITY(CC_PARITY),
	.CC_SELECTX(CC_SELECTX),
	.CC_INVERTX(CC_INVERTX),
	.CC_APPLYX(CC_APPLYX),
	.JMPX(JMP_X),
	.PC_A(PC_A)
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
	 * JR          R0 PC_D=0x1234
	 * JR     0xbc.RB PC_D=0xbcde
	 * JR[C]       R1 PC_D=0x3456 C=0
	 * JR[C]       R1 PC_D=0x3458 C=1
	 * JR[NC]      R2 PC_D=0x567a C=0
	 * JR[NC]      R2 PC_D=0x567c C=1
	 * JP          R3 PC_D=0x245e
	 * JP     0x23.RB PC_D=0x2460
	 * JP[Z]       R4 PC_D=0x1002 Z=0
	 * JP[Z]       R4 PC_D=0x1004 Z=1
	 * JP[NZ]      R5 PC_D=0x2006 Z=0
	 * JP[NZ]      R5 PC_D=0x2008 Z=1
	 *************************************************************************/
	 // Start FETCH
	 INSTRUCTION = `INSTRUCTION_NOP;	 
	 `TICKTOCK;  
	 `assert("PC_A", 16'h0000, PC_A)
	 `TICKTOCK;   
	 `assert("JRX",       0, JRX)
	 `assert("JMP_X",     0, JMP_X)
	 `assert("CC_APPLYX", 0, CC_APPLYX)
	 `assert("CC_INVERTX", 0, CC_INVERTX)
	 `assert("ALUB_SRCX",  `ALUB_SRCX_REG_B, ALUB_SRCX)
	 `assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	 `TICKTOCK; 
	 `TICKTOCK;  

	 INSTRUCTION = {`GROUP_JUMP,`SKIPF_NONE,`JPF_REL_R,`CC_SELECTX_Z,`R0,`R1};	 
	 `TICKTOCK;  
	 `assert("PC_A", 16'h0002, PC_A)
	 `TICKTOCK;   
	 `assert("JRX",   1, JRX)
	 `assert("JMP_X", 1, JMP_X)
	 `assert("CC_APPLYX", 0, CC_APPLYX)
	 `assert("CC_INVERTX", 0, CC_INVERTX)
	 `assert("ALUB_SRCX",  `ALUB_SRCX_REG_B, ALUB_SRCX)
	 `assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	 `TICKTOCK; 
	 PC_D = 16'h1234;
	 `TICKTOCK;  

	 INSTRUCTION = {`GROUP_JUMP,`SKIPF_NONE,`JPF_REL_U8,`CC_SELECTX_Z,8'hbc};	 
	 `TICKTOCK;  
	 `assert("PC_A", 16'h1236, PC_A)
	 `TICKTOCK;   
	 `assert("JRX",   1, JRX)
	 `assert("JMP_X", 1, JMP_X)
	 `assert("CC_APPLYX", 0, CC_APPLYX)
	 `assert("CC_INVERTX", 0, CC_INVERTX)
	 `assert("ALUB_SRCX",  `ALUB_SRCX_U8_REG_B, ALUB_SRCX)
	 `assert("REGB_ADDRX", `REGB_ADDRX_RB,      REGB_ADDRX)
	 `TICKTOCK; 
	 PC_D = 16'hbcde;
	 `TICKTOCK;  

	 INSTRUCTION = {`GROUP_JUMP,`SKIPF_SKIP,`JPF_REL_R,`CC_SELECTX_C,`R0,`R1};	 
	 CC_CARRY = 0;
	 `TICKTOCK;  
	 `assert("PC_A", 16'hcf14, PC_A)
	 `TICKTOCK;   
	 `assert("JRX",   1, JRX)
	 `assert("JMP_X", 0, JMP_X)
	 `assert("CC_APPLYX", 1, CC_APPLYX)
	 `assert("CC_INVERTX", 0, CC_INVERTX)
	 `assert("ALUB_SRCX",  `ALUB_SRCX_REG_B, ALUB_SRCX)
	 `assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	 `TICKTOCK; 
	 PC_D = 16'h3456;
	 `TICKTOCK;  

	 INSTRUCTION = {`GROUP_JUMP,`SKIPF_SKIP,`JPF_REL_R,`CC_SELECTX_C,`R0,`R1};	 
	 CC_CARRY = 1;
	 `TICKTOCK;  
	 `assert("PC_A", 16'hcf16, PC_A)
	 `TICKTOCK;   
	 `assert("JRX",   1, JRX)
	 `assert("JMP_X", 0, JMP_X)
	 `assert("CC_APPLYX", 1, CC_APPLYX)
	 `assert("CC_INVERTX", 0, CC_INVERTX)
	 `assert("ALUB_SRCX",  `ALUB_SRCX_REG_B, ALUB_SRCX)
	 `assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	 `TICKTOCK; 
	 PC_D = 16'h3458;
	 `TICKTOCK;  


	 INSTRUCTION = {`GROUP_JUMP,`SKIPF_NOT_SKIP,`JPF_REL_R,`CC_SELECTX_C,`R0,`R1};	 
	 CC_CARRY = 1;
	 `TICKTOCK;  
	 `assert("PC_A", 16'h036e, PC_A)
	 `TICKTOCK;   
	 `assert("JRX",   1, JRX)
	 `assert("JMP_X", 0, JMP_X)
	 `assert("CC_APPLYX", 1, CC_APPLYX)
	 `assert("CC_INVERTX", 1, CC_INVERTX)
	 `assert("ALUB_SRCX",  `ALUB_SRCX_REG_B, ALUB_SRCX)
	 `assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	 `TICKTOCK; 
	 PC_D = 16'h567a;
	 `TICKTOCK;  

	 INSTRUCTION = {`GROUP_JUMP,`SKIPF_NOT_SKIP,`JPF_REL_R,`CC_SELECTX_C,`R0,`R1};	 
	 CC_CARRY = 0;
	 `TICKTOCK;  
	 `assert("PC_A", 16'h0370, PC_A)
	 `TICKTOCK;   
	 `assert("JRX",   1, JRX)
	 `assert("JMP_X", 0, JMP_X)
	 `assert("CC_APPLYX", 1, CC_APPLYX)
	 `assert("CC_INVERTX", 1, CC_INVERTX)
	 `assert("ALUB_SRCX",  `ALUB_SRCX_REG_B, ALUB_SRCX)
	 `assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	 `TICKTOCK; 
	 PC_D = 16'h567c;
	 `TICKTOCK;  

	 INSTRUCTION = {`GROUP_JUMP,`SKIPF_NONE,`JPF_ABS_R,`CC_SELECTX_C,`R0,`R1};	 
	 CC_CARRY = 0;
	 `TICKTOCK;  
	 `assert("PC_A", 16'h59ec, PC_A)
	 `TICKTOCK;   
	 `assert("JRX",   0, JRX)
	 `assert("JMP_X", 1, JMP_X)
	 `assert("CC_APPLYX", 0, CC_APPLYX)
	 `assert("CC_INVERTX", 0, CC_INVERTX)
	 `assert("ALUB_SRCX",  `ALUB_SRCX_REG_B, ALUB_SRCX)
	 `assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	 `TICKTOCK; 
	 PC_D = 16'h245e;
	 `TICKTOCK;  


 	 INSTRUCTION = `INSTRUCTION_NOP;	 
	 `TICKTOCK;  
	 `assert("PC_A", 16'h245e, PC_A)
	 `TICKTOCK;   
	 `assert("JRX",   0, JRX)
	 `assert("JMP_X", 0, JMP_X)
	 `assert("CC_APPLYX", 0, CC_APPLYX)
	 `assert("CC_INVERTX", 0, CC_INVERTX)
	 `assert("ALUB_SRCX",  `ALUB_SRCX_REG_B, ALUB_SRCX)
	 `assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	 `TICKTOCK; 
	 `TICKTOCK;  


end
	
endmodule