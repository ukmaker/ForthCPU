`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module addressBusController(
	
	input [15:0] PC_A,
	input [15:0] ALU_R,
	input [15:0] REG_B,
	input [15:0] ALUA_DIN,
	
	input [1:0] ADDR_BUSX,
	
	output reg [15:0] ADDR
);
	
always @(*) begin
	case(ADDR_BUSX)
		`ADDR_BUSX_PC:       ADDR = PC_A;
		`ADDR_BUSX_ALU_R:    ADDR = ALU_R;
		`ADDR_BUSX_REG_B:    ADDR = REG_B;
		`ADDR_BUSX_ALUA_DIN: ADDR = ALUA_DIN;
	endcase
end
	
endmodule