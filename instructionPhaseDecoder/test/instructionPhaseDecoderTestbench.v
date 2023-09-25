`timescale 1 ns / 1 ns

`include "C:/Users/Duncan/git/ForthCPU/constants.v"


module instruction_phase_decoder_testbench;

parameter CLOCK_CYCLE = 20;

wire FETCH, DECODE, EXECUTE, COMMIT;

reg CLK, RESET;

instructionPhaseDecoder ipd(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT)
);
 
initial begin
	RESET = 0;
	CLK = 0;
	
end

// clk gen
always
	#(CLOCK_CYCLE/2.0) CLK = ~CLK;
	
initial begin

	#(CLOCK_CYCLE * 2);
	#20 RESET = 1;
	#(CLOCK_CYCLE);
	RESET = 0;
	
	#(10 * CLOCK_CYCLE);
end

endmodule