`timescale 1 ns / 1 ns


module register_file_testbench;
	
	parameter CLOCK_CYCLE = 10;

	reg [15:0] DIN;
	reg [3:0] REGAX;
	reg [3:0] REGBX;
	reg REGAOPX;
	reg [1:0] REGBOPX;
	reg CLK;
	reg RESETN;
	
	wire [15:0] DOUT_A;
	wire [15:0] DOUT_B;
	wire [15:0] DOUT_PC;


register_file register_file_inst(
	.DIN(DIN),
	.REGAX(REGAX),
	.REGBX(REGBX),
	.REGAOPX(REGAOPX),
	.REGBOPX(REGBOPX),
	.CLK(CLK),
	.RESETN(RESETN),
	.DOUT_A(DOUT_A),
	.DOUT_B(DOUT_B),
	.DOUT_PC(DOUT_PC)
);

initial begin
	DIN = 16'h0000;
	REGAX = 4'b0000;
	REGBX = 4'b0000;
	REGAOPX = 0;
	REGBOPX = 2'b00;
	CLK = 1;
	RESETN = 1;
end


initial begin		
	#(10*CLOCK_CYCLE);	
	// Reset
	RESETN = 0;
	CLK = 0;
	#(CLOCK_CYCLE);	
	CLK = 1;
	#(CLOCK_CYCLE);	
	// Load R0 with 1234
	DIN = 16'h1234;
	REGAOPX = 1;
	RESETN = 1;
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
	// load r7 with 5432
	REGAX = 7;
	DIN = 16'h5432;
	#(CLOCK_CYCLE);	
	CLK = 0;
	#(CLOCK_CYCLE);	
	CLK = 1;
	#(CLOCK_CYCLE);	
	// Increment r7
	REGAOPX = 0;
	REGBOPX = 2'b11;
	#(CLOCK_CYCLE);	
	CLK = 0;
	#(CLOCK_CYCLE);	
	CLK = 1;
	#(CLOCK_CYCLE);	
	REGBOPX = 2'b01;
	#(CLOCK_CYCLE);	
	CLK = 0;
	#(CLOCK_CYCLE);	
	CLK = 1;
	#(CLOCK_CYCLE);	


#(500*CLOCK_CYCLE) $finish;
end
	
endmodule