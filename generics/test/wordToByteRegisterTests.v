`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"


module wordToByteRegisterTests;
	
	reg         CLK;
	reg         RESET;
	reg         LD;
	
	reg         SEL;
	reg  [15:0] D;
	wire [7:0] Q;
	
wordToByteRegister testArticle(

	.CLK(CLK),
	.RESET(RESET),
	.LD(LD),
	.SEL(SEL),
	.D(D),
	.Q(Q)
);

always begin
	// Fast clock
	#50 CLK = ~CLK;
end

initial begin
	
	CLK = 0;
	RESET = 0;
	SEL = 0;
	LD = 0;
	D = 16'ha55a;
	`TICKTOCK;
	RESET = 1;
	`TICKTOCK;
	RESET = 0;
	`TICKTOCK;
	`assert("Q", 8'h00, Q)
	`TICKTOCK;
	`assert("Q", 8'h00, Q)
	`TICKTOCK;
	`assert("Q", 8'h00, Q)
	`TICKTOCK;
	LD = 1;
	`TICKTOCK;
	`assert("Q", 8'h5a, Q)
	LD = 0;
	`TICKTOCK;
	`assert("Q", 8'h5a, Q)
	`TICKTOCK;
	`assert("Q", 8'h5a, Q)
	`TICKTOCK;
	`assert("Q", 8'h5a, Q)
	SEL = 1;
	`TICKTOCK;
	`assert("Q", 8'ha5, Q)
	`TICKTOCK;
	`assert("Q", 8'ha5, Q)
	`TICKTOCK;
	`assert("Q", 8'ha5, Q)
	`TICKTOCK;

end

endmodule