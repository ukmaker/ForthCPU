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
	
	.ABUS_OEN(ABUS_OEN),
	.DBUS_OEN(DBUS_OEN)

);

reg [15:0] INSTR;


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
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGB_U8,8'haf};
	`ALU_STEP(  1, 16'h0000,   INSTR, "MOV RB,0xaf")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGA_U8RB,8'hfa};	 
	`ALU_STEP(   2, 16'h0002,  INSTR, "MOV RA,0xfa.RBL")
	// Setup R0 as the base address 0xfaaf
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REG_REG,`R0,`RA};
	`ALU_STEP(  3, 16'h0004,   INSTR, "MOV R0,RA")
	
	// Load the test values 0011, 0220 3300 to R1, R2 and R3
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGB_U8,8'h11};
	`ALU_STEP(  4, 16'h0006,   INSTR, "MOV RB,0x11")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGA_U8RB,8'h00};	 
	`ALU_STEP(  5, 16'h0008,  INSTR, "MOV RA,0x00.RBL")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REG_REG,`R1,`RA};
	`ALU_STEP(  6, 16'h000a,   INSTR, "MOV R1,RA")

	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGB_U8,8'h20};
	`ALU_STEP(  7, 16'h000c,   INSTR, "MOV RB,0x20")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGA_U8RB,8'h02};	 
	`ALU_STEP(  8, 16'h000e,  INSTR, "MOV RA,0x02.RBL")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REG_REG,`R2,`RA};
	`ALU_STEP(  9, 16'h0010,   INSTR, "MOV R2,RA")


	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGB_U8,8'h00};
	`ALU_STEP( 10, 16'h0012,   INSTR, "MOV RB,0x00")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGA_U8RB,8'h33};	 
	`ALU_STEP( 11, 16'h0014,  INSTR, "MOV RA,0x33.RBL")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REG_REG,`R3,`RA};
	`ALU_STEP( 12, 16'h0016,   INSTR, "MOV R3,RA")

	// Check the values have been loaded
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`R1,`R0};	 
	`ST_STEP(  13, 16'h0018,   INSTR, 16'hfaaf, 16'h0011, "ST (R0),R1")	
	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`R2,`R1};	 
	`ST_STEP(  14, 16'h001a,   INSTR, 16'h0011, 16'h0220, "ST (R1),R2")	
	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`R3,`R2};	 
	`ST_STEP(  15, 16'h001c,   INSTR, 16'h0220, 16'h3300, "ST (R2),R3")	
	
	// Now test the ALU operations
	// ADD
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REG_REG,`R1,`R1};
	`ALU_STEP( 16, 16'h001e,   INSTR, "ADD R1,R1")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`R1,`R0};	 
	`ST_STEP(  17, 16'h0020,   INSTR, 16'hfaaf, 16'h0022, "ST (R0),R1")	
	
	// SUB
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_SUB,`MODE_ALU_REG_U4,`R1,4'h1};
	`ALU_STEP( 18, 16'h0022,   INSTR, "SUB R1,0x01")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`R1,`R0};	 
	`ST_STEP(  19, 16'h0024,   INSTR, 16'hfaaf, 16'h0021, "ST (R0),R1")	

	// Reload R1
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGB_U8,8'h11};
	`ALU_STEP( 20, 16'h0026,   INSTR, "MOV RB,0x11")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGA_U8RB,8'h00};	 
	`ALU_STEP( 21, 16'h0028,  INSTR, "MOV RA,0x00.RBL")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REG_REG,`R1,`RA};
	`ALU_STEP( 22, 16'h002a,   INSTR, "MOV R1,RA")

	// MUL
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MUL,`MODE_ALU_REG_U4,`R1,4'h5};
	`ALU_STEP( 23, 16'h002c,   INSTR, "MUL R1,0x05")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`R1,`R0};	 
	`ST_STEP(  24, 16'h002e,   INSTR, 16'hfaaf, 16'h0055, "ST (R0),R1")	

	// OR
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_OR,`MODE_ALU_REG_REG,`R2,`R3};
	`ALU_STEP( 25, 16'h0030,   INSTR, "OR R2,R3")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`R2,`R0};	 
	`ST_STEP(  26, 16'h0032,   INSTR, 16'hfaaf, 16'h3320, "ST (R0),R2")	
	
	`LOAD(27, 16'h0034, `R2, 16'h1234)
	`LOAD(29, 16'h0038, `R3, 16'h3456)
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`R3,`R0};	 
	`ST_STEP(  31, 16'h003c,   INSTR, 16'h0000, 16'h3456, "ST (R0),R3")	
	
	// AND
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_AND,`MODE_ALU_REG_REG,`R2,`R3};
	`ALU_STEP( 32, 16'h003e,   INSTR, "AND R2,R3")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`R2,`R0};	 
	`ST_STEP(  33, 16'h0040,   INSTR, 16'h0000, 16'h1014, "ST (R0),R2")	

	// XOR
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_XOR,`MODE_ALU_REG_REG,`R3,`R3};
	`ALU_STEP( 34, 16'h0042,   INSTR, "XOR R3,R3")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`R3,`R0};	 
	`ST_STEP(  35, 16'h0044,   INSTR, 16'h0000, 16'h0000, "ST (R0),R3")	

	// SL
	`LOAD(36, 16'h0046, `R4, 16'h1234)
	`LOAD(38, 16'h004a, `R5, 16'h0002)
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_SL,`MODE_ALU_REG_REG,`R4,`R5};
	`ALU_STEP( 40, 16'h004e,   INSTR, "SL R4,R5")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`R4,`R0};	 
	`ST_STEP(  41, 16'h0050,   INSTR, 16'h0000, 16'h48d0, "ST (R0),R4")	

	// SR
	`LOAD(42, 16'h0052, `R6, 16'h1234) //0001 0010 0011 0100 -> 0000 0100 1000 1101
	`LOAD(44, 16'h0056, `R7, 16'h0002)
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_SR,`MODE_ALU_REG_REG,`R6,`R7};
	`ALU_STEP( 45, 16'h005a,   INSTR, "SR R4,R5")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`R6,`R0};	 
	`ST_STEP(  46, 16'h005c,   INSTR, 16'h0000, 16'h048d, "ST (R0),R6")	

	// SRA
	`LOAD(     47, 16'h005e,   `R6, 16'h9234) //1001 0010 0011 0100 -> 1110 0100 1000 1101
	`LOAD(     49, 16'h0062,   `R7, 16'h0002)
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_SRA,`MODE_ALU_REG_REG,`R6,`R7};
	`ALU_STEP( 50, 16'h0066,   INSTR, "SRA R6,R7")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`R6,`R0};	 
	`ST_STEP(  51, 16'h0068,   INSTR, 16'h0000, 16'he48d, "ST (R0),R6")	

	// ROT
	`LOAD(     52, 16'h006a,   `RA, 16'h8235) // 1000 0010 0011 0101 -> 0110 0000 1000 1101
	`LOAD(     54, 16'h006e,   `RB, 16'h0002)
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ROT,`MODE_ALU_REG_REG,`RA,`RB};
	`ALU_STEP( 56, 16'h0072,   INSTR, "ROT RA,RB")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`RA,`R0};	 
	`ST_STEP(  57, 16'h0074,   INSTR, 16'h0000, 16'h608d, "ST (R0),RA")	

	// BIT
	`LOAD(     58, 16'h0076,   `RI,  16'h5555)
	`LOAD(     60, 16'h007a,   `RFP, 16'h0002)
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_BIT,`MODE_ALU_REG_REG,`RI,`RFP};
	`ALU_STEP( 62, 16'h007e,   INSTR, "BIT RI,RFP")	
	`TICK;
	DIN = {`GROUP_JUMP,      `SKIPF_SKIP,`CC_SELECTX_Z,`JPF_REL_S8,8'h0e};	 
	`assert("63 ADDR_BUF", 16'h0080, ADDR_BUF)
	`TOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	
	`TICK;
	DIN = {`GROUP_JUMP,      `SKIPF_NOT_SKIP,`CC_SELECTX_Z,`JPF_REL_S8,8'h0e};	 
	`assert("64 ADDR_BUF", 16'h0082, ADDR_BUF)
	`TOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;

	// SET
	`LOAD(     65, 16'h0090,   `RWA, 16'h0000)
	`LOAD(     67, 16'h0094,   `RSP, 16'h0002)
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_SET,`MODE_ALU_REG_REG,`RWA,`RSP};
	`ALU_STEP( 69, 16'h0098,   INSTR, "SET RWA,RSP")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`RWA,`R0};	 
	`ST_STEP(  70, 16'h009a,   INSTR, 16'h0000, 16'h0004, "ST (R0),RWA")	

	// CLR
	`LOAD(     71, 16'h009c,   `RRS, 16'h0004)
	`LOAD(     73, 16'h00a0,   `RL, 16'h0002)
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_CLR,`MODE_ALU_REG_REG,`RRS,`RL};
	`ALU_STEP( 75, 16'h00a4,   INSTR, "CLR RRS,RL")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`RRS,`R0};	 
	`ST_STEP(  76, 16'h00a6,   INSTR, 16'h0000, 16'h0000, "ST (R0),RRS")	

	// SEX
	`LOAD(     77, 16'h00a8,   `RRS, 16'h0004)
	`LOAD(     79, 16'h00ac,   `RL, 16'h0002)
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_CLR,`MODE_ALU_REG_REG,`RRS,`RL};
	`ALU_STEP( 81, 16'h00b0,   INSTR, "CLR RRS,RL")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`RRS,`R0};	 
	`ST_STEP(  82, 16'h00b2,   INSTR, 16'h0000, 16'h0000, "ST (R0),RRS")	

	/**************************************************************************
	* ALU Group - Data sources
	* Most of these were tested above, but here they are systematically
	***************************************************************************/
	// Use Add to test the result
	// ADD R1,R2
	`LOAD(     83, 16'h00b4,   `R1, 16'h1234)
	`LOAD(     85, 16'h00b8,   `R2, 16'h4321)
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REG_REG,`R1,`R2};
	`ALU_STEP( 87, 16'h00bc,   INSTR, "ADD R1,R1")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`R1,`R0};	 
	`ST_STEP(  88, 16'h00be,   INSTR, 16'h0000, 16'h5555, "ST (R0),R1")	

	// ADD R1,U4
	`LOAD(     89, 16'h00c0,   `R1, 16'h1234)
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REG_U4,`R1,4'b0110};
	`ALU_STEP( 91, 16'h00c4,   INSTR, "ADD R1,6")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`R1,`R0};	 
	`ST_STEP(  92, 16'h00c6,   INSTR, 16'h0000, 16'h123a, "ST (R0),R1")	

	// ADD RB,U8L
	`LOAD(     93, 16'h00c8,   `RB, 16'h1234)
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REGB_U8,8'b01100110};
	`ALU_STEP( 95, 16'h00cc,   INSTR, "ADD RB,0x66")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`RB,`R0};	 
	`ST_STEP(  96, 16'h00ce,   INSTR, 16'h0000, 16'h129a, "ST (R0),RB")	

	// ADD RA,U8H.RBL
	`LOAD(     97, 16'h00d0,   `RA, 16'h1234)
	`LOAD(     99, 16'h00d4,   `RB, 16'h0033)
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REGA_U8RB,8'h44};
	`ALU_STEP(101, 16'h00d8,   INSTR, "ADD RA,0x66")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`RA,`R0};	 
	`ST_STEP( 102, 16'h00da,   INSTR, 16'h0000, 16'h5667, "ST (R0),RA")	

	/**************************************************************************
	* Jump Group
	***************************************************************************/
	// Use Add to generate a result to test
	// ADD R1,R2 ; JMP[Z] R3 - No jump
	`LOAD(    103, 16'h00dc,   `R1, 16'h1234)
	`LOAD(    107, 16'h00e0,   `R2, 16'h4321)
	`LOAD(    109, 16'h00e4,   `R3, 16'h8888)
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REG_REG,`R1,`R2};
	`ALU_STEP(111, 16'h00e8,   INSTR, "ADD R1,R2")	
	`TICK;
	DIN = {`GROUP_JUMP,      `SKIPF_SKIP,`CC_SELECTX_Z,`MODE_JMP_ABS_REG,`R3,`R3};	 
	`assert("112 ADDR_BUF", 16'h00ea, ADDR_BUF)
	`TOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	
	// JMP[NZ] R3
	`TICK;
	DIN = {`GROUP_JUMP,      `SKIPF_NOT_SKIP,`CC_SELECTX_Z,`MODE_JMP_ABS_REG,`R3,`R3};	 
	`assert("114 ADDR_BUF", 16'h00ec, ADDR_BUF)
	`TOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;

	// NOP
	`TICK;
	DIN = {`GROUP_SYSTEM,    3'b000, `GEN_OP_NOP, 8'h00};	 
	`assert("115 ADDR_BUF", 16'h8888, ADDR_BUF)
	`TOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;



end

endmodule