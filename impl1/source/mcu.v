/**
* CPU, RAM and ROM
* UART, GPIO and INT mask
**/
`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module mcu(
	
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
	
	inout wire [7:0] DEBUG_DATA,
	output wire DEBUG_WRN,
	output wire DEBUG_RDN,
	output wire [2:0] DEBUG_ADDR
	
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

assign DIN_GPIO[15:8] = 8'h00;

wire [7:0] DEBUG_DIN;
wire [7:0] DEBUG_DOUT;

assign DEBUG_DATA = DEBUG_RDN ? 8'hzz : DEBUG_DOUT;
assign DEBUG_DIN = DEBUG_DATA;
assign UART_RXD = PIN_RXD;
assign PIN_TXD = UART_TXD;
assign RESET = ~PIN_RESETN;
assign CLK = PIN_CLK_X1;
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
	.DEBUG_DIN(DEBUG_DIN),
	.DEBUG_DOUT(DEBUG_DOUT),
	.DEBUG_ADDR(DEBUG_ADDR),
	.DEBUG_WRN(DEBUG_WRN),
	.DEBUG_RDN(DEBUG_RDN)
);

mcuResources mcuResourcesInst(

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
	.INT1(INT1)
	

);

endmodule
