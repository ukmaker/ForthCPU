/**
* The ALU and its output registers**/

module aluBlock(
	input CLK,
	input RESET,
	
	input [15:0] ARGA,
	input [15:0] ARGB,
	input [3:0] ALU_OPX,

	input ALU_LD,

	input CCL_LD,
	
	output wire [15:0] ALU_R,
	output wire [3:0] CCN
);

wire [15:0] RESULT;
wire [3:0] CC;
reg [3:0] CCD;
reg [15:0] RESULT_D;

alu alu_fn(
	.ALUX(ALU_OPX),
	.ARGA(ARGA),
	.ARGB(ARGB),
	.RESULT(RESULT),
	.SIGN(CC[0]),
	.CARRY(CC[1]),
	.ZERO(CC[2]),
	.PARITY(CC[3])
);

always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		CCD <= 4'b0000;
	end else if(CCL_LD == 1'b1) begin
		CCD <= CC;
	end
end

always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		RESULT_D <= 16'h0000;
	end else if(ALU_LD == 1'b1) begin
		RESULT_D <= RESULT;
	end
end

assign CCN = CCD;
assign ALU_R = RESULT_D;

endmodule