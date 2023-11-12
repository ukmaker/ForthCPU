`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module interruptMaskRegisterTests;
	
	reg CLK, RESET;
	reg [15:0] DIN;
	reg RD, WR;
	reg [1:0] ADDR;
	
	reg INTS1;
	reg INTS2;
	reg INTS3;
	reg INTS4;
	reg INTS5;
	reg INTS6;
	reg INTS7;
	
	wire [15:0] DOUT;
	wire INT1;
	
	interruptMaskRegister testInst(
		.CLK(CLK),
		.RESET(RESET),
		.DIN(DIN[7:0]),
		.RD(RD),
		.WR(WR),
		.ADDR(ADDR),
		.INTS1(INTS1),
		.INTS2(INTS2),
		.INTS3(INTS3),
		.INTS4(INTS4),
		.INTS5(INTS5),
		.INTS6(INTS6),
		.INTS7(INTS7),
		.DOUT(DOUT),
		.INT1(INT1)
	);
	

// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 0;
	#60
	RESET = 1;
	DIN = 16'h0000;
	ADDR = 2'b00;
	INTS1 = 0;
	INTS2 = 0;
	INTS3 = 0;
	INTS4 = 0;
	INTS5 = 0;
	INTS6 = 0;
	INTS7 = 0;
	`TICKTOCK;
	RESET = 0;
	`TICKTOCK;
	
	// force all interrupts, but no active mask yet
	INTS1 = 1;
	INTS2 = 1;
	INTS3 = 1;
	INTS4 = 1;
	INTS5 = 1;
	INTS6 = 1;
	INTS7 = 1;
	`TICKTOCK;
	`assert("INT1", 0, INT1)
	// Activate the interrupts in descending order
	ADDR = `INT_MASK;
	DIN = 16'b00000000_10000000;
	WR = 1;
	`TICKTOCK;
	WR = 0;
	`TICKTOCK;
	`assert("INT1", 1, INT1)
	// Check the registers
	ADDR = `INT_INTS;
	WR = 0;
	RD = 1;
	`TICKTOCK;
	`assert("INTS", 16'b00000000_10000000, DOUT)
	ADDR = `INT_PRI;
	`TICKTOCK;
	`assert("PRI", 16'h0007, DOUT)
	
	
	ADDR = `INT_MASK;
	DIN = 16'b00000000_11000000;
	WR = 1;
	`TICKTOCK;
	WR = 0;
	`TICKTOCK;
	`assert("INT1", 1, INT1)
	// Check the registers
	ADDR = `INT_INTS;
	WR = 0;
	RD = 1;
	`TICKTOCK;
	`assert("INTS", 16'b00000000_11000000, DOUT)
	ADDR = `INT_PRI;
	`TICKTOCK;
	`assert("PRI", 16'h0006, DOUT)
	
	
	
	ADDR = `INT_MASK;
	DIN = 16'b00000000_11100000;
	WR = 1;
	`TICKTOCK;
	WR = 0;
	`TICKTOCK;
	`assert("INT1", 1, INT1)
	// Check the registers
	ADDR = `INT_INTS;
	WR = 0;
	RD = 1;
	`TICKTOCK;
	`assert("INTS", 16'b00000000_11100000, DOUT)
	ADDR = `INT_PRI;
	`TICKTOCK;
	`assert("PRI", 16'h0005, DOUT)
	
	
	
	ADDR = `INT_MASK;
	DIN = 16'b00000000_11110000;
	WR = 1;
	`TICKTOCK;
	WR = 0;
	`TICKTOCK;
	`assert("INT1", 1, INT1)
	// Check the registers
	ADDR = `INT_INTS;
	WR = 0;
	RD = 1;
	`TICKTOCK;
	`assert("INTS", 16'b00000000_11110000, DOUT)
	ADDR = `INT_PRI;
	`TICKTOCK;
	`assert("PRI", 16'h0004, DOUT)
	
	
	
	ADDR = `INT_MASK;
	DIN = 16'b00000000_11111000;
	WR = 1;
	`TICKTOCK;
	WR = 0;
	`TICKTOCK;
	`assert("INT1", 1, INT1)
	// Check the registers
	ADDR = `INT_INTS;
	WR = 0;
	RD = 1;
	`TICKTOCK;
	`assert("INTS", 16'b00000000_11111000, DOUT)
	ADDR = `INT_PRI;
	`TICKTOCK;
	`assert("PRI", 16'h0003, DOUT)
	
	
	
	ADDR = `INT_MASK;
	DIN = 16'b00000000_11111100;
	WR = 1;
	`TICKTOCK;
	WR = 0;
	`TICKTOCK;
	`assert("INT1", 1, INT1)
	// Check the registers
	ADDR = `INT_INTS;
	WR = 0;
	RD = 1;
	`TICKTOCK;
	`assert("INTS", 16'b00000000_11111100, DOUT)
	ADDR = `INT_PRI;
	`TICKTOCK;
	`assert("PRI", 16'h0002, DOUT)
	
	
	
	ADDR = `INT_MASK;
	DIN = 16'b00000000_11111110;
	WR = 1;
	`TICKTOCK;
	WR = 0;
	`TICKTOCK;
	`assert("INT1", 1, INT1)
	// Check the registers
	ADDR = `INT_INTS;
	WR = 0;
	RD = 1;
	`TICKTOCK;
	`assert("INTS", 16'b00000000_11111110, DOUT)
	ADDR = `INT_PRI;
	`TICKTOCK;
	`assert("PRI", 16'h0001, DOUT)
	
	
	
	INTS1 = 0;
	INTS2 = 0;
	INTS3 = 0;
	INTS4 = 0;
	INTS5 = 0;
	INTS6 = 0;
	INTS7 = 0;
	`TICKTOCK;
	`assert("INT1", 0, INT1)
	// Check the registers
	ADDR = `INT_INTS;
	WR = 0;
	RD = 1;
	`TICKTOCK;
	`assert("INTS", 16'b00000000_00000000, DOUT)
	ADDR = `INT_PRI;
	`TICKTOCK;
	`assert("PRI", 16'h0000, DOUT)
	
	
	
	
end
		
endmodule
		