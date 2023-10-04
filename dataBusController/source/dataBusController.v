`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module dataBusController(

	input DATA_BUSX,

	input [15:0] ALU_R,
	input [15:0] ALUB_DATA,

	output reg[15:0]DOUT
	
);
	
always @(*) begin
	case(DATA_BUSX)
		`DATA_BUSX_ALU_R:     DOUT = ALU_R;
		`DATA_BUSX_ALUB_DATA: DOUT = ALUB_DATA;
	endcase
end

endmodule