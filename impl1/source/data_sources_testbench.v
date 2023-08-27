`timescale 1 ns / 1 ns

module regs_testbench;

	parameter CLOCK_CYCLE = 10;
	
	reg [1:0] SOURCE_X; // 00 : Ra,Rb | 01 : Ra,U4 | 10 : RA,U8L | 11 : RA, U8H
	
	reg [15:0] REG_A; // from the register file
	reg [15:0] REG_B; // from the register file
	
	reg [3:0] ARG_A; // From the instruction LSB
	reg [3:0] ARG_B; // From the instruction LSB
	
	wire[15:0] ALU_A; // To the ALU	
	wire[15:0] ALU_B;  // To the ALU	
	
	wire[15:0] ADDR_A; // To the Register file	
	wire[15:0] ADDR_B; // To the Register file	

data_sources data_sources_inst(
	.SOURCEX(SOURCE_X),
	.REG_A(REG_A),
	.REG_B(REG_B),
	.ARG_A(ARG_A),
	.ARG_B(ARG_B),
	.ALU_A(ALU_A),
	.ALU_B(ALU_B),
	.ADDR_A(ADDR_A),
	.ADDR_B(ADDR_B)
);


	initial begin
		SOURCE_X = 2'b00;
		REG_A = 16'h1111;
		REG_B = 16'h2222;
		ARG_A = 4'h3;
		ARG_B = 4'h4;
	end

	// 100MHz clock generation 


	initial begin		
		#(10*CLOCK_CYCLE);	
		
		#(2 * CLOCK_CYCLE);
		SOURCE_X = 2'b01;
		
		#(2 * CLOCK_CYCLE);
		SOURCE_X = 2'b10;
		
		#(2 * CLOCK_CYCLE);
		SOURCE_X = 2'b11;
		

		
		#(500*CLOCK_CYCLE) $finish;
	end
	
endmodule