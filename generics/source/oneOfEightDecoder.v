`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module oneOfEightDecoder(
	
	input [2:0] ADDR,
	output reg S0,
	output reg S1,
	output reg S2,
	output reg S3,
	output reg S4,
	output reg S5,
	output reg S6,
	output reg S7
); 

always @(*) begin
	case(ADDR)
		3'b000: {S7,S6,S5,S4,S3,S2,S1,S0} = 8'b00000001;
		3'b001: {S7,S6,S5,S4,S3,S2,S1,S0} = 8'b00000010;
		3'b010: {S7,S6,S5,S4,S3,S2,S1,S0} = 8'b00000100;
		3'b011: {S7,S6,S5,S4,S3,S2,S1,S0} = 8'b00001000;
		3'b100: {S7,S6,S5,S4,S3,S2,S1,S0} = 8'b00010000;
		3'b101: {S7,S6,S5,S4,S3,S2,S1,S0} = 8'b00100000;
		3'b110: {S7,S6,S5,S4,S3,S2,S1,S0} = 8'b01000000;
		3'b111: {S7,S6,S5,S4,S3,S2,S1,S0} = 8'b10000000;
	endcase
end

endmodule
	