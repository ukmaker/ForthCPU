`timescale 1 ns / 1 ns

module instruction_decoder_testbench;

	parameter CLOCK_CYCLE = 10;
	
	reg [15:0] DIN;
	reg RESETN;
	reg CLK;
	reg CCZ;
	reg CCC;
	reg CCV;
	reg CCP;
	
	wire FETCH;
	wire DECODE;
	wire EXECUTE;
	wire COMMIT;
	
	wire [1:0] REGX;        // Register operation
	wire [3:0] ARGA;        // Register address A
	wire [3:0] ARGB;        // Register address B
	wire [3:0] REG_SOURCEX; // Data source for register file
	wire [3:0] ALU_SOURCEX; // Data sources for ALU
	wire [1:0] ALUX;        // ALU operation
	wire [1:0] ADDRX;       // Address bus control
	wire [1:0] DATAX;       // Data bus control
	
	wire WRITEX;             // Write to memory
	wire READX;              // Read from memory

instruction_decode isd_inst(
	.DIN(DIN),
	.RESETN(RESETN),
	.CLK(CLK),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	
	.REGX(REGX),
	.ARGA(ARGA),
	.ARGB(ARGB),
	.REG_SOURCEX(REG_SOURCEX),
	.ALU_SOURCEX(ALU_SOURCEX),
	.ALUX(ALUX),
	.ADDRX(ADDRX),
	.DATAX(DATAX),

	.READX(READX),
	.WRITEX(WRITEX),
	.CCZ(CCZ),
	.CCV(CCV),
	.CCP(CCP),
	.CCC(CCC)

);


	initial begin
		DIN = 16'h0000;
		CLK = 0;
		RESETN = 1;
		CCZ = 0;
		CCV = 0;
		CCP = 0;
		CCC = 0;
	end

	// 100MHz clock generation 


	initial begin		
		#(10*CLOCK_CYCLE);	
		CLK = 0;
		#(CLOCK_CYCLE);	
		CLK = 1;
		RESETN = 0;
		#(CLOCK_CYCLE);	
		CLK = 0;
		#(CLOCK_CYCLE);	
		CLK = 1;
		RESETN = 1;
		// Group 0 instruction
		DIN = 16'b00_00_00_00_1010_0101;
		#(CLOCK_CYCLE);	
		CLK = 0;
		#(CLOCK_CYCLE);	
		CLK = 0;
		#(CLOCK_CYCLE);	
		CLK = 1;
		#(CLOCK_CYCLE);	
		CLK = 0;
		#(CLOCK_CYCLE);	
		CLK = 1;
		#(CLOCK_CYCLE);	
		CLK = 0;
		#(CLOCK_CYCLE);	
		CLK = 1;
		#(CLOCK_CYCLE);	
		CLK = 0;
		#(CLOCK_CYCLE);	
		CLK = 1;
		#(CLOCK_CYCLE);	

		
		#(500*CLOCK_CYCLE) $finish;
	end
	
endmodule