`timescale 1 ns / 1 ns


module register_file_testbench;
	
	parameter CLOCK_CYCLE = 10;

	reg [15:0] DIN;
	reg  [3:0] ADDR_A;
	reg  [3:0] ADDR_B;
	reg  [2:0] REGX;
	reg  CLK;
	reg  RESETN;
	
	wire [15:0] DOUT_A;
	wire [15:0] DOUT_B;
	wire [15:0] DOUT_PC;


register_file register_file_inst(
	.DIN(DIN),
	.ADDR_A(ADDR_A),
	.ADDR_B(ADDR_B),
	.REGX(REGX),
	.CLK(CLK),
	.RESETN(RESETN),
	.DOUT_A(DOUT_A),
	.DOUT_B(DOUT_B),
	.DOUT_PC(DOUT_PC)
);

initial begin
	DIN = 16'h0000;
	ADDR_A = 4'b0000;
	ADDR_B = 4'b0000;
	REGX = 3'b000;
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
	REGX = 3'b001;
	RESETN = 1;
	#(CLOCK_CYCLE);	
	CLK = 0;
	#(CLOCK_CYCLE);	
	CLK = 1;
	#(CLOCK_CYCLE);	
	// load r7 with 5432
	ADDR_A = 7;
	DIN = 16'h5432;
	#(CLOCK_CYCLE);	
	CLK = 0;
	#(CLOCK_CYCLE);	
	CLK = 1;
	#(CLOCK_CYCLE);	
	// Increment r7
	REGX = 3'b110;
	#(CLOCK_CYCLE);	
	CLK = 0;
	#(CLOCK_CYCLE);	
	CLK = 1;
	#(CLOCK_CYCLE);	
	REGX = 3'b010;
	#(CLOCK_CYCLE);	
	CLK = 0;
	#(CLOCK_CYCLE);	
	CLK = 1;
	#(CLOCK_CYCLE);	


#(500*CLOCK_CYCLE) $finish;
end
	
endmodule