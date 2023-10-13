`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module addressBusController(
	
	input [15:0] PC_A,
	input [15:0] ALU_R,
	input [15:0] ALUB_DATA,
	
	input [1:0] ADDR_BUSX,
	
	output reg [15:0] ADDR
);
	
always @(*) begin
	case(ADDR_BUSX)
		`ADDR_BUSX_PC_A:      ADDR = PC_A;
		`ADDR_BUSX_ALU_R:     ADDR = ALU_R;
		`ADDR_BUSX_ALUB_DATA: ADDR = ALUB_DATA;
		default:              ADDR = ALUB_DATA;
	endcase
end
	
endmodule