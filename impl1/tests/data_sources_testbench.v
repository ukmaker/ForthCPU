`timescale 1 ns / 1 ns

module data_sources_testbench;
	// GROUPX.STX.SOURCEX
	// General group
	// 11x00 : Ra,Rb   | 11x01 : Ra,U4      | 11x10 : RA,U8L     | 11x11 : RA, U8H
	// Load group
	// 01000 : Ra,(Rb) | 01001 : RA,(FP+U8) | 01010 : RA,(SP+U8) | 01011 : RA,(RS+U8)
	// Store group
	// 01100 : (Ra),Rb | 01101 : (FP+U8),RA | 01110 : (SP+U8),RA | 01111 : (RS+U8),RA
	// Jump group
	// 10x00 : PC,Rb   | 10x01 : PC,U8H.RBL | 10x10 : PC,PC+Rb   | 10x11 : PC,PC+U8H.RBL
	// Nop
	// 00xxx
	reg [1:0] SOURCEX; // Bits [9:8]
	reg [1:0] GROUPX;  // Bits [15:14]
	reg STX;            // Bit [11] - valid when group=01 (LD/ST)
	
	reg [3:0] PHASEX; // {COMMIT,EXECUTE,DECODE,FETCH}
	
	reg [15:0] REG_A; // from the register file
	reg [15:0] REG_B; // from the register file
	reg [15:0] REG_PC;// from the register file
	
	wire [3:0] ADDR_A; // To the register file
	wire [3:0] ADDR_B; // To the register file
	
	reg [3:0] ARG_AX; // From the instruction LSB
	reg [3:0] ARG_BX; // From the instruction LSB
	
	wire[15:0] ALU_A; // To the ALU	
	wire[15:0] ALU_B;  // To the ALU	
	
	wire[15:0] RBUS;  // To the register bus	
	wire[15:0] DBUS;  // To the data bus	
	wire[15:0] ABUS;  // To the address bus	
	
	wire AOUTENX; // Enable the address pins
	wire DOUTENX; // Drive the data bus pins
	wire DINENX;  // Drive the internal DBUS from the data pins
	
	wire REGAOPX; // Load-enable to the register file
	wire REGBOPX; // Inc/dec control


parameter CLOCK_CYCLE = 10;

data_sources data_sources_inst(
	.SOURCEX(SOURCEX),
	.GROUPX(GROUPX),
	.STX(STX),
	.PHASEX(PHASEX),
	.REG_A(REG_A),
	.REG_B(REG_B),
	.REG_PC(REG_PC),
	.ADDR_A(ADDR_A),
	.ADDR_B(ADDR_B),
	.ARG_AX(ARG_AX),
	.ARG_BX(ARG_BX),
	.ALU_A(ALU_A),
	.ALU_B(ALU_B),
	.RBUS(RBUS),
	.DBUS(DBUS),
	.ABUS(ABUS),
	.AOUTENX(AOUTENX),
	.DOUTENX(DOUTENX),
	.DINENX(DINENX),
	.REGAOPX(REGAOPX),
	.REGBOPX(REGBOPX)
);


	initial begin
		SOURCEX = 2'b00;
		GROUPX = 2'b00;
		STX = 0;
		PHASEX = 4'b0000;
		REG_A = 16'h0000;
		REG_B = 16'h1111;
		REG_PC = 16'h6666;
		ARG_AX = 4'b0000;
		ARG_BX = 4'b0000;
		 
	end

	// 100MHz clock generation 


	initial begin		
		#(10*CLOCK_CYCLE);	
		
		GROUPX = 2'b01;
		
		#(2 * CLOCK_CYCLE);
		SOURCEX = 2'b01;
		
		#(2 * CLOCK_CYCLE);
		SOURCEX = 2'b10;
		
		#(2 * CLOCK_CYCLE);
		SOURCEX = 2'b11;
		

		
		#(500*CLOCK_CYCLE) $finish;
	end
	
endmodule