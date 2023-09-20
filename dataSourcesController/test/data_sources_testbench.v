`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module data_sources_testbench;
	
	reg [2:0] ALU_A_SOURCEX;
	reg [2:0] ALU_B_SOURCEX;
	reg [1:0] DATA_BUSX;
	reg [1:0] ADDR_BUSX;
	reg [1:0] REGA_SOURCEX;
	reg [1:0] REGB_SOURCEX;
	
	reg [15:0] PC_ADDR;
	reg [15:0] REG_A;
	reg [15:0] REG_B;
	reg [15:0] DIN;
	reg [15:0] ALU_RESULT;
	reg [3:0] ARG_A;
	reg [3:0] ARG_B;
	
	wire [15:0] PC_DATA;
	wire [15:0] ALU_A;
	wire [15:0] ALU_B;
	wire [15:0] DOUT;
	wire [15:0] AOUT;
	wire [15:0] REGA_I;
	wire [15:0] REGB_I;
	wire [3:0] REG_ADDR_A;
	wire [3:0] REG_ADDR_B;
	
parameter CLOCK_CYCLE = 10;
parameter INSTRUCTION_CYCLE = 80;

data_sources data_sources_inst( 
	.ALU_A_SOURCEX(ALU_A_SOURCEX),
	.ALU_B_SOURCEX(ALU_B_SOURCEX),
	.DATA_BUSX(DATA_BUSX),
	.ADDR_BUSX(ADDR_BUSX),
	.REGA_SOURCEX(REGA_SOURCEX),
	.REGB_SOURCEX(REGB_SOURCEX),
	
	.PC_ADDR(PC_ADDR),
	.REG_A(REG_A),
	.REG_B(REG_B),
	.ALU_RESULT(ALU_RESULT),
	.DIN(DIN),
	.ARG_A(ARG_A),
	.ARG_B(ARG_B),
	
	.PC_DATA(PC_DATA),
	.ALU_A(ALU_A),
	.ALU_B(ALU_B),
	.REGA_I(REGA_I),
	.REGB_I(REGB_I),
	.AOUT(AOUT),
	.DOUT(DOUT),
	.REG_ADDR_A(REG_ADDR_A),
	.REG_ADDR_B(REG_ADDR_B)
);

initial begin
	`TICKTOCK
	REG_A = 16'haaaa;
	REG_B = 16'hbbbb;
	PC_ADDR   = 16'h1234;
	ALU_RESULT = 16'habcd;
	DIN   = 16'hdddd;
	ARG_A = 4'h6;
	ARG_B = 4'h7;
	
	/**
	* ALU_A sources 
	**/
	ALU_A_SOURCEX = `ALU_A_SOURCEX_REG_A;
	`TICKTOCK
	`assert("1. ALU_A", 16'haaaa, ALU_A)
	`assert("1. REG_ADDR_A", 4'h6, REG_ADDR_A)
	
	ALU_A_SOURCEX = `ALU_A_SOURCEX_RA;
	`TICKTOCK
	`assert("2. REG_ADDR_A", `RA, REG_ADDR_A)
	
	ALU_A_SOURCEX = `ALU_A_SOURCEX_RB;
	`TICKTOCK
	`assert("3. REG_ADDR_A", `RB, REG_ADDR_A)
	
	ALU_A_SOURCEX = `ALU_A_SOURCEX_SP;
	`TICKTOCK
	`assert("4. REG_ADDR_A", `RSP, REG_ADDR_A)
	
	ALU_A_SOURCEX = `ALU_A_SOURCEX_FP;
	`TICKTOCK
	`assert("5. REG_ADDR_A", `RFP, REG_ADDR_A)
	
	ALU_A_SOURCEX = `ALU_A_SOURCEX_RS;
	`TICKTOCK
	`assert("6. REG_ADDR_A", `RRS, REG_ADDR_A)
	
	/**
	* ALU_B sources
	**/
	ALU_B_SOURCEX = `ALU_B_SOURCEX_REG_B;
	`TICKTOCK
	`assert("ALU_B", 16'hbbbb, ALU_B)
	
	ALU_B_SOURCEX = `ALU_B_SOURCEX_ARG_U4;
	`TICKTOCK
	`assert("ALU_B", 16'h0007, ALU_B)
	
	ALU_B_SOURCEX = `ALU_B_SOURCEX_ARG_U8;
	`TICKTOCK
	`assert("ALU_B", 16'h0067, ALU_B)

	ALU_B_SOURCEX = `ALU_B_SOURCEX_U8_REG_B;
	`TICKTOCK
	`assert("ALU_B", 16'h67bb, ALU_B)

	ALU_B_SOURCEX = `ALU_B_SOURCEX_TWO;
	`TICKTOCK
	`assert("REG_ADDR_B", 4'h7, REG_ADDR_B)
	`assert("ALU_B", 16'h0002, ALU_B)
	
	/**
	* DATA_BUS sources
	**/
	DATA_BUSX = `DATA_BUSX_REG_A;
	`TICKTOCK
	`assert("DOUT", 16'haaaa, DOUT)
	DATA_BUSX = `DATA_BUSX_REG_B;
	`TICKTOCK
	`assert("DOUT", 16'hbbbb, DOUT)
	DATA_BUSX = `DATA_BUSX_ALU;
	`TICKTOCK
	`assert("DOUT", 16'habcd, DOUT)
	
	/**
	* ADDR_BUS sources
	**/
	ADDR_BUSX = `ADDR_BUSX_PC;
	`TICKTOCK
	`assert("AOUT", 16'h1234, AOUT)
	
	ADDR_BUSX = `ADDR_BUSX_REG_A;
	`TICKTOCK
	`assert("AOUT", 16'haaaa, AOUT)
	
	ADDR_BUSX = `ADDR_BUSX_REG_B;
	`TICKTOCK
	`assert("AOUT", 16'hbbbb, AOUT)
	
	ADDR_BUSX = `ADDR_BUSX_ALU;
	`TICKTOCK
	`assert("AOUT", 16'habcd, AOUT)
	
	/**
	* REGA_SOURCE
	**/
	REGA_SOURCEX = `REG_SOURCEX_REGB;
	`TICKTOCK
	`assert("REGA_I", 16'hbbbb, REGA_I)
	
	REGA_SOURCEX = `REG_SOURCEX_ALU;
	`TICKTOCK
	`assert("REGA_I", 16'habcd, REGA_I)
	
	REGA_SOURCEX = `REG_SOURCEX_DIN;
	`TICKTOCK
	`assert("REGA_I", 16'hdddd, REGA_I)
	
	REGA_SOURCEX = `REG_SOURCEX_PC_ADDR;
	`TICKTOCK
	`assert("REGA_I", 16'h1234, REGA_I)
	
	
	/**
	* REGB_SOURCE
	**/
	REGB_SOURCEX = `REG_SOURCEX_REGB;
	`TICKTOCK
	`assert("REGB_I", 16'hbbbb, REGB_I)
	
	REGB_SOURCEX = `REG_SOURCEX_ALU;
	`TICKTOCK
	`assert("REGB_I", 16'habcd, REGB_I)
	
	REGB_SOURCEX = `REG_SOURCEX_DIN;
	`TICKTOCK
	`assert("REGB_I", 16'hdddd, REGB_I)
	
	REGB_SOURCEX = `REG_SOURCEX_PC_ADDR;
	`TICKTOCK
	`assert("REGB_I", 16'h1234, REGB_I)
	
end

endmodule