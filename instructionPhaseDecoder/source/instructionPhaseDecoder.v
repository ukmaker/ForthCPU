`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`timescale 1 ns / 1 ns
module instructionPhaseDecoder(
	input CLK,
	input RESET,
	output reg FETCH,
	output reg DECODE,
	output reg EXECUTE,
	output reg COMMIT
);

// Internal state
reg [2:0] PHASE;

always @ (posedge RESET)
begin
	PHASE = 0;
end

always @ (posedge CLK)
begin
	#10
	case (PHASE)
		0: begin
			FETCH = 0;
			DECODE = 0;
			EXECUTE = 0;
			COMMIT = 0;
			PHASE <= 1;
			end

		1: begin
			FETCH = 1;
			DECODE = 0;
			EXECUTE = 0;
			COMMIT = 0;
			PHASE <= 2;
			end

		2: begin
			FETCH = 0;
			DECODE = 1;
			EXECUTE = 0;
			COMMIT = 0;	
			PHASE <= 3;
		end

		3: begin
			FETCH = 0;
			DECODE = 0;
			EXECUTE = 1;
			COMMIT = 0;
			PHASE <= 4;
		end

		4: begin
			FETCH = 0;
			DECODE = 0;
			EXECUTE = 0;
			COMMIT = 1;
			PHASE <= 1;
		end

	endcase
end
endmodule