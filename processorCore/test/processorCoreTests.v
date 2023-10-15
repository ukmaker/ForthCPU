`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module processorCoreTests;
	
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

	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGB_U8,8'haf};	
	`FETCH(   1, 16'h0000, INSTR, "MOV RB,0x00af")
	`DECODE(  2, "")  
	`EXECUTE( 3, "")
	`TICKTOCK;
	`COMMIT(  4, "")
	`TICKTOCK;

	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGA_U8RB,8'hfa};	 
	`FETCH(   5, 16'h0002, INSTR, "MOV RA,U8.RBL")
	`DECODE(  6, "")  
	`EXECUTE( 7, "")
	`TICKTOCK;
	`COMMIT(  8, "")
	`TICKTOCK;

	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGB_U8,8'h56};	 
	`FETCH(   9, 16'h0004, INSTR, "MOV RB,0x0056")
	`DECODE( 10, "")  
	`EXECUTE(11, "")
	`TICKTOCK;
	`COMMIT( 12, "")
	`TICKTOCK;

	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`RB,`RA};	 
	`FETCH(  13, 16'h0006, INSTR, "ST (RA),RB")
	`DECODE( 14, "")  
	`EXECUTE(15, "")
	`assert("ADDR_BUF", 16'hfaaf, ADDR_BUF)
	`assert("DOUT_BUF", 16'h0056, DOUT_BUF)
	`TICKTOCK;
	`COMMIT( 16, "")
	`assert("ADDR_BUF", 16'hfaaf, ADDR_BUF)
	`assert("DOUT_BUF", 16'h0056, DOUT_BUF)
	`assert("WRN0_BUF", 0, WRN0_BUF)
	`assert("WRN1_BUF", 0, WRN1_BUF)
	`TICKTOCK;

	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_POST_INC,`LDSOPF_LD,`MODE_LDS_REG_MEM,`RA,`RB};	 
	`FETCH(  17, 16'h0008, INSTR, "LD Ra,(Rb++)")
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`DECODE( 18, "")  
	`EXECUTE(19, "")
	`TICKTOCK;
	`COMMIT( 20, "")
	`TICK;
	DIN = 16'h3456;
	`assert("ADDR_BUF", 16'h0056, ADDR_BUF)
	`assert("RDN_BUF",  1, RDN_BUF)
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`TICK;

	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_POST_INC,`LDSOPF_LD,`MODE_LDS_REG_MEM,`RA,`RB};	 
	`FETCH(  21, 16'h000a, INSTR, "LD Ra,(Rb++)")
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`DECODE( 22, "")  
	`EXECUTE(23, "")
	`TICKTOCK;
	`COMMIT( 24, "")
	`TICK;
	DIN = 16'h3456;
	`assert("ADDR_BUF", 16'h0058, ADDR_BUF)
	`assert("RDN_BUF",  1, RDN_BUF)
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`TICK;
	
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_POST_INC,`LDSOPF_LD,`MODE_LDS_REG_MEM,`RA,`RB};	 
	`FETCH(  22, 16'h000c, INSTR, "LD Ra,(Rb++)")
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`DECODE( 23, "")  
	`EXECUTE(24, "")
	`TICKTOCK;
	`COMMIT( 25, "")
	`TICK;
	DIN = 16'h5678;
	`assert("ADDR_BUF", 16'h005a, ADDR_BUF)
	`assert("RDN_BUF",  1, RDN_BUF)
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`TICK;
 
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_PRE_DEC,`LDSOPF_LD,`MODE_LDS_REG_MEM,`RA,`RB};	 
	`FETCH(  23, 16'h000e, INSTR, "LD Ra,(--Rb)")
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`DECODE( 24, "")  
	`EXECUTE(25, "")
	`TICKTOCK;
	`COMMIT( 26, "")
	`TICK;
	DIN = 16'h5678;
	`assert("ADDR_BUF", 16'h005a, ADDR_BUF)
	`assert("RDN_BUF",  1, RDN_BUF)
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`TICK;
 
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_PRE_DEC,`LDSOPF_LD,`MODE_LDS_REG_MEM,`RA,`RB};	 
	`FETCH(  27, 16'h0010, INSTR, "LD Ra,(--Rb)")
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`DECODE( 28, "")  
	`EXECUTE(29, "")
	`TICKTOCK;
	`COMMIT( 30, "")
	`TICK;
	DIN = 16'h5678;
	`assert("ADDR_BUF", 16'h0058, ADDR_BUF)
	`assert("RDN_BUF",  1, RDN_BUF)
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`TICK;
	
 

	
end
	
endmodule