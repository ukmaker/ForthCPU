`timescale 1 ns / 1 ns

`include "../../constants.v"
`include "../../testSetup.v"


module instruction_phase_decoder_testbench;

parameter CLOCK_CYCLE = 20;

wire FETCH, DECODE, EXECUTE, COMMIT;

reg CLK, RESET;
reg [15:0] DIN;

wire [15:0] INSTRUCTION;

instructionPhaseDecoder ipd(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.DIN(DIN),
	.INSTRUCTION(INSTRUCTION)
);
 
initial begin
	RESET = 0;
	CLK = 0;
end

// clk gen
always
	#(CLOCK_CYCLE/2.0) CLK = ~CLK;
	
initial begin
	`TICKTOCK;
	RESET = 1;
	`TICKTOCK;
	RESET = 0;
	`TICKTOCK;
	DIN = 16'hzzzz;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	DIN = 16'h1111;
	`TICKTOCK;
	DIN = 16'h2222;
	`TICKTOCK;
	DIN = 16'h3333;
	`TICKTOCK;
	DIN = 16'h4444;
	`TICKTOCK;
	`TICKTOCK;
	
	
end

endmodule