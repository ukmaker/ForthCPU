`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module oneOfSixteenDecoder(
	
	input [3:0] ADDR,
	input EN0,
	input EN1,
	output reg S0,
	output reg S1,
	output reg S2,
	output reg S3,
	output reg S4,
	output reg S5,
	output reg S6,
	output reg S7,
	output reg S8,
	output reg S9,
	output reg S10,
	output reg S11,
	output reg S12,
	output reg S13,
	output reg S14,
	output reg S15
); 

always @(*) begin
	if(EN0 & EN1) begin
		case(ADDR)
			4'b0000: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b0000000000000001;
			4'b0001: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b0000000000000010;
			4'b0010: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b0000000000000100;
			4'b0011: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b0000000000001000;
			4'b0100: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b0000000000010000;
			4'b0101: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b0000000000100000;
			4'b0110: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b0000000001000000;
			4'b0111: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b0000000010000000;
			4'b1000: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b0000000100000000;
			4'b1001: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b0000001000000000;
			4'b1010: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b0000010000000000;
			4'b1011: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b0000100000000000;
			4'b1100: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b0001000000000000;
			4'b1101: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b0010000000000000;
			4'b1110: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b0100000000000000;
			4'b1111: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b1000000000000000;
		endcase
	end else begin
			4'b0000: {S15,S14,S13,S12,S11,S10,S9,S8,S7,S6,S5,S4,S3,S2,S1,S0} = 16'b0000000000000000;
	end
end

endmodule
	