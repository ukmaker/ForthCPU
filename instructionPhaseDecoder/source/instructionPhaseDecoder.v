`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`timescale 1 ns / 1 ns
module instructionPhaseDecoder(
	input               CLK,
	input               RESET,
	input [15:0]       DIN,
	input               PC_ENX,
	input               DEBUG_STOPX,
	output reg          STOPPED,
	output reg          FETCH,
	output reg          DECODE,
	output reg          EXECUTE,
	output reg          COMMIT,
	output reg [15:0]  INSTRUCTION
);

// Internal state
reg [3:0] PHASE;

always @ (posedge CLK or posedge RESET)
begin
	if(RESET) begin
		PHASE <= 0;
	end else if(PC_ENX) begin
		case (PHASE)
			`PHI_STOPPED: begin
				STOPPED <= 1;
				FETCH <= 0;
				DECODE <= 0;
				EXECUTE <= 0;
				COMMIT <= 0;
				if(!DEBUG_STOPX) PHASE <= `PHI_FETCH;
				end

			`PHI_FETCH: begin
				STOPPED <= 0;
				FETCH <= 1;
				DECODE <= 0;
				EXECUTE <= 0;
				COMMIT <= 0;
				PHASE  <= `PHI_DECODE;
				end

			`PHI_DECODE: begin
				STOPPED <= 0;
				FETCH <= 0;
				DECODE <= 1;
				EXECUTE <= 0;
				COMMIT <= 0;	
				PHASE <= `PHI_EXECUTE;
			end

			`PHI_EXECUTE: begin
				STOPPED <= 0;
				FETCH <= 0;
				DECODE <= 0;
				EXECUTE <= 1;
				COMMIT <= 0;
				PHASE <= `PHI_COMMIT;
			end

			`PHI_COMMIT: begin
				STOPPED <= 0;
				FETCH <= 0;
				DECODE <= 0;
				EXECUTE <= 0;
				COMMIT <= 1;
				if(DEBUG_STOPX) begin
					PHASE <= `PHI_STOPPED;
				end else begin
					PHASE <= `PHI_FETCH;
				end
			end

		endcase
	end
end

always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		INSTRUCTION <= 0;
	end else if(DECODE) begin
		INSTRUCTION <= DIN;
	end
end

endmodule