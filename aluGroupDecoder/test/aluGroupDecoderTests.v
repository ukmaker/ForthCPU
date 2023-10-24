`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module aluGroupDecoderTests;
	
	reg          CLK;
	reg          RESET;
	wire         FETCH, DECODE, EXECUTE, COMMIT;
	reg  [15:0] DIN;
	wire [15:0] INSTRUCTION;
	reg         PC_ENX;
	
	/** 
	* Outputs to control functional blocks
	* These are fed to the control_multiplexer and then to the
	* functional units
	* ALU; Register file; data sources; program counter
	**/
	/**
	* Register file
	**/
	wire REGA_EN;
	wire REGB_EN;
	wire REGA_WEN;
	wire REGB_WEN;
	wire [1:0] REGA_ADDRX;
	wire [2:0] REGB_ADDRX;
	/**
	* ALU
	**/
	wire [3:0] ALU_OPX;        // ALU operation
	
	/**
	* Data Sources
	**/
	wire [2:0] ALUA_SRCX;
	wire [2:0] ALUB_SRCX;
	wire        CCL_LD;
	
	/**
	* Arguments
	**/
	wire [3:0] ARGA_X;
	wire [3:0] ARGB_X;
	wire [1:0] LDSINCF;

instructionPhaseDecoder decoder(
	.CLK(CLK),
	.RESET(RESET),
	.PC_ENX(PC_ENX),
	.DIN(DIN),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.INSTRUCTION(INSTRUCTION)
);


aluGroupDecoder inst(
	.CLK(CLK),
	.RESET(RESET),
	.INSTRUCTION(INSTRUCTION),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	
	.REGA_EN(REGA_EN),
	.REGB_EN(REGB_EN),
	.REGA_WEN(REGA_WEN),
	.REGB_WEN(REGB_WEN),
	.REGA_ADDRX(REGA_ADDRX),
	.REGB_ADDRX(REGB_ADDRX),
	.ALU_OPX(ALU_OPX),
	.CCL_LD(CCL_LD),
	.ALUA_SRCX(ALUA_SRCX),
	.ALUB_SRCX(ALUB_SRCX),

	.ARGA_X(ARGA_X),
	.ARGB_X(ARGB_X),
	.LDSINCF(LDSINCF)

);

// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	#90
	CLK = 0; 
	PC_ENX = 1;
	 RESET = 1;
	 DIN = 16'h0000;
	 `TICKTOCK;
	 `TICKTOCK;
	 
	 RESET = 0;  
	 `TICKTOCK; // Start FETCH
	 `TICKTOCK; // Start FETCH
	 `TICKTOCK; // Start FETCH
	 `TICKTOCK; // Start FETCH
	 `TICKTOCK; // Start FETCH
	 `TICKTOCK; // Start FETCH

	 
	 $display("[T=%09t] %d - FETCH", $realtime, 1);	
	`TICK;
	 DIN = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_AND,`MODE_ALU_REG_REG,`R5,`RI}; 	 
	`TOCK; 
	$display("[T=%09t] %d - DECODE", $realtime, 2);	
	`TICKTOCK;
	$display("[T=%09t] %d - EXECUTE", $realtime, 3);	
	`TICKTOCK;
	// Control outputs become valid here
	`assert("REGA_EN", 1, REGA_EN)
	`assert("REGB_EN", 1, REGB_EN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`assert("ALUA_SRCX", `ALUA_SRCX_REG_A, ALUA_SRCX)
	`assert("ALUB_SRCX", `ALUB_SRCX_REG_B, ALUB_SRCX)
	`assert("ALU_OPX", `ALU_OPX_AND, ALU_OPX)
	$display("[T=%09t] %d - COMMMIT", $realtime, 4);	
	`TICKTOCK;
	`assert("REGA_EN", 1, REGA_EN)
	`assert("REGB_EN", 0, REGB_EN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	
	$display("[T=%09t] %d - FETCH", $realtime, 5);	
	`TICK;
	DIN = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_AND,`MODE_ALU_REG_U4,`R6,4'b0111};
	 `TOCK;
	$display("[T=%09t] %d - DECODE", $realtime, 6);	
	`TICKTOCK;
	$display("[T=%09t] %d - EXECUTE", $realtime, 7);	
	`TICKTOCK;
	// Control outputs become valid here
	`assert("REGA_EN", 1, REGA_EN)
	`assert("REGB_EN", 0, REGB_EN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	$display("[T=%09t] %d - COMMMIT", $realtime, 8);	
	`TICKTOCK;
	`assert("REGA_EN", 1, REGA_EN)
	`assert("REGB_EN", 0, REGB_EN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	
	 $display("[T=%09t] %d - FETCH", $realtime, 9);	
	`TICK;
	DIN = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_AND,`MODE_ALU_REGB_U8,8'b10100101};
	`TICK;
	$display("[T=%09t] %d - DECODE", $realtime, 10);	
	`TICKTOCK;
	$display("[T=%09t] %d - EXECUTE", $realtime, 11);	
	`TICKTOCK;
	// Control outputs become valid here
	`assert("REGA_EN", 1, REGA_EN)
	`assert("REGB_EN", 0, REGB_EN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`assert("CCL_LD",     0, CCL_LD)
	$display("[T=%09t] %d - COMMMIT", $realtime, 12);	
	`TICKTOCK;
	`assert("REGA_EN", 1, REGA_EN)
	`assert("REGB_EN", 0, REGB_EN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`assert("CCL_LD",     1, CCL_LD)
	
	 $display("[T=%09t] %d - FETCH", $realtime, 13);	
	`TICK;
	`assert("REGA_EN", 0, REGA_EN)
	`assert("REGB_EN", 0, REGB_EN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`assert("CCL_LD",     0, CCL_LD)
	 DIN = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGA_U8RB,8'b10100101};
	 `TICK;
	$display("[T=%09t] %d - DECODE", $realtime, 14);	
	`TICKTOCK;
	$display("[T=%09t] %d - EXECUTE", $realtime, 15);	
	`TICKTOCK;
	// Control outputs become valid here
	`assert("REGA_EN", 1, REGA_EN)
	`assert("REGB_EN", 1, REGB_EN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`assert("CCL_LD",     0, CCL_LD)
	$display("[T=%09t] %d - COMMMIT", $realtime, 16);	
	`TICKTOCK;
	`assert("REGA_EN", 1, REGA_EN)
	`assert("REGB_EN", 0, REGB_EN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`assert("CCL_LD",     0, CCL_LD)
	`TICKTOCK;

	
end


endmodule
	