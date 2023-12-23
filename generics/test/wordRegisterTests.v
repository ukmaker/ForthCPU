`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module wordRegisterTests;
	
	reg CLK, RESET, EN0, EN1, LD;
	reg [7:0] DIN;
	
	wire [15:0] DOUT;
	
	
	wordRegister DUT(
		.CLK(CLK),
		.RESET(RESET),
		.EN0(EN0),
		.EN1(EN1),
		.LD(LD),
		.DIN(DIN),
		.DOUT(DOUT)
	);
	
always begin
	#40 CLK = ~CLK;
end

initial begin

	CLK = 0;
	EN0 = 0;
	EN1 = 0;
	LD = 0;
	RESET = 1;
	`TICKTOCK;
	RESET = 0;
	DIN = 8'haa;
	`TICKTOCK;
	RESET = 1;
	`TICKTOCK;
	RESET = 0;
	`assert("DOUT", 16'h0000, DOUT)
	LD = 1;
	`TICKTOCK;	
	`assert("DOUT", 16'h0000, DOUT)
	LD = 0;
	EN0 = 1;
	`TICKTOCK;	
	`assert("DOUT", 16'h0000, DOUT)
	EN0 = 0;
	EN1 = 1;
	`TICKTOCK;	
	`assert("DOUT", 16'h0000, DOUT)
	EN0 = 1;
	EN1 = 0;
	LD  = 1;
	`TICKTOCK;	
	`assert("DOUT", 16'h00aa, DOUT)
	EN0 = 0;
	EN1 = 1;
	DIN = 8'h55;
	`TICKTOCK;	
	`assert("DOUT", 16'h55aa, DOUT)
	EN0 = 0;
	EN1 = 0;
	LD  = 1;
	`TICKTOCK;	
	`assert("DOUT", 16'h55aa, DOUT)
	EN0 = 0;
	EN1 = 0;
	LD  = 0;
	`TICKTOCK;	
	`assert("DOUT", 16'h55aa, DOUT)
	
end

endmodule
