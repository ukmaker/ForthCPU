`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module dataBusController(

	input [1:0] DATA_BUSX,
	input [15:0] ALU_R,
	input [15:0] REGA_DOUT,
	input [15:0] DEBUG_DOUT,
	input [3:0]  CCREGS_DOUT,

	output reg[15:0] DOUT
	
);

reg [15:0] DATA_OUT;

always @(*) begin
	case(DATA_BUSX) 
		`DATA_BUSX_REGA_DOUT: DOUT = REGA_DOUT;
		`DATA_BUSX_ALU_R:     DOUT = ALU_R;
		`DATA_BUSX_DEBUG:     DOUT = DEBUG_DOUT;
		`DATA_BUSX_CCREGS:    DOUT = {12'h000,CCREGS_DOUT};
	endcase
end

endmodule