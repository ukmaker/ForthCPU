`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/**
* The data mux for the ALU A input
**/
module aluAMux(
	
	input [5:0] U6,
	input [15:0] ALUA_DIN,
	input [2:0] ALUA_SRCX,
	output reg [15:0] ALUA_DATA
	
);

always @(*) begin
	case(ALUA_SRCX)
		`ALUA_SRCX_REG_A: ALUA_DATA = ALUA_DIN;
		`ALUA_SRCX_ZERO:  ALUA_DATA = 16'h0000;
		`ALUA_SRCX_ONE:   ALUA_DATA = 16'h0001;
		`ALUA_SRCX_TWO:   ALUA_DATA = 16'h0002;
		`ALUA_SRCX_U6:    ALUA_DATA = {10'b0000000000,U6};
		`ALUA_SRCX_U6_0:  ALUA_DATA = {9'b000000000,U6,1'b0};
	endcase
end

endmodule