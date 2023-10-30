`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module GPIOTests;
	
	reg CLK_X1;
	reg RESETN;
	reg [3:0] DIPSW;
	wire [7:0] LED;
	
	reg RD_GPIO;
	reg WR_GPIO;
	
	reg [7:0] GPO;
	
	wire [3:0] GPI;
	wire CLK;
	wire RESET;
	
devBoard testInst(
	.CLK_X1(CLK_X1),
	.RESETN(RESETN),
	.DIPSW(DIPSW),
	.LED(LED),
	.RD_GPIO(RD_GPIO),
	.WR_GPIO(WR_GPIO),
	.GPO(GPO),
	.GPI(GPI),
	.CLK(CLK),
	.RESET(RESET)
);
	
always begin
	#50 CLK_X1 = ~CLK_X1;
end

initial begin
	CLK_X1  = 0;
	RESETN  = 0;
	DIPSW   = 4'b0000;
	RD_GPIO = 0;
	WR_GPIO = 0;
	GPO     = 8'b00000000;
	`TICKTOCK;
	`TICKTOCK;
	`assert("LEDs", 8'b00000000, LED)
	`assert("GPI", 4'b0000, GPI)
	`TICKTOCK;
	WR_GPIO = 1;
	GPO = 8'b00000001;
	`TICKTOCK;
	`assert("LEDs", 8'b00000000, LED)
	`assert("GPI", 4'b0000, GPI)
	RESETN = 1;
	WR_GPIO = 1;
	GPO = 8'b00000001;
	`TICKTOCK;
	`assert("LEDs", 8'b00000001, LED)
	`assert("GPI", 4'b0000, GPI)
	GPO = 8'b00000010;
	DIPSW   = 4'b0001;
	`TICKTOCK;
	`assert("LEDs", 8'b00000010, LED)
	`assert("GPI", 4'b0001, GPI)
	GPO = 8'b000000100;
	DIPSW   = 4'b0010;
	`TICKTOCK;
	`assert("LEDs", 8'b00000100, LED)
	`assert("GPI", 4'b0010, GPI)
	GPO = 8'b00001000;
	DIPSW   = 4'b0100;
	`TICKTOCK;
	`assert("LEDs", 8'b00001000, LED)
	`assert("GPI", 4'b0100, GPI)
	GPO = 8'b00010000;
	DIPSW   = 4'b1000;
	`TICKTOCK;
	`assert("LEDs", 8'b00010000, LED)
	`assert("GPI", 4'b1000, GPI)
	GPO = 8'b00100000;
	`TICKTOCK;
	`assert("LEDs", 8'b00100000, LED)
	`assert("GPI", 4'b1000, GPI)
	GPO = 8'b01000000;
	`TICKTOCK;
	`assert("LEDs", 8'b01000000, LED)
	`assert("GPI", 4'b1000, GPI)
	GPO = 8'b10000000;
	`TICKTOCK;
	`assert("LEDs", 8'b10000000, LED)
	`assert("GPI", 4'b1000, GPI)
end
	
	
endmodule