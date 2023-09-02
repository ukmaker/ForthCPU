`timescale 1 ns / 1 ns

module register_testbench;

	parameter CLOCK_CYCLE = 10;
	
	reg [15:0] DIN;
	wire [15:0] DOUT;
	reg LD_EN;
	reg INC_DECN;
	reg INC_DEC_EN;
	reg CLK;
	reg RESETN;
	
	register register_inst(
		.DIN(DIN),
		.DOUT(DOUT),
		.INC_DECN(INC_DECN),
		.INC_DEC_EN(INC_DEC_EN),
		.LD_EN(LD_EN),
		.CLK(CLK),
		.RESETN(RESETN)
		);
		

	initial begin
		DIN = 16'b0000000000000000;
		CLK = 1;
		LD_EN = 1;
		INC_DECN = 1;
		INC_DEC_EN = 1;
		RESETN = 0;
	end

	// 100MHz clock generation 


	initial begin		
		#(10*CLOCK_CYCLE);
		// Increment
		INC_DECN = 1;
		CLK = 0;
		#(CLOCK_CYCLE);
		CLK = 1;
		#(CLOCK_CYCLE);
		RESETN = 1;
		CLK = 0;
		#(CLOCK_CYCLE);
		CLK = 1;
		#(CLOCK_CYCLE);
		// decrement
		INC_DECN = 0;
		CLK = 0;
		#(CLOCK_CYCLE);
		CLK = 1;
		#(CLOCK_CYCLE);
		CLK = 0;
		#(CLOCK_CYCLE);
		CLK = 1;
		#(CLOCK_CYCLE);
		// load a value
		//IDN = 1;
		LD_EN = 0;
		CLK = 0;
		DIN = 16'h1234;
		#(CLOCK_CYCLE);
		CLK = 1;
		#(CLOCK_CYCLE);
		CLK = 0;
		LD_EN = 1;
		#(CLOCK_CYCLE);
		CLK = 1;
		#(CLOCK_CYCLE);
		CLK = 0;
		INC_DEC_EN = 0;
		#(CLOCK_CYCLE);
		CLK = 1;
		#(CLOCK_CYCLE);
		CLK = 0;

		#(CLOCK_CYCLE);
		CLK = 1;
		#(CLOCK_CYCLE);
		CLK = 0;

		
		#(500*CLOCK_CYCLE) $finish;
	end
	
endmodule