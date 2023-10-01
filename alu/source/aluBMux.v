`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module aluBMux(
	
	input [15:0] REGB_DOUT,
	input [3:0] ARGA_X,
	input [3:0] ARGB_X,
	
	/**
	* Bits 13:12 of the instruction can supply the top bits of a U6 argument
	* for Load/Store instructions
	**/
	input [1:0] LDS_SRCX,
	input [2:0] ALUB_SRCX,
	
	output reg [15:0] ARGB
	
); 

wire [15:0] U8H;
wire [15:0] U8;
wire [15:0] U4;
wire [15:0] U4_0;
wire [15:0] U6;
wire [15:0] U6_0;
wire [15:0] ZERO;

assign U8H  = {ARGA_X,ARGB_X,REGB_DOUT[7:0]};
assign U8   = {8'h00,ARGA_X,ARGB_X};
assign U4   = {12'h000,ARGB_X};
assign U4_0 = {11'b00000000000,ARGB_X,1'b0};
assign U6   = {10'b0000000000, LDS_SRCX,ARGB_X};
assign U6_0 = { 9'b000000000,  LDS_SRCX,ARGB_X,1'b0};
assign ZERO  = 16'h0000;

always @(*) begin
	case(ALUB_SRCX)
		`ALUB_SRCX_REG_B:    ARGB = REGB_DOUT;
		`ALUB_SRCX_ARG_U4:   ARGB = U4;
		`ALUB_SRCX_ARG_U8:   ARGB = U8;
		`ALUB_SRCX_U8_REG_B: ARGB = U8H;
		`ALUB_SRCX_ARG_U4_0: ARGB = U4_0;
		`ALUB_SRCX_ARG_U6:   ARGB = U6;
		`ALUB_SRCX_ARG_U6_0: ARGB = U6_0;
		`ALUB_SRCX_ZERO:     ARGB = ZERO;
		default:             ARGB = REGB_DOUT;
	endcase
end

endmodule