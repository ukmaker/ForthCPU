`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/**
* The data mux for the ALU A input
**/
module aluAMux(
	
	input [15:0] ALUA_DIN,
	input [1:0] ALUA_SRCX,
	output reg [15:0] ALUA_DATA
	
);

always @(*) begin
	case(ALUA_SRCX)
		`ALUA_SRCX_REG_A: ALUA_DATA = ALUA_DIN;
		`ALUA_SRCX_ZERO:  ALUA_DATA = 16'h0000;
		`ALUA_SRCX_ONE:   ALUA_DATA = 16'h0001;
		`ALUA_SRCX_TWO:   ALUA_DATA = 16'h0002;
	endcase
end

endmodule