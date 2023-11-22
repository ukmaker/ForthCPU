`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module requestGeneratorTests;
	
	reg CLK;
	reg RESET;
	reg WR;
	reg RD;
	reg ACKX;
	
	reg EN_OP;
	reg EN_MDH;
	
	wire REQX;
	
requestGenerator testInstance(
	.CLK(CLK),
	.RESET(RESET),
	.WR(WR),
	.RD(RD),
	.ACKX(ACKX),
	.EN_OP(EN_OP),
	.EN_MDH(EN_MDH),
	.REQX(REQX)
);
	
always begin
	#50 CLK = ~CLK;
end

initial begin

	CLK     = 1'b1;
	RESET   = 1'b1;
	WR      = 1'b0;
	RD      = 1'b0;
	ACKX    = 1'b0;
	EN_OP   = 1'b0;
	EN_MDH  = 1'b0;
	
	`TICKTOCK;
	RESET = 1'b0;
	`TICKTOCK;
	`assert("REQX", 1'b0, REQX)
	
	WR = 1'b1;
	`TICKTOCK;
	`assert("REQX", 1'b0, REQX)
	WR = 1'b0;
	`TICKTOCK;
	`assert("REQX", 1'b0, REQX)
	EN_OP = 1'b1;
	`TICKTOCK;
	`assert("REQX", 1'b0, REQX)
	WR = 1'b1;
	`TICKTOCK;
	`assert("REQX", 1'b0, REQX)
	WR = 1'b0;
	EN_OP = 1'b0;
	`TICKTOCK;
	`TICKTOCK;
	`assert("REQX", 1'b1, REQX)
	`TICK;
	ACKX = 1'b1;
	`TOCK;
	`TICKTOCK;
	ACKX = 1'b0;
	`TICKTOCK;
	`assert("REQX", 1'b0, REQX)
		

	`TICKTOCK;
	RD = 1'b1;
	`TICKTOCK;
	`assert("REQX", 1'b0, REQX)
	RD = 1'b0;
	`TICKTOCK;
	`assert("REQX", 1'b0, REQX)
	EN_MDH = 1'b1;
	`TICKTOCK;
	`assert("REQX", 1'b0, REQX)
	RD = 1'b1;
	`TICK;
	`assert("REQX", 1'b0, REQX)
	RD = 1'b0;
	`TOCK;
	`assert("REQX", 1'b0, REQX)
	`TICKTOCK;
	`TICKTOCK;
	`assert("REQX", 1'b1, REQX)
	`TICKTOCK;
	EN_MDH = 1'b0;
	`assert("REQX", 1'b1, REQX)
	`TICKTOCK;
	`TICK;
	ACKX = 1'b1;
	`TOCK;
	`TICKTOCK;
	ACKX = 1'b0;
	`TICKTOCK;
	`assert("REQX", 1'b0, REQX)
		
end

endmodule