`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module loadStoreGroupDecoderTests;
	
	
	reg CLK;
	reg RESET;
	
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
	wire [2:0] ALUA_SRCX;
	wire [2:0] ALUB_SRCX;
	
	wire [1:0] REGA_DINX;
	wire [1:0] REGA_ADDRX;
	wire [2:0] REGB_ADDRX;
	wire [1:0] REGA_BYTE_ENX;
	wire [1:0] REGB_BYTE_ENX;
	
	wire [1:0] PC_OFFSETX;
	/**
	* Bus control
	**/
	wire [1:0] DATA_BUSX;
	wire       RDX;
	wire       WRX;
	wire       BYTEX;
	wire [1:0] ADDR_BUSX;
	
	
	reg  [15:0] DIN;
	wire [15:0] INSTRUCTION;
	wire [1:0] OPF;
	wire [2:0] MODEF;
	reg PC_ENX;
	
loadStoreGroupDecoder testInstance(
	.CLK(CLK),
	.RESET(RESET),
	.OPF(OPF),
	.MODEF(MODEF),
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
	.REGA_DINX(REGA_DINX),
	.REGA_ADDRX(REGA_ADDRX),
	.REGB_ADDRX(REGB_ADDRX),
	.REGA_BYTE_ENX(REGA_BYTE_ENX),
	.REGB_BYTE_ENX(REGB_BYTE_ENX),
	.DATA_BUSX(DATA_BUSX),
	.RDX(RDX),
	.WRX(WRX),
	.BYTEX(BYTEX),
	.ADDR_BUSX(ADDR_BUSX),
	.PC_OFFSETX(PC_OFFSETX)
);

instructionPhaseDecoder decoder(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.DIN(DIN),
	.INSTRUCTION(INSTRUCTION),
	.PC_ENX(PC_ENX)
);	

assign OPF  = INSTRUCTION[12:11];
assign MODEF = INSTRUCTION[10:8];

// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	#10
	CLK = 0; 
	PC_ENX = 1;
	`TICK;
	 RESET = 1;
	 DIN = 16'h0000;
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
	 DIN = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_LD,`MODE_LDS_REG_REG,`R5,`RI};	 
	 `TICK;  
	// DECODE
	`TICKTOCK; 
	// EXECUTE 
	// Control outputs become valid here
	#10
	`mark(1)
	`assert("REGA_EN",      1,                   REGA_EN)
	`assert("REGB_EN",      1,                   REGB_EN)
	`assert("REGA_WEN",     0,                   REGA_WEN)
	`assert("REG_B_WEN",    0,                   REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_ZERO,      ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_REG_B,     ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_ADD,         ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALUB_DATA, ADDR_BUSX)
	`assert("REGA_ADDRX",  `REGA_ADDRX_ARGA,     REGA_ADDRX)
	`assert("REGB_ADDRX",  `REGB_ADDRX_ARGB,     REGB_ADDRX)
	
	// COMMIT
	`TICKTOCK;
	`mark(2)
	`assert("REGA_EN", 1, REGA_EN)
	`assert("REGB_EN", 1, REGB_EN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	
	`TICKTOCK
	 /************************************************************************
	 * LD Ra,(HERE)
	 *************************************************************************/
	 // Start FETCH
	 `TICK;
	 DIN = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_LD,`MODE_LDS_REG_HERE,`R5,`RI};	 
	 `TICK;  
	// DECODE
	`TICKTOCK; 
	// EXECUTE 
	// Control outputs become valid here
	#10
	`mark(3)
	`assert("REGA_EN",      1,                   REGA_EN)
	`assert("REGB_EN",      1,                   REGB_EN)
	`assert("REGA_WEN",     0,                   REGA_WEN)
	`assert("REG_B_WEN",    0,                   REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_ZERO,      ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_REG_B,     ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_ADD,         ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_HERE,      ADDR_BUSX)
	`assert("REGA_ADDRX",  `REGA_ADDRX_ARGA,     REGA_ADDRX)
	`assert("REGB_ADDRX",  `REGB_ADDRX_ARGB,     REGB_ADDRX)
	
	// COMMIT
	`TICKTOCK;
	`mark(4)
	`assert("REGA_EN", 1, REGA_EN)
	`assert("REGB_EN", 1, REGB_EN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	
	`TICKTOCK


	 /************************************************************************
	 * LD Ra,(--Rb)
	 *************************************************************************/
	// FETCH
	`TICK;
	 DIN = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_LD,`MODE_LDS_REG_REG_DEC,`R5,`RI};	 	 
	`TICK;
	 
	// DECODE
	`TICKTOCK; 

	// EXECUTE 
	// Control outputs become valid here
	`mark(5)
	`assert("REGA_EN",      1,                   REGA_EN)
	`assert("REGB_EN",      1,                   REGB_EN)
	`assert("REGA_WEN",     0,                   REGA_WEN)
	`assert("REG_B_WEN",    0,                   REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_MINUS_TWO, ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_REG_B,     ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_ADD,         ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALU_R,     ADDR_BUSX)
	`assert("REGA_ADDRX",  `REGA_ADDRX_ARGA,     REGA_ADDRX)
	
	// COMMIT
	`TICKTOCK;
	`mark(6)
	`assert("REGA_EN",    1, REGA_EN)
	`assert("REGB_EN",    1, REGB_EN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  1, REGB_WEN)
		
	
	`TICKTOCK
	
	 /************************************************************************
	 * LD Ra,(Rb++)
	 *************************************************************************/
	// FETCH
	 `TICK;
	  DIN = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_LD,`MODE_LDS_REG_REG_INC,`R5,`RI};	 	 
	 `TICK;	 
	// DECODE
	`TICKTOCK; 

	// EXECUTE 
	// Control outputs become valid here
	`mark(7)
	`assert("REGA_EN",      1,                   REGA_EN)
	`assert("REGB_EN",      1,                   REGB_EN)
	`assert("REGA_WEN",     0,                   REGA_WEN)
	`assert("REG_B_WEN",    0,                   REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_TWO,       ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_REG_B,     ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_ADD,         ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALUB_DATA, ADDR_BUSX)
	`assert("REGA_ADDRX",  `REGA_ADDRX_ARGA,     REGA_ADDRX)
	
	// COMMIT
	`TICKTOCK;
	`mark(8)
	`assert("REGA_EN",    1, REGA_EN)
	`assert("REGB_EN",    1, REGB_EN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  1, REGB_WEN)
	`TICKTOCK;
	
	/************************************************************************
	 * ST (Rb),Ra
	 *************************************************************************/
	 // Start FETCH
	 `TICK;
	 DIN = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_ST,`MODE_LDS_REG_REG,`R5,`RI};	 	 
	 `TICK;
	 // DECODE
	`TICKTOCK; 
	// EXECUTE 
	// Control outputs become valid here
	`mark(9)
	`assert("REGA_EN",      1,                   REGA_EN)
	`assert("REGB_EN",      1,                   REGB_EN)
	`assert("REGA_WEN",     0,                   REGA_WEN)
	`assert("REG_B_WEN",    0,                   REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_ZERO,      ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_REG_B,     ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_ADD,         ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALUB_DATA, ADDR_BUSX)
	`assert("REGA_ADDRX",  `REGA_ADDRX_ARGA,     REGA_ADDRX)
	`assert("DATA_BUSX",   `DATA_BUSX_REGA_DOUT, DATA_BUSX)
	// COMMIT
	`TICKTOCK;
	`mark(10)
	`assert("REGA_EN",    1, REGA_EN)
	`assert("REGB_EN",    1, REGB_EN)
	`assert("REGA_WEN",   0, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`TICKTOCK;
	

	
	/************************************************************************
	 * LD Ra,(FP + S5.0)
	 *************************************************************************/
	 // Start FETCH
	 `TICK;
	 DIN = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_LD,`MODE_LDS_REG_FP,`R5,4'b0101};	 	 
	 `TICK;
	 // DECODE
	`TICKTOCK; 
	// EXECUTE 
	// Control outputs become valid here
	`mark(11)
	`assert("REGA_EN",      1,                  REGA_EN)
	`assert("REGB_EN",      1,                  REGB_EN)
	`assert("REGA_WEN",     0,                  REGA_WEN)
	`assert("REG_B_WEN",    0,                  REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_U5_0,     ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_REG_B,    ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_ADD,        ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALU_R,    ADDR_BUSX)
	`assert("REGB_ADDRX",  `REGB_ADDRX_RFP,     REGB_ADDRX)
			
	// COMMIT
	`TICKTOCK;
	`mark(12)
	`assert("REGA_EN",    1, REGA_EN)
	`assert("REGB_EN",    1, REGB_EN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`TICKTOCK;
	
	/************************************************************************
	 * LD Ra,(SP + S6.0)
	 *************************************************************************/
	 // Start FETCH
	 `TICK;
	 DIN = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_LD,`MODE_LDS_REG_SP,`R5,4'b0101};	 	 
	 `TICK;
	 // DECODE
	`TICKTOCK; 
	// EXECUTE 
	// Control outputs become valid here
	`mark(13)
	`assert("REGA_EN",      1,                  REGA_EN)
	`assert("REGB_EN",      1,                  REGB_EN)
	`assert("REGA_WEN",     0,                  REGA_WEN)
	`assert("REG_B_WEN",    0,                  REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_U5_0,     ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_REG_B,    ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_ADD,        ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALU_R,    ADDR_BUSX)
	`assert("REGB_ADDRX",  `REGB_ADDRX_RSP,     REGB_ADDRX)
			
	// COMMIT
	`TICKTOCK;
	`mark(14)
	`assert("REGA_EN",    1, REGA_EN)
	`assert("REGB_EN",    1, REGB_EN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`TICKTOCK;
	
	/************************************************************************
	 * LD Ra,(RS + S6.0)
	 *************************************************************************/
	 // Start FETCH
	 `TICK;
	 DIN = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_LD,`MODE_LDS_REG_RS,`R5,`RI};	 	 
	 `TICK;
	 // DECODE
	`TICKTOCK; 
	// EXECUTE 
	// Control outputs become valid here
	`mark(15)
	`assert("REGA_EN",      1,                  REGA_EN)
	`assert("REGB_EN",      1,                  REGB_EN)
	`assert("REGA_WEN",     0,                  REGA_WEN)
	`assert("REG_B_WEN",    0,                  REGB_WEN)
	`assert("ALUA_SRCX",   `ALUA_SRCX_U5_0,     ALUA_SRCX)
	`assert("ALUB_SRCX",   `ALUB_SRCX_REG_B,    ALUB_SRCX)
	`assert("ALU_OPX",     `ALU_OPX_ADD,        ALU_OPX)
	`assert("ADDR_BUSX",   `ADDR_BUSX_ALU_R,    ADDR_BUSX)
	`assert("REGB_ADDRX",  `REGB_ADDRX_RRS,     REGB_ADDRX)
			
	// COMMIT
	`TICKTOCK;
	`mark(16)
	`assert("REGA_EN",    1, REGA_EN)
	`assert("REGB_EN",    1, REGB_EN)
	`assert("REGA_WEN",   1, REGA_WEN)
	`assert("REG_B_WEN",  0, REGB_WEN)
	`TICKTOCK;
	

	
end

	
endmodule