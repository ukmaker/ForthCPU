`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/instructionTestSetup.v"

module processorCoreInterruptTests;
	
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
reg [5:0] U6;
reg [1:0] U2;
reg [3:0] U4;

reg doInt0;

reg doInt1;

// clk gen
always begin
	#50 CLK = ~CLK;
end

	
always begin
	#33
	if(doInt0) begin INT0 = 1; end else begin INT0 = 0; end
	#77;
end
always begin
	#55
	if(doInt1) begin INT1 = 1; end else begin INT1 = 0; end
	#45;
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
	* Boot - jump to the interpreter
	***************************************************************************/
	// Address of interpreter in R1
	`LOAD(    1, 16'h0000,   `R1, 16'h0100)
	`TICK;
	DIN = {`GROUP_JUMP,      `SKIPF_NONE,`CC_SELECTX_Z,`MODE_JMP_ABS_REG,`R0,`R1};	 
	`assert("  2 ADDR_BUF", 16'h0004, ADDR_BUF)
	`TOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	
	
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGB_U8,8'h00};
	`ALU_STEP(  3, 16'h0100,   INSTR, "MOV RB,0x00")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGA_U8RB,8'h00};	 
	`ALU_STEP(   4, 16'h0102,  INSTR, "MOV RA,0x00.RBL")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGB_U8,8'h01};
	`ALU_STEP(  5, 16'h0104,   INSTR, "MOV RB,0x00")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REG_U4, `R0, 4'ha};
	`ALU_STEP(  6, 16'h0106,   INSTR, "MOV R0,0xa")
	// Now just keep incrementing
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REG_REG,`RA,`RB};
	`ALU_STEP(  7, 16'h0108,   INSTR, "ADD RA,RB")
	// Check the value
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`RA,`R0};	 
	`ST_STEP(  8, 16'h010a,   INSTR, 16'h000a, 16'h0001, "ST (R0),RA")	
	
	doInt0 = 1;
	// inc
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REG_REG,`RA,`RB};
	`ALU_STEP(  9, 16'h010c,   INSTR, "ADD RA,RB")
	// Now we should be handling the INT0 vector at address 0x0004
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`RA,`R0};	 
	`ST_STEP(  10, 16'h0004,   INSTR, 16'h000a, 16'h0002, "ST (R0),RA")	
	doInt0 = 0;
	// Return from interrupt (0001 0000 0000 0000)
	INSTR = {`GROUP_SYSTEM,  3'b000, `GEN_OP_RETI, 8'b00000000};	 
	`SYS_STEP(  11, 16'h0006,   INSTR, 16'h0006, 16'h0002, "RETI")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`RA,`R0};	 
	`ST_STEP(  12, 16'h010e,  INSTR, 16'h000a, 16'h0002, "ST (R0),RA")	

	// inc
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REG_REG,`RA,`RB};
	`ALU_STEP(  13, 16'h0110,   INSTR, "ADD RA,RB")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REG_REG,`RA,`RB};
	`ALU_STEP(  14, 16'h0112,   INSTR, "ADD RA,RB")
	doInt1 = 1;
	// inc
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REG_REG,`RA,`RB};
	`ALU_STEP(  15, 16'h0114,   INSTR, "ADD RA,RB")
	// Ignore the interrupt because not EI yet
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`RA,`R0};	 
	`ST_STEP(  16, 16'h0116,   INSTR, 16'h000a, 16'h0005, "ST (R0),RA")	
	doInt1 = 0;
	// inc
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REG_REG,`RA,`RB};
	`ALU_STEP(  17, 16'h0118,   INSTR, "ADD RA,RB")
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`RA,`R0};	 
	`ST_STEP(  18, 16'h011a,    INSTR, 16'h000a, 16'h0006, "ST (R0),RA")	

	// Now enable the interrupt and try again
	INSTR = {`GROUP_SYSTEM,  3'b000, `GEN_OP_EI, 8'b00000000};	 
	`SYS_STEP(  19, 16'h011c,   INSTR, 16'h011c, 16'h0002, "EI")	
	// inc
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REG_REG,`RA,`RB};
	`ALU_STEP(  20, 16'h011e,   INSTR, "ADD RA,RB")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REG_REG,`RA,`RB};
	`ALU_STEP(  21, 16'h0120,   INSTR, "ADD RA,RB")
	doInt1 = 1;
	// inc
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_ADD,`MODE_ALU_REG_REG,`RA,`RB};
	`ALU_STEP(  22, 16'h0122,   INSTR, "ADD RA,RB")
	// Interrupt acknowledged
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`RA,`R0};	 
	`ST_STEP(  23, 16'h0008,   INSTR, 16'h000a, 16'h0009, "ST (R0),RA")	
	doInt1 = 0;
	// Return from interrupt (0001 0000 0000 0000)
	INSTR = {`GROUP_SYSTEM,  3'b000, `GEN_OP_RETI, 8'b00000000};	 
	`SYS_STEP(  24, 16'h000a,  INSTR, 16'h000a, 16'h0002, "RETI")	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`RA,`R0};	 
	`ST_STEP(  25, 16'h0124,   INSTR, 16'h000a, 16'h0009, "ST (R0),RA")
	

end

endmodule