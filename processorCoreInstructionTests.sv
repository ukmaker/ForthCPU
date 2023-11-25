`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/instructionTestSetup.sv"

module processorCoreInstructionTests;
	
reg CLK;
reg RESET;
	
wire STOPPED;
wire FETCH;
wire DECODE;
wire EXECUTE;
wire COMMIT;

reg INT0;
reg INT1;

wire [15:0] ADDR_BUF;
wire [15:0] DOUT_BUF;
reg  [15:0] DIN;

wire RDN_BUF;
wire ABUS_OEN;
wire WRN0_BUF;
wire WRN1_BUF;

// Debugger interface
reg  [7:0]  DEBUG_DIN;
wire [7:0]  DEBUG_DOUT;
reg [2:0]   DEBUG_ADDR;
reg          DEBUG_RD;
reg          DEBUG_WR;

PUR PUR_INST(.PUR(1'b1));
GSR GSR_INST(.GSR(1'b1));
	
	

core testInstance(
	
	.CLK(CLK),
	.RESET(RESET),
	
	.STOPPED(STOPPED),
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
	
	.ABUS_OEN(ABUS_OEN),
	
	.DEBUG_DIN(DEBUG_DIN),
	.DEBUG_DOUT(DEBUG_DOUT),
	.DEBUG_ADDR(DEBUG_ADDR),
	.DEBUG_RD(DEBUG_RD),
	.DEBUG_WR(DEBUG_WR)
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
	DEBUG_DIN = 8'h00;
	DEBUG_RD = 0;
	DEBUG_WR = 0;
	DEBUG_ADDR = 0;
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
	`ALU_STEP(  3, 16'h0008,  INSTR, "MOVAI 0xfa")
	// Check the value  
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_ST,`MODE_LDS_REG_REG,`RA,`R0};	 
	`ST_STEP(   4, 16'h000a,   INSTR, 16'hfaaf, 16'h00fa, "ST RA,R0")	
	
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
	`ST_STEP(   9, 16'h0014,   INSTR, 16'hfaaf, 16'h0001, "ST R1,R0")	
	
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_ST,`MODE_LDS_REG_REG,`R2,`R0};	 
	`ST_STEP(  10, 16'h0016,   INSTR, 16'hfaaf, 16'h0003, "ST R2,R0")	
	
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_ST,`MODE_LDS_REG_REG,`R3,`R0};	 
	`ST_STEP(  11, 16'h0018,   INSTR, 16'hfaaf, 16'h0005, "ST R3,R0")	
	
	INSTR = {`GROUP_LOAD_STORE,1'b0,`LDSOPF_ST,`MODE_LDS_REG_REG,`R4,`R0};	 
	`ST_STEP(  12, 16'h001a,   INSTR, 16'hfaaf, 16'h0007, "ST R4,R0")

	
	// Target of jumps in RL
	`LDI(13, 16'h001c, 16'h4040, `RL)
	
	// Test the various MOV options - Ra is LD
	`MOVI(14, 16'h0020, `R0, 4'ha)
	`ST(  15, 16'h0022, 16'h4040, 16'h000a, `R0, `RL)
	
	`MOVAI(16, 16'h0024, 8'haa)
	`ST(   17, 16'h0026, 16'h4040, 16'h00aa, `RA, `RL)
	
	`MOVAS(18, 16'h0028, 8'hbb)
	`ST(   19, 16'h002a, 16'h4040, 16'hffbb, `RA, `RL)
	
	// ADD operations - Ra is RMW
	`LDI(  20, 16'h002c, 16'h1111, `R1)
	`LDI(  21, 16'h0030, 16'h4444, `R0)
	`ADD(  22, 16'h0034, `R0, `R1)
	`ST(   23, 16'h0036, 16'h4040, 16'h5555, `R0, `RL)
	
	`LDI(  24, 16'h0038, 16'h4444, `R0)
	`ADDI( 25, 16'h003c, `R0, 4'h5)
	`ST(   26, 16'h003e, 16'h4040, 16'h4449, `R0, `RL)
	
	`LDI(  25, 16'h0040, 16'h4444, `RA)
	`ADDAI(26, 16'h0044,  8'h22)
	`ST(   27, 16'h0046, 16'h4040, 16'h4466, `RA, `RL)
	
	`LDI(  28, 16'h0048, 16'h4444, `RA)
	`ADDAS(29, 16'h004c,  8'h82)
	`ST(   30, 16'h004e, 16'h4040, 16'h43c6, `RA, `RL)
	
	// CMP operations - Ra is RD
	`LDI(  31, 16'h0050, 16'h1111, `R1)
	`LDI(  32, 16'h0054, 16'h4444, `RA)
	`CMP(  33, 16'h0058, `RA, `R1)
	`ST(   34, 16'h005a, 16'h4040, 16'h4444, `RA, `RL)
	
	`CMPI( 35, 16'h005c, `RA, 4'ha)
	`ST(   36, 16'h005e, 16'h4040, 16'h4444, `RA, `RL)
	
	`CMPAI(37, 16'h0060, 8'haa)
	`ST(   38, 16'h0062, 16'h4040, 16'h4444, `RA, `RL)
	
	`CMPAS(39, 16'h0064, 8'hff)
	`ST(   40, 16'h0066, 16'h4040, 16'h4444, `RA, `RL)
	
	// Test flags on subtract Z
	`LDI(  41, 16'h0068, 16'h1111, `RA)
	`LDI(  42, 16'h006c, 16'h1111, `R1)
	`SUB(  43, 16'h0070, `RA, `R1)
	`ST(   44, 16'h0072, 16'h4040, 16'h0000, `RA, `RL)
	`JPI_N(45, 16'h0074, 16'h3333, `SKIPF_NOT_SKIP, `CC_SELECTX_Z)
	`JPI_N(46, 16'h0078, 16'h3333, `SKIPF_SKIP, `CC_SELECTX_C)
	`JPI_N(47, 16'h007c, 16'h3333, `SKIPF_SKIP, `CC_SELECTX_S)
	`JPI_N(48, 16'h0080, 16'h3333, `SKIPF_SKIP, `CC_SELECTX_P)

	 // C,S,P
	`LDI(  49, 16'h0084, 16'h1110, `RA)
	`LDI(  50, 16'h0088, 16'h1111, `R1)
	`SUB(  51, 16'h008c, `RA, `R1)
	`ST(   52, 16'h008e, 16'h4040, 16'hffff, `RA, `RL)
	`JPI_N(53, 16'h0090, 16'h3333, `SKIPF_SKIP, `CC_SELECTX_Z)
	`JPI_N(54, 16'h0094, 16'h3333, `SKIPF_NOT_SKIP, `CC_SELECTX_C)
	`JPI_N(55, 16'h0098, 16'h3333, `SKIPF_NOT_SKIP, `CC_SELECTX_S)
	`JPI_N(56, 16'h009c, 16'h3333, `SKIPF_NOT_SKIP, `CC_SELECTX_P)


	// Test flags on compare Z
	`LDI(  57, 16'h00a0, 16'h1111, `RA)
	`LDI(  58, 16'h00a4, 16'h1111, `R1)
	`CMP(  59, 16'h00a8, `RA, `R1)
	`ST(  60,  16'h00aa, 16'h4040, 16'h1111, `RA, `RL)
	`JPI_N(61, 16'h00ac, 16'h3333, `SKIPF_NOT_SKIP, `CC_SELECTX_Z)
	`JPI_N(62, 16'h00b0, 16'h3333, `SKIPF_SKIP, `CC_SELECTX_C)
	`JPI_N(63, 16'h00b4, 16'h3333, `SKIPF_SKIP, `CC_SELECTX_S)
	`JPI_N(64, 16'h00b8, 16'h3333, `SKIPF_SKIP, `CC_SELECTX_P)

	 // C,S,P
	`LDI(  65, 16'h00bc, 16'h1110, `RA)
	`LDI(  66, 16'h00c0, 16'h1111, `R1)
	`CMP(  67, 16'h00c4, `RA, `R1)
	`ST(   68, 16'h00c6, 16'h4040, 16'h1110, `RA, `RL)
	`JPI_N(69, 16'h00c8, 16'h3333, `SKIPF_SKIP, `CC_SELECTX_Z)
	`JPI_N(70, 16'h00cc, 16'h3333, `SKIPF_NOT_SKIP, `CC_SELECTX_C)
	`JPI_N(71, 16'h00d0, 16'h3333, `SKIPF_NOT_SKIP, `CC_SELECTX_S)
	`JPI_N(72, 16'h00d4, 16'h3333, `SKIPF_NOT_SKIP, `CC_SELECTX_P)


end

endmodule