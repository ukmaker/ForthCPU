`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module loadStoreGroupDecoderTests;
	
	
	reg CLK;
	reg RESET;
	reg [15:0] INSTRUCTION;
	
	wire FETCH;
	wire DECODE;
	wire EXECUTE;
	wire COMMIT;
	
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
	
	/**
	* ALU
	**/
	wire [3:0] ALU_OPX;        // ALU operation
	wire       ALU_LD;
	wire [1:0] ALUA_CONSTX;

	/**
	* Data Sources
	**/
	wire [1:0] ALUA_SRCX;
	wire [2:0] ALUB_SRCX;
	
	wire [1:0] REGA_DINX;
	wire [2:0] REGA_ADDRX;
	wire [1:0] REGB_ADDRX;
	
	/**
	* Bus control
	**/
	wire [1:0] DATA_BUSX;
	wire       DATA_BUS_OEN;
	wire [1:0] ADDR_BUSX;
	
loadStoreGroupDecoder testInstance(
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
	.ALU_OPX(ALU_OPX),
	.ALU_LD(ALU_LD),
	.ALUA_CONSTX(ALUA_CONSTX),
	.ALUA_SRCX(ALUA_SRCX),
	.ALUB_SRCX(ALUB_SRCX),
	.REGA_DINX(REGA_DINX),
	.REGA_ADDRX(REGA_ADDRX),
	.REGB_ADDRX(REGB_ADDRX),
	.DATA_BUSX(DATA_BUSX),
	.DATA_BUS_OEN(DATA_BUS_OEN),
	.ADDR_BUSX(ADDR_BUSX)
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
	// DECODE
	`TICKTOCK; 
	// EXECUTE 
	// Control outputs become valid here
	`assert("REGA_EN",    1, REGA_EN)
	`assert("REGB_EN",    0, REGB_EN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`assert("ALUA_SRCX", `ALUA_SRCX_REG_A, ALUA_SRCX)
	`assert("ALUB_SRCX", `ALUB_SRCX_REG_B, ALUB_SRCX)
	`assert("ALU_OPX",   `ALU_OPX_MOV, ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALUA_DIN, ADDR_BUSX)
	`assert("REGA_DINX",   `REGA_DINX_ALUA_PP, REGA_DINX)
	`assert("ALUA_CONSTX",   `ALUA_CONSTX_TWO, ALUA_CONSTX)
	`assert("ALU_LD",      0,                   ALU_LD)
	`assert("REGA_ADDRX",  `REGA_ADDRX_ARGA,     REGA_ADDRX)
	
	// COMMIT
	`TICKTOCK;
	`assert("REGA_EN", 0, REGA_EN)
	`assert("REGB_EN", 1, REGB_EN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  1, REGB_WEN)
	
	`TICKTOCK
	
	 /************************************************************************
	 * LD Ra,(--Rb)
	 *************************************************************************/
	// FETCH
	INSTRUCTION = {`GROUP_LOAD_STORE,`LDSF_PRE_DEC,`LDS_LD,`MODE_REG_MEM,`R5,`RI};	 
	`TICKTOCK;
	 
	// DECODE
	`TICKTOCK; 

	// EXECUTE 
	// Control outputs become valid here
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REG_B_WEN",    0, REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_INCREMENTER, ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_REG_B, ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_MOV, ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALUA_DIN, ADDR_BUSX)
	`assert("REGA_DINX",   `REGA_DINX_ALUA_PP, REGA_DINX)
	`assert("ALUA_CONSTX", `ALUA_CONSTX_MINUS_TWO, ALUA_CONSTX)
	`assert("ALU_LD",      0,                   ALU_LD)
	`assert("REGA_ADDRX",  `REGA_ADDRX_ARGA,     REGA_ADDRX)
	
	// COMMIT
	`TICKTOCK;
	`assert("REGA_EN", 1, REGA_EN)
	`assert("REGB_EN", 1, REGB_EN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  1, REGB_WEN)
		
	
	`TICKTOCK
	
	 /************************************************************************
	 * LD Ra,(Rb++)
	 *************************************************************************/
	// FETCH
	INSTRUCTION = {`GROUP_LOAD_STORE,`LDSF_POST_INC,`LDS_LD,`MODE_REG_MEM,`R5,`RI};	 
	 `TICKTOCK;
	 
	// DECODE
	`TICKTOCK; 

	// EXECUTE 
	// Control outputs become valid here
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REG_B_WEN",    0, REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_REG_A, ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_REG_B, ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_MOV, ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALUA_DIN, ADDR_BUSX)
	`assert("REGA_DINX",   `REGA_DINX_ALUA_PP, REGA_DINX)
	`assert("ALUA_CONSTX", `ALUA_CONSTX_TWO, ALUA_CONSTX)
	`assert("ALU_LD",      0,                   ALU_LD)
	`assert("REGA_ADDRX",  `REGA_ADDRX_ARGA,     REGA_ADDRX)
	
	// COMMIT
	`TICKTOCK;
	`assert("REGA_EN", 1, REGA_EN)
	`assert("REGB_EN", 1, REGB_EN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  1, REGB_WEN)
	`TICKTOCK;
	
	/************************************************************************
	 * ST (Rb),Ra
	 *************************************************************************/
	 // Start FETCH
	 INSTRUCTION = {`GROUP_LOAD_STORE,`LDSF_NONE,`LDS_ST,`MODE_REG_MEM,`R5,`RI};	 
	 `TICKTOCK;  
	// DECODE
	`TICKTOCK; 
	// EXECUTE 
	// Control outputs become valid here
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGB_EN",      1, REGB_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REG_B_WEN",    0, REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_REG_A, ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_REG_B, ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_MOV, ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALUA_DIN, ADDR_BUSX)
	`assert("REGA_DINX",   `REGA_DINX_ALUA_PP, REGA_DINX)
	`assert("ALUA_CONSTX", `ALUA_CONSTX_TWO, ALUA_CONSTX)
	`assert("ALU_LD",      0,                   ALU_LD)
	`assert("REGA_ADDRX",  `REGA_ADDRX_ARGA,     REGA_ADDRX)
	
	// COMMIT
	`TICKTOCK;
	`assert("REGA_EN", 0, REGA_EN)
	`assert("REGB_EN", 0, REGB_EN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`TICKTOCK;
	

	
	/************************************************************************
	 * LD Ra,(FP - U6)
	 *************************************************************************/
	 // Start FETCH
	 INSTRUCTION = {`GROUP_LOAD_STORE,2'b10,`LDS_LD,`MODE_REG_FRAME,`R5,4'b0101};	 
	 `TICKTOCK;  
	// DECODE
	`TICKTOCK; 
	// EXECUTE 
	// Control outputs become valid here
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REG_B_WEN",    0, REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_REG_A,    ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_ARG_U6_0, ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_SUB,        ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALU_R,    ADDR_BUSX)
	`assert("REGA_DINX",   `REGA_DINX_ALUA_PP,  REGA_DINX)
	`assert("ALUA_CONSTX", `ALUA_CONSTX_TWO,    ALUA_CONSTX)
	`assert("ALU_LD",      1,                   ALU_LD)
	`assert("REGA_ADDRX",  `REGA_ADDRX_RFP,     REGA_ADDRX)
			
	// COMMIT
	`TICKTOCK;
	`assert("REGA_EN", 0, REGA_EN)
	`assert("REGB_EN", 1, REGB_EN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  1, REGB_WEN)
	`TICKTOCK;
	
	/************************************************************************
	 * LD Ra,(SP + U6)
	 *************************************************************************/
	 // Start FETCH
	 INSTRUCTION = {`GROUP_LOAD_STORE,2'b10,`LDS_LD,`MODE_REG_STACK,`R5,4'b0101};	 
	 `TICKTOCK;  
	// DECODE
	`TICKTOCK; 
	// EXECUTE 
	// Control outputs become valid here
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REG_B_WEN",    0, REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_REG_A,    ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_ARG_U6_0, ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_ADD,        ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALU_R,    ADDR_BUSX)
	`assert("REGA_DINX",   `REGA_DINX_ALUA_PP,  REGA_DINX)
	`assert("ALUA_CONSTX", `ALUA_CONSTX_TWO,    ALUA_CONSTX)
	`assert("ALU_LD",      1,                   ALU_LD)
	`assert("REGA_ADDRX",  `REGA_ADDRX_RSP,     REGA_ADDRX)
			
	// COMMIT
	`TICKTOCK;
	`assert("REGA_EN", 0, REGA_EN)
	`assert("REGB_EN", 1, REGB_EN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  1, REGB_WEN)
	`TICKTOCK;
	
	/************************************************************************
	 * LD Ra,(RS + U6)
	 *************************************************************************/
	 // Start FETCH
	 INSTRUCTION = {`GROUP_LOAD_STORE,2'b10,`LDS_LD,`MODE_REG_RETSTACK,`R5,4'b0101};	 
	 `TICKTOCK;  
	// DECODE
	`TICKTOCK; 
	// EXECUTE 
	// Control outputs become valid here
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REG_B_WEN",    0, REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_REG_A,    ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_ARG_U6_0, ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_ADD,        ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALU_R,    ADDR_BUSX)
	`assert("REGA_DINX",   `REGA_DINX_ALUA_PP,  REGA_DINX)
	`assert("ALUA_CONSTX", `ALUA_CONSTX_TWO,    ALUA_CONSTX)
	`assert("ALU_LD",      1,                   ALU_LD)
	`assert("REGA_ADDRX",  `REGA_ADDRX_RRS,     REGA_ADDRX)
			
	// COMMIT
	`TICKTOCK;
	`assert("REGA_EN", 0, REGA_EN)
	`assert("REGB_EN", 1, REGB_EN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  1, REGB_WEN)
	`TICKTOCK;
	

	
end

	
endmodule