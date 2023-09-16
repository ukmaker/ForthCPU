`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"

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

`define assert(expected, actual) \
        	#(CLOCK_CYCLE); \
			if (expected !== actual) begin \
            $display("[T=%0t] FAILED in %m: expected %b != actual %b", $realtime, expected, actual); \
			#(CLOCK_CYCLE); \
        end

initial begin
	#(CLOCK_CYCLE);
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
	`assert(16'haaaa, ALU_A)
	`assert(4'h6, REG_ADDR_A)
	
	ALU_A_SOURCEX = `ALU_A_SOURCEX_RA;
	`assert(4'h8, REG_ADDR_A)
	
	/**
	* ALU_B sources
	**/
	ALU_B_SOURCEX = `ALU_B_SOURCEX_REG_B;
	`assert(16'hbbbb, ALU_B)
	
	ALU_B_SOURCEX = `ALU_B_SOURCEX_ARG_U4;
	`assert(16'h0007, ALU_B)
	
	ALU_B_SOURCEX = `ALU_B_SOURCEX_ARG_U8;
	`assert(16'h0067, ALU_B)

	ALU_B_SOURCEX = `ALU_B_SOURCEX_U8_REG_B;
	`assert(16'h67bb, ALU_B)

	/**
	* DATA_BUS sources
	**/
	DATA_BUSX = `DATA_BUSX_REG_A;
	`assert(16'haaaa, DOUT)
	DATA_BUSX = `DATA_BUSX_REG_B;
	`assert(16'hbbbb, DOUT)
	DATA_BUSX = `DATA_BUSX_ALU;
	`assert(16'habcd, DOUT)
	
	/**
	* ADDR_BUS sources
	**/
	ADDR_BUSX = `ADDR_BUSX_PC;
	`assert(16'h1234, AOUT)
	
	ADDR_BUSX = `ADDR_BUSX_REG_A;
	`assert(16'haaaa, AOUT)
	
	ADDR_BUSX = `ADDR_BUSX_REG_B;
	`assert(16'hbbbb, AOUT)
	
	ADDR_BUSX = `ADDR_BUSX_ALU;
	`assert(16'habcd, AOUT)
	
	/**
	* REGA_SOURCE
	**/
	REGA_SOURCEX = `REG_SOURCEX_REGB;
	`assert(16'hbbbb, REGA_I)
	
	REGA_SOURCEX = `REG_SOURCEX_ALU;
	`assert(16'habcd, REGA_I)
	
	REGA_SOURCEX = `REG_SOURCEX_DIN;
	`assert(16'hdddd, REGA_I)
	
	REGA_SOURCEX = `REG_SOURCEX_PC_ADDR;
	`assert(16'h1234, REGA_I)
	
	
	/**
	* REGB_SOURCE
	**/
	REGB_SOURCEX = `REG_SOURCEX_REGB;
	`assert(16'hbbbb, REGB_I)
	
	REGB_SOURCEX = `REG_SOURCEX_ALU;
	`assert(16'habcd, REGB_I)
	
	REGB_SOURCEX = `REG_SOURCEX_DIN;
	`assert(16'hdddd, REGB_I)
	
	REGB_SOURCEX = `REG_SOURCEX_PC_ADDR;
	`assert(16'h1234, REGB_I)
	
end

endmodule