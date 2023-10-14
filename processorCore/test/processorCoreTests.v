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
	
	.ADDR_BUF(ADDR_BUF),
	.DOUT_BUF(DOUT_BUF),
	.DIN(DIN),
	
	.RDN_BUF(RDN_BUF),
	.WRN0_BUF(WRN0_BUF),
	.WRN1_BUF(WRN1_BUF),
	
	.ABUS_OEN(ABUS_OEN),
	.DBUS_OEN(DBUS_OEN)

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
	DIN = 16'h0000;
	`TICK;
	`TICK;

	RESET = 0;  
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;

	DIN = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGB_U8,8'haf};	
	`FETCH(   1, DIN, "MOV RB,0x00af")
	`DECODE(  2, "")  
	`EXECUTE( 3, "")
	`COMMIT(  4, "")

	DIN = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGA_U8RB,8'hfa};	 
	`FETCH(   5, DIN, "MOV RA,U8.RBL")
	`DECODE(  6, "")  
	`EXECUTE( 7, "")
	`COMMIT(  8, "")

	DIN = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGB_U8,8'h55};	 
	`FETCH(   9, DIN, "MOV RB,0x0055")
	`DECODE( 10, "")  
	`EXECUTE(11, "")
	`COMMIT( 12, "")

	DIN = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_ST,`MODE_LDS_REG_MEM,`RB,`RA};	 
	`FETCH(  13, DIN, "ST (RA),RB")
	`DECODE( 14, "")  
	`EXECUTE(15, "")
	`COMMIT( 16, "")

	DIN = {`GROUP_LOAD_STORE,`LDSINCF_POST_INC,`LDSOPF_LD,`MODE_LDS_REG_MEM,`R5,`RI};	 
	`FETCH(  17, DIN, "LD Ra,(Rb++)")
	`DECODE( 18, "")  
	`EXECUTE(19, "")
	`COMMIT( 20, "")

	`TICKTOCK;
	
end
	
endmodule