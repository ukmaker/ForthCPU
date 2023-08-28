`timescale 1 ns / 1 ns

module register_testbench;

	parameter CLOCK_CYCLE = 10;
	
	reg [15:0] DIN;
	wire [15:0] DBUS_A;
	wire [15:0] DBUS_B;
	reg LDN;
	reg IDN;
	reg OEN_A;
	reg OEN_B;
	reg INC_DECN;
	reg CLK;
	reg RESETN;
	
	register register_inst(
		.DIN(DIN),
		.DBUS_A(DBUS_A),
		.DBUS_B(DBUS_B),
		.INC_DECN(INC_DECN),
		.LDN(LDN),
		.OEN_A(OEN_A),
		.OEN_B(OEN_B),
		.IDN(IDN),
		.CLK(CLK),
		.RESETN(RESETN)
		);
		

	initial begin
		DIN = 16'b0000000000000000;
		CLK = 1;
		LDN = 1;
		IDN = 1;
		OEN_A = 1;
		OEN_B = 1;
		INC_DECN = 1;
		RESETN = 0;
	end

	// 100MHz clock generation 


	initial begin		
		#(10*CLOCK_CYCLE);
		// Increment
		IDN = 0;
		CLK = 0;
		OEN_A = 0;
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
		LDN = 0;
		CLK = 0;
		DIN = 16'h1234;
		#(CLOCK_CYCLE);
		CLK = 1;
		#(CLOCK_CYCLE);
		CLK = 0;
		LDN = 1;
		OEN_A = 1;
		OEN_B = 0;
		#(CLOCK_CYCLE);
		CLK = 1;
		#(CLOCK_CYCLE);
		CLK = 0;
		IDN = 0;
		#(CLOCK_CYCLE);
		CLK = 1;
		#(CLOCK_CYCLE);
		CLK = 0;
		OEN_B = 1;

		#(CLOCK_CYCLE);
		CLK = 1;
		#(CLOCK_CYCLE);
		CLK = 0;

		
		#(500*CLOCK_CYCLE) $finish;
	end
	
endmodule