`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"


module jumpGroupDecoderTests;
	
		
	reg          CLK;
	reg          RESET;
	wire         FETCH, DECODE, EXECUTE, COMMIT;
	reg  [15:0] DIN;
	wire [15:0] INSTRUCTION;
	reg          PC_ENX;
	
	reg CC_ZERO;
	reg CC_CARRY;
	reg CC_PARITY;
	reg CC_SIGN;
	
	wire [1:0] PC_OFFSETX;
	wire [1:0] PC_BASEX;
	
	wire [1:0] REGA_ADDRX;
	wire [2:0] REGB_ADDRX;
	wire        REGA_EN;
	wire        REGA_WEN;
	wire        REGB_EN;
	wire [2:0] ALUB_SRCX;
	
	
jumpGroupDecoder testInstance(

	.GROUPF(INSTRUCTION[15:14]),
	.SKIPF(INSTRUCTION[13:12]),
	.CCF(INSTRUCTION[11:10]),
	.JPF(INSTRUCTION[9:8]),
	.JLF(INSTRUCTION[7]),
	
	.CC_ZERO(CC_ZERO),
	.CC_CARRY(CC_CARRY),
	.CC_SIGN(CC_SIGN),
	.CC_PARITY(CC_PARITY),
	
	.PC_OFFSETX(PC_OFFSETX),
	.PC_BASEX(PC_BASEX),
	
	.REGA_ADDRX(REGA_ADDRX),
	.REGB_ADDRX(REGB_ADDRX),
	.REGA_EN(REGA_EN),
	.REGA_WEN(REGA_WEN),
	.REGB_EN(REGB_EN),
	
	.ALUB_SRCX(ALUB_SRCX)
);


instructionPhaseDecoder decoder(
	.CLK(CLK),
	.RESET(RESET),
	.DIN(DIN),
	.PC_ENX(PC_ENX),
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
	#10
	CLK = 0; 
	`TICK;
	PC_ENX = 1;
	RESET = 1;
	DIN = 16'h0000;
	`TICK;
	`TICK;

	RESET = 0;  
	`TICKTOCK;
	`TICKTOCK;
	
	CC_ZERO   = 1'b0;
	CC_SIGN   = 1'b0;
	CC_CARRY  = 1'b0;
	CC_PARITY = 1'b0;
	DIN = {`GROUP_JUMP,`CC_APPLYX_NONE,`CC_INVERTX_NONE,`CC_SELECTX_Z, `MODE_JMP_ABS_REG,`JLF_NONE, 3'b000,`RI};	 
	`TICKTOCK;  
	`TICKTOCK;
	`mark(1)	
	`assert("PC_OFFSETX", `PC_OFFSETX_2,    PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A,   PC_BASEX)
	`assert("REGA_ADDRX", `REGA_ADDRX_RL,   REGA_ADDRX)
	`assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	`assert("REGA_EN",    0,                REGA_EN)
	`assert("REGA_WEN",   0,                REGA_WEN)
	`assert("REGB_EN",    1,                REGB_EN)
	`assert("ALUB_SRCX",  `ALUB_SRCX_REG_B, ALUB_SRCX)
	`TICKTOCK; 
	`TICKTOCK;  

	DIN = {`GROUP_JUMP,`CC_APPLYX_APPLY,`CC_INVERTX_NONE,`CC_SELECTX_Z, `MODE_JMP_ABS_REG,`JLF_NONE, 3'b000,`RI};	 
	`TICKTOCK;  
	`TICKTOCK;
	`mark(2)	
	`assert("PC_OFFSETX", `PC_OFFSETX_2,    PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A,   PC_BASEX)
	`assert("REGA_ADDRX", `REGA_ADDRX_RL,   REGA_ADDRX)
	`assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	`assert("REGA_EN",    0,                REGA_EN)
	`assert("REGA_WEN",   0,                REGA_WEN)
	`assert("REGB_EN",    1,                REGB_EN)
	`assert("ALUB_SRCX",  `ALUB_SRCX_REG_B, ALUB_SRCX)
	`TICKTOCK; 
	`TICKTOCK;  

	DIN = {`GROUP_JUMP,`CC_APPLYX_APPLY,`CC_INVERTX_INVERT,`CC_SELECTX_Z, `MODE_JMP_ABS_REG,`JLF_NONE, 3'b000,`RI};	 
	`TICKTOCK;  
	`TICKTOCK;
	`mark(3)	
	`assert("PC_OFFSETX", `PC_OFFSETX_DIN,  PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_0,      PC_BASEX)
	`assert("REGA_ADDRX", `REGA_ADDRX_RL,   REGA_ADDRX)
	`assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	`assert("REGA_EN",    0,                REGA_EN)
	`assert("REGA_WEN",   0,                REGA_WEN)
	`assert("REGB_EN",    1,                REGB_EN)
	`assert("ALUB_SRCX",  `ALUB_SRCX_REG_B, ALUB_SRCX)
	`TICKTOCK; 
	`TICKTOCK;  

	DIN = {`GROUP_JUMP,`CC_APPLYX_APPLY,`CC_INVERTX_INVERT,`CC_SELECTX_Z, `MODE_JMP_ABS_REG,`JLF_NONE, 3'b000,`RI};	 
	CC_ZERO = 1;
	`TICKTOCK;  
	`TICKTOCK;
	`mark(4)	
	`assert("PC_OFFSETX", `PC_OFFSETX_2,    PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A,   PC_BASEX)
	`assert("REGA_ADDRX", `REGA_ADDRX_RL,   REGA_ADDRX)
	`assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	`assert("REGA_EN",    0,                REGA_EN)
	`assert("REGA_WEN",   0,                REGA_WEN)
	`assert("REGB_EN",    1,                REGB_EN)
	`assert("ALUB_SRCX",  `ALUB_SRCX_REG_B, ALUB_SRCX)
	`TICKTOCK; 
	`TICKTOCK;  



	DIN = {`GROUP_JUMP,`CC_APPLYX_APPLY,`CC_INVERTX_INVERT,`CC_SELECTX_C, `MODE_JMP_ABS_REG,`JLF_LINK, 3'b000,`RI};	 
	CC_ZERO = 0;
	CC_CARRY = 1;
	`TICKTOCK;  
	`TICKTOCK;
	`mark(5)	
	`assert("PC_OFFSETX", `PC_OFFSETX_2,    PC_OFFSETX)
	`assert("PC_BASEX",   `PC_BASEX_PC_A,   PC_BASEX)
	`assert("REGA_ADDRX", `REGA_ADDRX_RL,   REGA_ADDRX)
	`assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	`assert("REGA_EN",    1,                REGA_EN)
	`assert("REGA_WEN",   1,                REGA_WEN)
	`assert("REGB_EN",    1,                REGB_EN)
	`assert("ALUB_SRCX",  `ALUB_SRCX_REG_B, ALUB_SRCX)
	`TICKTOCK; 
	`TICKTOCK;  




end
	
endmodule