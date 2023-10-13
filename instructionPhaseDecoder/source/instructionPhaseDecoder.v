`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`timescale 1 ns / 1 ns
module instructionPhaseDecoder(
	input CLK,
	input RESET,
	input [15:0] DIN,
	output reg FETCH,
	output reg DECODE,
	output reg EXECUTE,
	output reg COMMIT,
	output reg [15:0] INSTRUCTION
);

// Internal state
reg [2:0] PHASE;

always @ (posedge CLK or posedge RESET)
begin
	#10
	if(RESET) begin
		PHASE = 0;
		INSTRUCTION = 16'h0000;
	end else begin
		case (PHASE)
			0: begin
				FETCH = 0;
				DECODE = 0;
				EXECUTE = 0;
				COMMIT = 0;
				PHASE = 1;
				end

			1: begin
				FETCH = 1;
				DECODE = 0;
				EXECUTE = 0;
				COMMIT = 0;
				PHASE = 2;
				end

			2: begin
				FETCH = 0;
				DECODE = 1;
				EXECUTE = 0;
				COMMIT = 0;	
				PHASE = 3;
			end

			3: begin
				FETCH = 0;
				DECODE = 0;
				EXECUTE = 1;
				COMMIT = 0;
				PHASE = 4;
			end

			4: begin
				FETCH = 0;
				DECODE = 0;
				EXECUTE = 0;
				COMMIT = 1;
				PHASE = 1;
			end

		endcase
	end
end

always @(posedge CLK) begin
	if(DECODE) begin
		INSTRUCTION <= DIN;
	end
end

endmodule