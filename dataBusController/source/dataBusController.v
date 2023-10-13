`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module dataBusController(

	input [1:0] DATA_BUSX,

	input [15:0] ALU_R,
	input [15:0] ALUB_DATA,

	output reg[15:0]DOUT
	
);
	
always @(*) begin
	case(DATA_BUSX)
		`DATA_BUSX_ALUB_DATA:  DOUT = ALUB_DATA;
		`DATA_BUSX_ALUB_DATAH: DOUT = {8'h00,ALUB_DATA[15:8]};
		default:               DOUT = ALU_R;
	endcase
end

endmodule