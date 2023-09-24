`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module aluGroupDecoderTests;
	
	reg CLK;
	reg RESETN;
	wire FETCH, DECODE, EXECUTE, COMMIT;
	reg [15:0] INSTRUCTION;
	
	/** 
	* Outputs to control functional blocks
	* These are fed to the control_multiplexer and then to the
	* functional units
	* ALU; Register file; data sources; program counter
	**/
	/**
	* Register file
	**/
	wire REGA_CLKEN;
	wire REGB_CLKEN;
	wire REGA_WEN;
	wire REGB_WEN;
	
	/**
	* ALU
	**/
	wire [3:0] ALU_OPX;        // ALU operation
	
	/**
	* Data Sources
	**/
	wire        ALUA_SRCX;
	wire [2:0] ALUB_SRCX;
	wire [1:0] ALUA_CONSTX;
	wire        ALU_LD;
	wire        CCL_LD;
	
	/**
	* Arguments
	**/
	wire [3:0] ARGA_X;
	wire [3:0] ARGB_X;
	wire [2:0] REGA_ADDRX;
	wire [1:0] REGB_ADDRX;

instructionPhaseDecoder decoder(
	.CLK(CLK),
	.RESET(RESETN),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT)
);


aluGroupDecoder inst(
	.CLK(CLK),
	.RESETN(RESETN),
	.INSTRUCTION(INSTRUCTION),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	
	.REGA_CLKEN(REGA_CLKEN),
	.REGB_CLKEN(REGB_CLKEN),
	.REGA_WEN(REGA_WEN),
	.REGB_WEN(REGB_WEN),
	.ALU_OPX(ALU_OPX),
	.ALU_CLR(RESET),
	.ALU_LD(ALU_LD),
	.CCL_CLR(RESET),
	.CCL_LD(CCL_LD),
	.ALUA_SRCX(ALUA_SRCX),
	.ALUB_SRCX(ALUB_SRCX),
	.ALUA_CONSTX(ALUA_CONSTX),
	.ARGA_X(ARGA_X),
	.ARGB_X(ARGB_X),
	.REGA_ADDRX(REGA_ADDRX),
	.REGB_ADDRX(REGB_ADDRX)
);

// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	#10
	CLK = 0; 
	`TICK;
	 RESETN = 1;
	 INSTRUCTION = 16'h0000;
	 `TICK;
	 `TICK;
	 
	 RESETN = 0;  
	 `TICK;
	 `TICK; // Start FETCH
	 INSTRUCTION = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_AND,`MODE_REG_REG,`R5,`RI};
	 `TICK; 	 
	 `TICK; // Latch instruction

	 `TICK; 	 
	 `TICK; 	 
	// Control outputs become valid here
	`assert("REGA_CLKEN", 1, REGA_CLKEN)
	`assert("REGB_CLKEN", 1, REGB_CLKEN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`assert("ALUA_SRCX", `ALUA_SRCX_REG_A, ALUA_SRCX)
	`assert("ALUB_SRCX", `ALUB_SRCX_REG_B, ALUB_SRCX)
	`assert("ALU_OPX", `ALU_OPX_AND, ALU_OPX)
	
	`TICKTOCK;
	`assert("REGA_CLKEN", 1, REGA_CLKEN)
	`assert("REGB_CLKEN", 0, REGB_CLKEN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`TICKTOCK;
	`assert("REGA_CLKEN", 0, REGA_CLKEN)
	`assert("REGB_CLKEN", 0, REGB_CLKEN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`TICKTOCK;
	
	 INSTRUCTION = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_AND,`MODE_REG_U4,`R6,4'b0111};
	`TICKTOCK;
	`assert("REGA_CLKEN", 1, REGA_CLKEN)
	`assert("REGB_CLKEN", 0, REGB_CLKEN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)	
	`assert("ALUA_SRCX", `ALUA_SRCX_REG_A, ALUA_SRCX)
	`assert("ALUB_SRCX", `ALUB_SRCX_ARG_U4, ALUB_SRCX)
	`assert("ALU_OPX", `ALU_OPX_AND, ALU_OPX)
	
	`TICKTOCK;
	`assert("REGA_CLKEN", 1, REGA_CLKEN)
	`assert("REGB_CLKEN", 0, REGB_CLKEN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`TICKTOCK;
	`assert("REGA_CLKEN", 0, REGA_CLKEN)
	`assert("REGB_CLKEN", 0, REGB_CLKEN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`TICKTOCK;
	
	 INSTRUCTION = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_AND,`MODE_REGB_U8,8'b10100101};
	`TICKTOCK;
	`assert("REGA_CLKEN", 1, REGA_CLKEN)
	`assert("REGB_CLKEN", 0, REGB_CLKEN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)	
	`assert("ALUA_SRCX", `ALUA_SRCX_REG_A, ALUA_SRCX)
	`assert("REGA_ADDRX_RB", `REGA_ADDRX_RB, REGA_ADDRX)
	`assert("ALUB_SRCX", `ALUB_SRCX_ARG_U8, ALUB_SRCX)
	`assert("ALU_OPX", `ALU_OPX_AND, ALU_OPX)	
	
	`TICKTOCK;
	`assert("REGA_CLKEN", 1, REGA_CLKEN)
	`assert("REGB_CLKEN", 0, REGB_CLKEN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`assert("ALU_LD",     1, ALU_LD)
	`assert("CCL_LD",     1, CCL_LD)
	
	`TICKTOCK;
	`assert("REGA_CLKEN", 0, REGA_CLKEN)
	`assert("REGB_CLKEN", 0, REGB_CLKEN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`assert("ALU_LD",     0, ALU_LD)
	`assert("CCL_LD",     0, CCL_LD)
	
	`TICKTOCK;
	`assert("REGA_CLKEN", 0, REGA_CLKEN)
	`assert("REGB_CLKEN", 0, REGB_CLKEN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`assert("ALU_LD",     0, ALU_LD)
	`assert("CCL_LD",     0, CCL_LD)
	
	 INSTRUCTION = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_REGA_U8RB,8'b10100101};
	`TICKTOCK;
	`assert("REGA_CLKEN", 1, REGA_CLKEN)
	`assert("REGB_CLKEN", 1, REGB_CLKEN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)	
	`assert("ALUA_SRCX",     `ALUA_SRCX_REG_A, ALUA_SRCX)
	`assert("REGA_ADDRX_RA", `REGA_ADDRX_RA, REGA_ADDRX)
	`assert("ALUB_SRCX",     `ALUB_SRCX_U8_REG_B, ALUB_SRCX)
	`assert("ALU_OPX",       `ALU_OPX_MOV, ALU_OPX)	
	
	`TICKTOCK;
	`assert("REGA_CLKEN", 1, REGA_CLKEN)
	`assert("REGB_CLKEN", 0, REGB_CLKEN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`assert("ALU_LD",     0, ALU_LD)
	`assert("CCL_LD",     0, CCL_LD)
	`TICKTOCK;
	`assert("REGA_CLKEN", 0, REGA_CLKEN)
	`assert("REGB_CLKEN", 0, REGB_CLKEN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`assert("ALU_LD",     0, ALU_LD)
	`assert("CCL_LD",     0, CCL_LD)
	`TICKTOCK;
	`assert("REGA_CLKEN", 0, REGA_CLKEN)
	`assert("REGB_CLKEN", 0, REGB_CLKEN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`assert("ALU_LD",     0, ALU_LD)
	`assert("CCL_LD",     0, CCL_LD)
	
end


endmodule
	