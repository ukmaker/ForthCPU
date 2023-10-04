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

	/**
	* Data Sources
	**/
	wire        ALUA_SRCX;
	wire [2:0] ALUB_SRCX;
	
	wire [1:0] REGB_DINX;
	wire [2:0] REGA_ADDRX;
	wire [1:0] REGB_ADDRX;
	wire [1:0] REGA_BYTE_ENX;
	wire [1:0] REGB_BYTE_ENX;
	/**
	* Bus control
	**/
	wire [1:0] DATA_BUSX;
	wire       DATA_BUS_OEN;
	wire [1:0] ADDR_BUSX;
	
loadStoreGroupDecoder testInstance(
	.CLK(CLK),
	.RESET(RESET),
	.INSTRUCTION(INSTRUCTION[13:8]),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.REGA_EN(REGA_EN),
	.REGB_EN(REGB_EN),
	.REGA_WEN(REGA_WEN),
	.REGB_WEN(REGB_WEN),
	.ALU_OPX(ALU_OPX),
	.ALUA_SRCX(ALUA_SRCX),
	.ALUB_SRCX(ALUB_SRCX),
	.REGB_DINX(REGB_DINX),
	.REGA_ADDRX(REGA_ADDRX),
	.REGB_ADDRX(REGB_ADDRX),
	.REGA_BYTE_ENX(REGA_BYTE_ENX),
	.REGB_BYTE_ENX(REGB_BYTE_ENX),
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
	 `TICKTOCK;
	 
	 /************************************************************************
	 * LD Ra,(Rb)
	 *************************************************************************/
	 // Start FETCH
	 `TICK;
	 INSTRUCTION = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_LD,`MODE_LDS_REG_MEM,`R5,`RI};	 
	 `TICK;  
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
	`TICK;
	INSTRUCTION = {`GROUP_LOAD_STORE,`LDSINCF_PRE_DEC,`LDSOPF_LD,`MODE_LDS_REG_MEM,`R5,`RI};	 
	`TICK;
	 
	// DECODE
	`TICKTOCK; 

	// EXECUTE 
	// Control outputs become valid here
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REG_B_WEN",    0, REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_TWO, ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_REG_B, ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_MOV, ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALUA_DIN, ADDR_BUSX)
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
	 `TICK;
	 INSTRUCTION = {`GROUP_LOAD_STORE,`LDSINCF_POST_INC,`LDSOPF_LD,`MODE_LDS_REG_MEM,`R5,`RI};	 
	 `TICK;	 
	// DECODE
	`TICKTOCK; 

	// EXECUTE 
	// Control outputs become valid here
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REG_B_WEN",    0, REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_TWO, ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_REG_B, ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_MOV, ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALUA_DIN, ADDR_BUSX)
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
	 `TICK;
	 INSTRUCTION = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`R5,`RI};	 
	 `TICK;
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
	 `TICK;
	 INSTRUCTION = {`GROUP_LOAD_STORE,2'b10,`LDSOPF_LD,`MODE_LDS_REG_FRAME,`R5,4'b0101};	 
	 `TICK;
	 // DECODE
	`TICKTOCK; 
	// EXECUTE 
	// Control outputs become valid here
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REG_B_WEN",    0, REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_REG_A,    ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_U6_0, ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_SUB,        ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALU_R,    ADDR_BUSX)
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
	 `TICK;
	 INSTRUCTION = {`GROUP_LOAD_STORE,2'b10,`LDSOPF_LD,`MODE_LDS_REG_STACK,`R5,4'b0101};	 
	 `TICK;
	 // DECODE
	`TICKTOCK; 
	// EXECUTE 
	// Control outputs become valid here
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REG_B_WEN",    0, REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_REG_A,    ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_U6_0, ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_ADD,        ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALU_R,    ADDR_BUSX)
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
	 `TICK;
	 INSTRUCTION = {`GROUP_LOAD_STORE,2'b10,`LDSOPF_LD,`MODE_LDS_REG_RETSTACK,`R5,4'b0101};	 
	 `TICK;
	 // DECODE
	`TICKTOCK; 
	// EXECUTE 
	// Control outputs become valid here
	`assert("REGA_EN",      1, REGA_EN)
	`assert("REGB_EN",      0, REGB_EN)
	`assert("REGA_WEN",     0, REGA_WEN)
	`assert("REG_B_WEN",    0, REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_REG_A,    ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_U6_0, ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_ADD,        ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALU_R,    ADDR_BUSX)
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