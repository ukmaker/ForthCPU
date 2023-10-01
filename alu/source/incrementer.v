`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module incrementer(
	
	input ALUA_SRCX,
	input [15:0] REGA_DOUT,
	input [1:0] ALUA_CONSTX,
	
	output [15:0] ALUA_DIN,
	output [15:0] ALUA_PP
);

wire [15:0] MINUS_TWO;
wire [15:0] MINUS_ONE;
wire [15:0] ONE;
wire [15:0] TWO;
reg [15:0] CONST;
reg [15:0] SUM;

assign ONE       = 16'h0001;
assign TWO       = 16'h0002;
assign MINUS_ONE = 16'hffff;
assign MINUS_TWO = 16'hfffe;
	
always @(*) begin
	case(ALUA_CONSTX)
		`ALUA_CONSTX_ONE:       CONST = ONE;
		`ALUA_CONSTX_TWO:       CONST = TWO;
		`ALUA_CONSTX_MINUS_ONE: CONST = MINUS_ONE;
		`ALUA_CONSTX_MINUS_TWO: CONST = MINUS_TWO;
	endcase
	SUM = CONST + REGA_DOUT;
end

assign ALUA_PP = SUM;
assign ALUA_DIN = (ALUA_SRCX == `ALUA_SRCX_REG_A) ? REGA_DOUT : SUM;

endmodule