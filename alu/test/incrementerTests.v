`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module incrementerTests;


reg [15:0] REGA_DOUT;
reg ALUA_SRCX;
reg [1:0]  ALUA_CONSTX;

reg CLK;

wire [15:0] ALUA_DIN;
wire [15:0] ALUA_PP;

incrementer testInstance(
	.REGA_DOUT(REGA_DOUT),
	.ALUA_SRCX(ALUA_SRCX),
	.ALUA_CONSTX(ALUA_CONSTX),
	.ALUA_DIN(ALUA_DIN),
	.ALUA_PP(ALUA_PP)
);

// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 0;
	REGA_DOUT = 16'h1234;
	ALUA_SRCX = 1'b0;
	ALUA_CONSTX = 2'b00;
	
	`TICKTOCK;
	`assert("REGA_DOUT", 16'h1234, ALUA_DIN)
	`assert("SUM",       16'h1235, ALUA_PP)
	
	`TICKTOCK;
	ALUA_SRCX = 1'b1;

	`TICKTOCK;
	`assert("SUM", 16'h1235, ALUA_DIN)
	`assert("SUM", 16'h1235, ALUA_PP)
	
	`TICKTOCK;
	ALUA_CONSTX = 2'b01;	
	`TICKTOCK;
	`assert("SUM", 16'h1236, ALUA_DIN)
	`assert("SUM", 16'h1236, ALUA_PP)
	
	`TICKTOCK;
	ALUA_CONSTX = 2'b10;	
	`TICKTOCK;
	`assert("SUM", 16'h1233, ALUA_DIN)
	`assert("SUM", 16'h1233, ALUA_PP)
	
	`TICKTOCK;
	ALUA_CONSTX = 2'b11;	
	`TICKTOCK;
	`assert("SUM", 16'h1232, ALUA_DIN)
	`assert("SUM", 16'h1232, ALUA_PP)
	
	`TICKTOCK;


end

endmodule