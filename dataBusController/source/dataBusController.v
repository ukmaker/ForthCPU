`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module dataBusController(

	input [1:0] DATA_BUSX,
	
	input [15:0] PC_A,
	input [15:0] ALU_R,
	input [15:0] REGA_DOUT,

	output reg[15:0]DOUT
	
);
	
always @(DATA_BUSX) begin
	case(DATA_BUSX)
		`DATA_BUSX_PC_A: DOUT = PC_A;
		`DATA_BUSX_ALU_R: DOUT = ALU_R;
		`DATA_BUSX_REGA_DOUT: DOUT = REGA_DOUT;
		default: DOUT = PC_A;
	endcase
end

endmodule