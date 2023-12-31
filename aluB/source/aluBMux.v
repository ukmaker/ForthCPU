`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/**
* The data mux for the ALU B input
**/
module aluBMux(
	
	input [15:0] REGB_DOUT,
	input [2:0] ALUB_SRCX,
	
	input [3:0] ARGA_X,
	input [3:0] ARGB_X,
	
	output reg [15:0] ALUB_DATA
	 
);

always @(*) begin
	case(ALUB_SRCX)
		`ALUB_SRCX_REG_B: ALUB_DATA = REGB_DOUT;
		`ALUB_SRCX_U8H:   ALUB_DATA = { ARGA_X,ARGB_X,REGB_DOUT[7:0]};
		`ALUB_SRCX_U8:    ALUB_DATA = {  8'h00,ARGA_X,ARGB_X};
		`ALUB_SRCX_S8:    begin
			if(ARGA_X[3]) begin
				ALUB_DATA = {  8'hff,ARGA_X,ARGB_X};
			end else begin
				ALUB_DATA = {  8'h00,ARGA_X,ARGB_X};
			end
		end
		`ALUB_SRCX_U4:    ALUB_DATA = {12'h000,ARGB_X};
		`ALUB_SRCX_U4_0:  ALUB_DATA = {11'h000,ARGB_X,1'b0};
		default:          ALUB_DATA =  16'h0000;
	endcase
end

endmodule