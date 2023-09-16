`include "C:/Users/Duncan/git/ForthCPU/constants.v"
module programCounterTestbench;

reg clk;
reg pc_resetx;
reg [1:0] pc_opx;
reg [15:0] pc_d;

wire [15:0] pc_a;

programCounter pc(
	clk, pc_resetx, pc_opx, pc_d, pc_a
);

parameter CLOCK_CYCLE = 10;
parameter INSTRUCTION_CYCLE = 80;


initial begin
	#(CLOCK_CYCLE);
	clk = 0;
	pc_resetx = 0;
	#(CLOCK_CYCLE);
	pc_resetx = 1;
	#(CLOCK_CYCLE);
	clk = 1;
	#(CLOCK_CYCLE);
	pc_resetx = 0;
	clk = 0;
	#(CLOCK_CYCLE);
	clk = 1;
	pc_opx = `PC_OP_NOP;
	pc_d = 16'h567E;
	clk = 0;
	#(CLOCK_CYCLE);
	clk = 1;
	#(CLOCK_CYCLE);
	pc_opx = `PC_OP_NEXT;
	#(CLOCK_CYCLE);
	clk = 0;
	#(CLOCK_CYCLE);
	clk = 1;
	#(CLOCK_CYCLE);
	pc_opx = `PC_OP_SKIP;
	#(CLOCK_CYCLE);
	clk = 0;
	#(CLOCK_CYCLE);
	clk = 1;
	#(CLOCK_CYCLE);
	pc_d = 16'h1234;
	pc_opx = `PC_OP_LD;
	#(CLOCK_CYCLE);
	clk = 0;
	#(CLOCK_CYCLE);
	clk = 1;
	#(CLOCK_CYCLE);
	
	clk = 0;
	#(CLOCK_CYCLE);
	clk = 1;
	#(CLOCK_CYCLE);
	clk = 0;
	#(CLOCK_CYCLE);
	clk = 1;
	#(CLOCK_CYCLE);
end
endmodule