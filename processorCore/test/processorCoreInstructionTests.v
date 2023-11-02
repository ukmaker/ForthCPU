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
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGA_S8,8'haf};
	`ALU_STEP(  1, 16'h0000,   INSTR, "MOVS RA,0xaf")
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REGA_U8,8'hfa};	 
	`ALU_STEP(   2, 16'h0002,  INSTR, "MOV RA,0xfa")
	
	// Setup R0 as the base address 0xfaaf
	`LD_HERE_STEP(3, 16'h004, `R0, 16'hfaaf) //0001 0010 0011 0100 -> 0000 0100 1000 1101

	
	
	
end

endmodule