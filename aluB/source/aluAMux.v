`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/**
* The data mux for the ALU A input
**/
module aluAMux(
	
	input [5:0] U6,
	input [15:0] REGA_DOUT,
	input [2:0] ALUA_SRCX,
	output reg [15:0] ALUA_DATA
);

reg [15:0] S6;

always @(*) begin
	
	if(U6[5]) begin
		S6 = {10'b1111111111,U6};
	end else begin
		S6 = {10'b0000000000,U6};
	end
	
	case(ALUA_SRCX)
		`ALUA_SRCX_REG_A:       ALUA_DATA = REGA_DOUT;
		`ALUA_SRCX_ZERO:        ALUA_DATA = 16'h0000;
		`ALUA_SRCX_ONE:         ALUA_DATA = 16'h0001;
		`ALUA_SRCX_TWO:         ALUA_DATA = 16'h0002;
		`ALUA_SRCX_MINUS_ONE:   ALUA_DATA = 16'h0001;
		`ALUA_SRCX_MINUS_TWO:   ALUA_DATA = 16'h0002;
		`ALUA_SRCX_S6:          ALUA_DATA = S6;
		`ALUA_SRCX_S6_0:        ALUA_DATA = {S6[14:0],1'b0};
	endcase
end

endmodule