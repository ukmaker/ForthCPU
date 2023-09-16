`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module aluGroupDecoderTests;
	
	reg CLK;
	reg RESETN;
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
	wire [3:0] ALUX;        // ALU operation
	
	/**
	* Data Sources
	**/
	wire [1:0] ALU_A_SOURCEX;
	wire [1:0] ALU_B_SOURCEX;
	wire FETCH, DECODE, EXECUTE, COMMIT;
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
	.ALUX(ALUX),
	.ALU_A_SOURCEX(ALU_A_SOURCEX),
	.ALU_B_SOURCEX(ALU_B_SOURCEX)
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
	 INSTRUCTION = {`GROUP_ARITHMETIC_LOGIC,`ALU_AND,`MODE_REG_REG,`R5,`RI};

	 `TICK; 	 
	 `TICK; // Latch instruction

	 `TICK; 	 
	 `TICK; 	 
	// Control outputs become valid here
	`assert("REGA_CLKEN", 1, REGA_CLKEN)
	`assert("REGB_CLKEN", 1, REGB_CLKEN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`assert("ALU_A_SOURCEX", `ALU_A_SOURCEX_REG_A, ALU_A_SOURCEX)
	`assert("ALU_B_SOURCEX", `ALU_B_SOURCEX_REG_B, ALU_B_SOURCEX)
	`assert("ALUX", `ALU_AND, ALUX)
	
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
	
	 INSTRUCTION = {`GROUP_ARITHMETIC_LOGIC,`ALU_AND,`MODE_REG_U4,`R6,4'b0111};
	`TICKTOCK;
	`assert("REGA_CLKEN", 1, REGA_CLKEN)
	`assert("REGB_CLKEN", 0, REGB_CLKEN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)	
	`assert("ALU_A_SOURCEX", `ALU_A_SOURCEX_REG_A, ALU_A_SOURCEX)
	`assert("ALU_B_SOURCEX", `ALU_B_SOURCEX_ARG_U4, ALU_B_SOURCEX)
	`assert("ALUX", `ALU_AND, ALUX)
	
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
	
	 INSTRUCTION = {`GROUP_ARITHMETIC_LOGIC,`ALU_AND,`MODE_REGB_U8,8'b10100101};
	`TICKTOCK;
	`assert("REGA_CLKEN", 1, REGA_CLKEN)
	`assert("REGB_CLKEN", 0, REGB_CLKEN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)	
	`assert("ALU_A_SOURCEX", `ALU_A_SOURCEX_RB, ALU_A_SOURCEX)
	`assert("ALU_B_SOURCEX", `ALU_B_SOURCEX_ARG_U8, ALU_B_SOURCEX)
	`assert("ALUX", `ALU_AND, ALUX)	
	
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
	
	 INSTRUCTION = {`GROUP_ARITHMETIC_LOGIC,`ALU_AND,`MODE_REGA_U8RB,8'b10100101};
	`TICKTOCK;
	`assert("REGA_CLKEN", 1, REGA_CLKEN)
	`assert("REGB_CLKEN", 1, REGB_CLKEN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)	
	`assert("ALU_A_SOURCEX", `ALU_A_SOURCEX_RA, ALU_A_SOURCEX)
	`assert("ALU_B_SOURCEX", `ALU_B_SOURCEX_U8_REG_B, ALU_B_SOURCEX)
	`assert("ALUX", `ALU_AND, ALUX)
	
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
end


endmodule
	