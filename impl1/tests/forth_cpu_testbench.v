`timescale 1 ns / 1 ns

module forth_cpu_testbench;

	parameter CLOCK_CYCLE = 10;
	
	reg [15:0] DIN;
	wire [15:0] DOUT;
	wire [15:0] ABUS;
	
	reg CLK;
	reg RESETN;
	reg INTN;
	wire RD_WRN;
	wire MREQN;
	wire HALT;
	wire FETCH;
	wire DECODE;
	wire EXECUTE;
	wire COMMIT;
	
	forth_cpu test_article(
		.DIN(DIN),
		.DOUT(DOUT),
		.ABUS(ABUS),
		.CLK(CLK),
		.RESETN(RESETN),
		.RD_WRN(RD_WRN),
		.MREQN(MREQN),
		.INTN(INTN),
		.HALT(HALT),
		.FETCH(FETCH),
		.DECODE(DECODE),
		.EXECUTE(EXECUTE),
		.COMMIT(COMMIT)
	);

	
	initial begin
		DIN = 16'h0000;
		RESETN = 0;
		CLK = 0;
		INTN = 1;
	end

	// 100MHz clock generation 


	initial begin		
		#(10*CLOCK_CYCLE);
		#(CLOCK_CYCLE);
		CLK = 1;
		#(CLOCK_CYCLE);
		CLK = 0;
		RESETN = 1;
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
		CLK = 0;
		

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