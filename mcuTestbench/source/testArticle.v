/**
* CPU and RAM
* Supply an eternal ROM to run tests
* UART, GPIO and INT mask
**/
`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module testArticle(
	
	input PIN_CLK_X1,
	input PIN_RESETN,
	
	output wire STOPPED, FETCH, DECODE, EXECUTE, COMMIT,
	
	output wire [15:0] PIN_ADDR_BUS,
	inout  wire [15:0] PIN_DATA_BUS,

	input PIN_INT0,
	input PIN_INT1,
	input PIN_INT2,
	input PIN_INT3,
	input PIN_INT4,
	input PIN_INT5,
	input PIN_INT6,
	
	output wire PIN_RDN, 
	output wire PIN_WR0N, 
	output wire PIN_WR1N,
	
	input PIN_RXD,
	output PIN_TXD,
	
	input [3:0] PIN_DIPSW,
	output wire [7:0] PIN_LED,
	
	/***********************************************
	* Allow wiring a custom ROM for each test set
	************************************************/
	output wire [15:0] ROM_ADDR,
	input wire [15:0] ROM_DOUT
	
);

PUR PUR_INST (.PUR(1'b1));
GSR GSR_INST (.GSR(1'b1));

wire [15:0] ADDR_BUF;
wire [15:0] DOUT_BUF;
wire [15:0] DIN_BUS;
wire [15:0] DIN_GPIO;
wire [15:0] CPU_DIN;
wire CLK;
wire RESET;
wire [7:0] DEBUG_DOUT;

assign DIN_GPIO[15:8] = 8'h00;

protoBoard boardInst(

	// Pins
	.BPIN_CLK_X1(PIN_CLK_X1),
	.BPIN_RESETN(PIN_RESETN),
	.BPIN_LED(PIN_LED),
	.BPIN_DIPSW(PIN_DIPSW),
	.BPIN_RDN(PIN_RDN),
	.BPIN_WR0N(PIN_WR0N),
	.BPIN_WR1N(PIN_WR1N),
	.BPIN_DBUS(PIN_DATA_BUS),
	.BPIN_ADDR(PIN_ADDR_BUS),
	.BPIN_RXD(PIN_RXD),
	.BPIN_TXD(PIN_TXD),
	.BPIN_INT0(PIN_INT0),
	.BPIN_INT1(PIN_INT1),
	.BPIN_INT2(PIN_INT2),
	.BPIN_INT3(PIN_INT3),
	.BPIN_INT4(PIN_INT4),
	.BPIN_INT5(PIN_INT5),
	.BPIN_INT6(PIN_INT6),
	.ROM_ADDR(ROM_ADDR),
	.ROM_DOUT(ROM_DOUT),
	
	// Internal signals
	.CLK(CLK),
	.RESET(RESET),
	.ADDR(ADDR_BUF),
	.DOUT(DOUT_BUF),
	.DIN(DIN_BUS),
	.INTS0(INTS0),
	.INTS1(INTS1),
	.INTS2(INTS2),
	.INTS3(INTS3),
	.INTS4(INTS4),
	.INTS5(INTS5),
	.INTS6(INTS6),
	
	.RDN(RDN_BUF),
	.WR0N(WRN0_BUF),
	.WR1N(WRN1_BUF),
	
	.UART_RXD(UART_RXD),
	.UART_TXD(UART_TXD),

	.RD_GPIO(RD_GPIO),
	.WR_GPIO(WR_GPIO),
	.ADDR_GPIO(ADDR_GPIO),
	.DIN_GPIO(DIN_GPIO[7:0])
);


core coreInst(
	
	.CLK(CLK),
	.RESET(RESET),
	
	.STOPPED(STOPPED), .FETCH(FETCH), .DECODE(DECODE), .EXECUTE(EXECUTE), .COMMIT(COMMIT),
	
	.ADDR_BUF(ADDR_BUF),
	.DOUT_BUF(DOUT_BUF),
	.DIN(CPU_DIN),
	.INT0(INT0),
	.INT1(INT1),
	
	.RDN_BUF(RDN_BUF), 
	.ABUS_OEN(ABUS_OEN),
	.WRN0_BUF(WRN0_BUF), 
	.WRN1_BUF(WRN1_BUF),
	
	.DEBUG_DIN(8'h00),
	.DEBUG_DOUT(DEBUG_DOUT),
	.DEBUG_ADDR(3'b000),
	.DEBUG_RD(1'b0),
	.DEBUG_WR(1'b0)
);

testResources mcuResourcesInst(

	.CLK(CLK),
	.RESET(RESET),
	.ADDR(ADDR_BUF),
	.CPU_DIN(CPU_DIN),
	.CPU_DOUT(DOUT_BUF),
	.RDN(RDN_BUF),
	.WR0N(WRN0_BUF),
	.WR1N(WRN1_BUF),
	.DIN_BUS(DIN_BUS),
	// GPIO
	.DIN_GPIO(DIN_GPIO),
	.RD_GPIO(RD_GPIO),
	.WR_GPIO(WR_GPIO),
	.ADDR_GPIO(ADDR_GPIO),

	.UART_RXD(UART_RXD),
	.UART_TXD(UART_TXD),
	
	.INTS0(INTS0),
	.INTS1(INTS1),
	.INTS2(INTS2),
	.INTS3(INTS3),
	.INTS4(INTS4),
	.INTS5(INTS5),
	.INTS6(INTS6),
	
	.INT0(INT0),
	.INT1(INT1),
	
	.ROM_ADDR(ROM_ADDR),
	.ROM_DOUT(ROM_DOUT)
	

);

endmodule