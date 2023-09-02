`timescale 1 ns / 1 ns

module regs_testbench;

	parameter CLOCK_CYCLE = 10;
		reg [15:0] din;
		reg [3:0] addr_a;
		reg [3:0] addr_b;
		wire [15:0] dout_a;
		wire [15:0] dout_b;
		reg clk;
		reg wrn;

	registers regs_inst(
	.din(din),
	.addr_a(addr_a),
	.addr_b(addr_b),
	.wrn(wrn),
	.clk(clk),
	.dout_a(dout_a),
	.dout_b(dout_b)
	);
	
	initial begin
		din = 16'h0000;
		addr_a = 4'b0000;
		addr_b = 4'b0001;
		clk = 0;
		wrn = 1;
	end

	// 100MHz clock generation 


	initial begin		
		#(10*CLOCK_CYCLE);
		din = 16'ha531;
		addr_a = 4'h0;
		wrn = 0;
		
		#(CLOCK_CYCLE);
		#2 clk = 1;
		
		#(CLOCK_CYCLE);
		#2 clk = 0;
		#2 wrn = 1;
		
		#(CLOCK_CYCLE);
		addr_a = 4'h1;
		addr_b = 4'h0;

		
		#(500*CLOCK_CYCLE) $finish;
	end
	
endmodule