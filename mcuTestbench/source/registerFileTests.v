`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module registerFileTests;
	
	reg PIN_CLK_X1;
	reg PIN_RESETN;
	
	wire STOPPED, FETCH, DECODE, EXECUTE, COMMIT;
	
	wire [15:0] PIN_ADDR_BUS;
	wire [15:0] PIN_DATA_BUS;

	reg PIN_INT0;
	reg PIN_INT1;
	reg PIN_INT2;
	reg PIN_INT3;
	reg PIN_INT4;
	reg PIN_INT5;
	reg PIN_INT6;
	
	wire PIN_RDN; 
	wire PIN_WR0N; 
	wire PIN_WR1N;
	
	reg PIN_RXD;
	wire PIN_TXD;
	
	reg [3:0] PIN_DIPSW;
	wire [7:0] PIN_LED;
	wire [15:0] ROM_ADDR;
	wire [15:0] ROM_DOUT;

testArticle mcuInst(
	.PIN_CLK_X1(PIN_CLK_X1),
	.PIN_RESETN(PIN_RESETN),
	.STOPPED(STOPPED), .FETCH(FETCH), .DECODE(DECODE), .EXECUTE(EXECUTE), .COMMIT(COMMIT),
	.PIN_ADDR_BUS(PIN_ADDR_BUS),
	.PIN_DATA_BUS(PIN_DATA_BUS),
	.PIN_INT0(PIN_INT0),
	.PIN_INT1(PIN_INT1),
	.PIN_INT2(PIN_INT2),
	.PIN_INT3(PIN_INT3),
	.PIN_INT4(PIN_INT4),
	.PIN_INT5(PIN_INT5),
	.PIN_INT6(PIN_INT6),
	.PIN_RDN(PIN_RDN),
	.PIN_WR0N(PIN_WR0N),
	.PIN_WR1N(PIN_WR1N),
	.PIN_RXD(PIN_RXD),
	.PIN_TXD(PIN_TXD),
	.PIN_DIPSW(PIN_DIPSW),
	.PIN_LED(PIN_LED),
	.ROM_ADDR(ROM_ADDR),
	.ROM_DOUT(ROM_DOUT)
);

registerFileTestROM rom(
	.Address(ROM_ADDR[10:0]),
	.Q(ROM_DOUT) 
);

always begin
	#50 PIN_CLK_X1 = ~PIN_CLK_X1;
end

initial begin
	PIN_CLK_X1 = 0;
	PIN_RESETN = 0;
	`TICKTOCK;
	`TICKTOCK;
	PIN_RESETN = 1;
	`TICKTOCK;
	
end

endmodule
	
	