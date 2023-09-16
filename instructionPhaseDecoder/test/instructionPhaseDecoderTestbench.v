module instruction_phase_decoder_testbench;

parameter CLOCK_CYCLE = 20;

wire fetch, decode, execute, commit;

reg clk, reset;

instruction_phase_decoder ipd(
	.clk(clk),
	.reset(reset),
	.fetch(fetch),
	.decode(decode),
	.execute(execute),
	.commit(commit)
);

initial begin
	reset = 0;
	clk = 0;
	
end

// clk gen
always
	#(CLOCK_CYCLE/2.0) clk = ~clk;
	
initial begin

	#(CLOCK_CYCLE * 2);
	#20 reset = 1;
	#(CLOCK_CYCLE);
	reset = 0;
	
	#(10 * CLOCK_CYCLE);
end

endmodule