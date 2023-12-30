`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../instructionTestSetup.sv"

module coreTests;
	
reg CLK;
reg RESET;

wire STOPPED;
wire FETCH;
wire DECODE;
wire EXECUTE;
wire COMMIT;

reg [15:0] DIN;
wire [15:0] DIN_BUF;
wire [15:0] DOUT_BUF;
wire [15:0] ADDR_BUF;
wire WRN0_BUF;
wire WRN1_BUF;
wire RDN_BUF;

reg [15:0] INSTR;
wire WR0_BUF;
wire WR1_BUF;
wire RD_BUF;

assign WRN0_BUF = ~WR0_BUF;
assign WRN1_BUF = ~WR1_BUF;
assign RDN_BUF  = ~RD_BUF;
assign DIN_BUF = DIN;

core testArticle(
	.CLK(CLK),
	.RESET(RESET),
	.STOPPED(STOPPED),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.DIN_BUF(DIN_BUF),
	.DOUT_BUF(DOUT_BUF),
	.ADDR_BUF(ADDR_BUF),
	.WR0_BUF(WR0_BUF),
	.WR1_BUF(WR1_BUF),
	.RD_BUF(RD_BUF)
);

PUR PUR_INST(.PUR(1'b1));
GSR GSR_INST(.GSR(1'b1));

always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 1;
	RESET = 1;
	`TICKTOCK;
	RESET = 0;
	DIN = 16'h0000;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	#10;

	
	/**************************************************************************
	* ALU Group - Operations
	***************************************************************************/
	// Setup R0 as the base address 0xfaaf
	`LD_HERE_STEP(0, 16'h000, 16'hfaaf, `R0)
	
	// Load an 8-bit value
	INSTR = {`GROUPX_ALU,`ALU_OPX_MOV,`MODE_ALU_REGA_S8,8'haf};
	`ALU_STEP(  1, 16'h0004,   INSTR, "MOVAS 0xaf")
	// Check the value  
	INSTR = {`GROUPX_LDS,1'b0,`LDSOPF_ST,`MODE_LDS_REG_REG,`RA,`R0};	 
	`ST_STEP(   2, 16'h0006,   INSTR, 16'hfaaf, 16'hffaf, "ST RA,R0")	
	
	INSTR = {`GROUPX_ALU,`ALU_OPX_MOV,`MODE_ALU_REGA_U8,8'hfa};	 
	`ALU_STEP(  3, 16'h0008,  INSTR, "MOVAI 0xfa")
	// Check the value  
	INSTR = {`GROUPX_LDS,1'b0,`LDSOPF_ST,`MODE_LDS_REG_REG,`RA,`R0};	 
	`ST_STEP(   4, 16'h000a,   INSTR, 16'hfaaf, 16'h00fa, "ST RA,R0")	
	
end

endmodule
	