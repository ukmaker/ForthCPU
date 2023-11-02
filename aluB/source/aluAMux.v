`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/**
* The data mux for the ALU A input
**/
module aluAMux(
	
	input [4:0] U5,
	input [15:0] REGA_DOUT,
	input [2:0] ALUA_SRCX,
	output reg [15:0] ALUA_DATA
);

always @(*) begin
	
	case(ALUA_SRCX)
		`ALUA_SRCX_REG_A:       ALUA_DATA = REGA_DOUT;
		`ALUA_SRCX_ZERO:        ALUA_DATA = 16'h0000;
		`ALUA_SRCX_ONE:         ALUA_DATA = 16'h0001;
		`ALUA_SRCX_TWO:         ALUA_DATA = 16'h0002;
		`ALUA_SRCX_MINUS_ONE:   ALUA_DATA = 16'h0001;
		`ALUA_SRCX_MINUS_TWO:   ALUA_DATA = 16'h0002;
		`ALUA_SRCX_U5:          ALUA_DATA = {11'b00000000000, U5};
		`ALUA_SRCX_U5_0:        ALUA_DATA = {10'b0000000000, U5,1'b0};
	endcase
end

endmodule