`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"


module jumpGroupDecoderTests;
	
		
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
	
	
jumpGroupDecoder testInstance(

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


instructionPhaseDecoder decoder(
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
	 `TICK;
	 `TICK;
	 
	 RESET = 0;  
	 `TICKTOCK;
	 `TICKTOCK;
	 
	 /************************************************************************
	 * LD Ra,(Rb)
	 *************************************************************************/
	 // Start FETCH
	 INSTRUCTION = {`GROUP_LOAD_STORE,`LDSF_NONE,`LDS_LD,`MODE_REG_MEM,`R5,`RI};	 
	 `TICKTOCK;  
	 `TICKTOCK;  
	 `TICKTOCK;  
	 `TICKTOCK;  
	 
	 INSTRUCTION = {`INSTRUCTION_NOP};	 
	`TICKTOCK;  
	`TICKTOCK;  
	`TICKTOCK;  
	`TICKTOCK;  
	 INSTRUCTION = {`GROUP_JUMP,`CC_APPLYX_NONE,`CC_INVERTX_NONE,`JPF_ABS_R,`CC_SELECTX_Z,`R5,`RI};	 
	 `TICKTOCK;  
	 `TICKTOCK;  
	 `assert("JRX",   0, JRX)
	 `assert("JMP_X", 1, JMP_X)
	 `assert("ALUB_SRCX", `ALUB_SRCX_REG_B, ALUB_SRCX)
	 `assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	 `TICKTOCK; 
	 `TICKTOCK;  
	 
	 INSTRUCTION = {`GROUP_JUMP,`CC_APPLYX_NONE,`CC_INVERTX_NONE,`JPF_REL_R,`CC_SELECTX_Z,`R5,`RI};	 
	 `TICKTOCK;  
	 `TICKTOCK;  
	 `assert("JRX",   1, JRX)
	 `assert("JMP_X", 1, JMP_X)
	 `assert("ALUB_SRCX", `ALUB_SRCX_REG_B, ALUB_SRCX)
	 `assert("REGB_ADDRX", `REGB_ADDRX_ARGB, REGB_ADDRX)
	 `TICKTOCK; 
	 `TICKTOCK;  
	 
	 
	 INSTRUCTION = {`GROUP_JUMP,`CC_APPLYX_APPLY,`CC_INVERTX_NONE,`JPF_REL_U8,`CC_SELECTX_Z,`R5,`RI};	 
	 `TICKTOCK;  
	 `TICKTOCK;  
	 `assert("JRX",   1, JRX)
	 `assert("JMP_X", 0, JMP_X)
	 `assert("ALUB_SRCX",  `ALUB_SRCX_U8_REG_B, ALUB_SRCX)
	 `assert("REGB_ADDRX", `REGB_ADDRX_RB,      REGB_ADDRX)
	 `TICKTOCK; 
	 `TICKTOCK;  
	 


end
	
endmodule