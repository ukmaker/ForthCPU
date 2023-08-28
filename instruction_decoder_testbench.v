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
	
	wire [1:0] GPX;
	wire [3:0] OPX;
	wire [1:0] INCX;
	wire [1:0] CCX;
	wire [1:0] SKIPX;
	wire [1:0] ARGX;
	wire [3:0] ARGA;
	wire [3:0] ARGB;

	wire [1:0] BUSX;
	wire [1:0] ADDRX;
	wire [1:0] DINX;
	wire [1:0] DOUTX;
	wire [3:0] ALUX;
	wire [2:0] SOURCEX;
	
	wire WRITEX;

instruction_decode isd_inst(
	.DIN(DIN),
	.RESETN(RESETN),
	.CLK(CLK),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.GPX(GPX),
	.OPX(OPX),
	.INCX(INCX),
	.CCX(CCX),
	.SKIPX(SKIPX),
	.ARGX(ARGX),
	.ARGA(ARGA),
	.ARGB(ARGB),
	.BUSX(BUSX),
	.ADDRX(ADDRX),
	.DINX(DINX),
	.DOUTX(DOUTX),
	.ALUX(ALUX),
	.SOURCEX(SOURCEX),
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