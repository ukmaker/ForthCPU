`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/instructionTestSetup.v"

module processorCoreInstructionTests;
	
reg CLK;
reg RESET;
	
wire FETCH;
wire DECODE;
wire EXECUTE;
wire COMMIT;

reg INT0;
reg INT1;

wire [15:0] ADDR_BUF;
wire [15:0] DOUT_BUF;
reg  [15:0] DIN;

wire RD;
wire WR;
PUR PUR_INST(.PUR(1'b1));
GSR GSR_INST(.GSR(1'b1));
	
	

core testInstance(
	
	.CLK(CLK),
	.RESET(RESET),
	
	.FETCH(FETCH), 
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.INT0(INT0),
	.INT1(INT1),
	
	.ADDR_BUF(ADDR_BUF),
	.DOUT_BUF(DOUT_BUF),
	.DIN(DIN),
	
	.RDN_BUF(RDN_BUF),
	.WRN0_BUF(WRN0_BUF),
	.WRN1_BUF(WRN1_BUF),
	
	.ABUS_OEN(ABUS_OEN)
);

reg [15:0] INSTR;
reg [5:0] U6;
reg [1:0] U2;
reg [3:0] U4;

// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 0; 
	`TICK;
	RESET = 1;
	DIN = 16'h0000;
	INT0 = 0;
	INT1 = 0;
	`TICKTOCK;
	#5 RESET = 0;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	
	/**************************************************************************
	* ALU Group - Operations
	***************************************************************************/
	// Setup R0 as the base address 0xfaaf
	`LD_HERE_STEP(0, 16'h000, 16'hfaaf, `R0)
	
	// Load an 8-bit value
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGA_S8,8'haf};
	`ALU_STEP(  1, 16'h0004,   INSTR, "MOVAS 0xaf")
	// Check the value  
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_ST,`MODE_LDS_REG_REG,`RA,`R0};	 
	`ST_STEP(   2, 16'h0006,   INSTR, 16'hfaaf, 16'hffaf, "ST RA,R0")	
	
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGA_U8,8'hfa};	 
	`ALU_STEP(  3, 16'h0008,  INSTR, "MOV RA,0xfa")
	// Check the value  
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_ST,`MODE_LDS_REG_REG,`RA,`R0};	 
	`ST_STEP(   4, 16'h000a,   INSTR, 16'hfaaf, 16'h00fa, "ST (R0),RA")	
	
	// Load some 4-bit values
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REG_U4, `R1, 4'h1};	 
	`ALU_STEP(  5, 16'h000c,  INSTR, "MOV R1,0x1")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REG_U4, `R2, 4'h3};	 
	`ALU_STEP(  6, 16'h000e,  INSTR, "MOV R2,0x3")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REG_U4, `R3, 4'h5};	 
	`ALU_STEP(  7, 16'h0010,  INSTR, "MOV R3,0x5")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REG_U4, `R4, 4'h7};	 
	`ALU_STEP(  8, 16'h0012,  INSTR, "MOV R4,0x7")
	// Check the values  
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_ST,`MODE_LDS_REG_REG,`R1,`R0};	 
	`ST_STEP(   9, 16'h0014,   INSTR, 16'hfaaf, 16'h0001, "ST (R0),R1")	
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_ST,`MODE_LDS_REG_REG,`R2,`R0};	 
	`ST_STEP(  10, 16'h0016,   INSTR, 16'hfaaf, 16'h0003, "ST (R0),R2")	
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_ST,`MODE_LDS_REG_REG,`R3,`R0};	 
	`ST_STEP(  11, 16'h0018,   INSTR, 16'hfaaf, 16'h0005, "ST (R0),R3")	
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_ST,`MODE_LDS_REG_REG,`R4,`R0};	 
	`ST_STEP(  12, 16'h001a,   INSTR, 16'hfaaf, 16'h0007, "ST (R0),R4")
	
	// POP	
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_LD,`MODE_LDS_REG_REG_INC,`R4,`R0};	 
	`LD_STEP(  13, 16'h001c,   INSTR, 16'hfaaf, 16'h0007, "POP R4,R0")
	`LD_STEP(  14, 16'h001e,   INSTR, 16'hfab1, 16'h0007, "POP R4,R0")
	// POPR
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_LD,`MODE_LDS_REG_REG_DEC,`R4,`R0};	 
	`LD_STEP(  15, 16'h0020,   INSTR, 16'hfab1, 16'h0007, "POPR R4,R0")
	`LD_STEP(  16, 16'h0022,   INSTR, 16'hfaaf, 16'h0007, "POPR R4,R0")

	// Setup R0 as the base address 0x1000
	`LD_HERE_STEP(17, 16'h0024, 16'h1000, `R0)
	// LD_B
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_LDB,`MODE_LDS_REG_REG,`R4,`R0};	 
	`LD_STEP(  18, 16'h0028,   INSTR, 16'h1000, 16'h0007, "POP R4,R0")
	// POP_B
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_LDB,`MODE_LDS_REG_REG_INC,`R4,`R0};	 
	`LD_STEP(  19, 16'h002a,   INSTR, 16'h1000, 16'h0007, "POP R4,R0")
	`LD_STEP(  20, 16'h002c,   INSTR, 16'h1001, 16'h3579, "POP R4,R0")
	
	// PUSH_B
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_STB,`MODE_LDS_REG_REG_DEC,`R4,`R0};	 
	`ST_HIGH_STEP(  21, 16'h002e,   INSTR, 16'h1001, 16'h3500, "PUSH_B R4,R0")	
	`ST_LOW_STEP(  22, 16'h0030,   INSTR, 16'h1000, 16'h0035, "PUSH_B R4,R0")	

	
end

endmodule