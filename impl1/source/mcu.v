/**
* CPU, RAM and ROM
* UART, GPIO and INT mask
**/
`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module mcu(
	
	input PIN_CLK_X1,
	input PIN_RESETN,
		
	output wire PIN_STOPPEDN,
	output wire PIN_FETCHN,
	output wire PIN_DECODEN,
	output wire PIN_EXECUTEN,
	output wire PIN_COMMITN,
	
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
	
	inout  [7:0]  PIN_DEBUG_DATA,
	input          PIN_DEBUG_WRN,
	input          PIN_DEBUG_RDN,
	input  [2:0]  PIN_DEBUG_ADDR,
	output wire    PIN_DEBUG_STOP,
	
	input [15:0]       PIN_DIN_GPIO,
	output wire         PIN_RDN_GPIO,
	output wire         PIN_WRN_GPIO,
	output wire         PIN_ADDR_GPIO
	
);

PUR PUR_INST (.PUR(1'b1));
GSR GSR_INST (.GSR(1'b1));

wire RESET;
wire CLK;

wire STOPPED;
wire FETCH;
wire DECODE;
wire EXECUTE;
wire COMMIT;

wire ABUS_OEN;
wire DBUS_OEN;

wire [15:0] ADDR;
wire [15:0] DIN;
wire [15:0] DOUT;
wire [15:0] CPU_DIN;

wire [7:0] DEBUG_DIN;
wire [7:0] DEBUG_DOUT;

wire INT0;
wire INT1;

wire RD_GPIO;
wire WR_GPIO;

assign PIN_DEBUG_DATA = PIN_DEBUG_RDN ? 8'hzz : DEBUG_DOUT;
assign DEBUG_DIN      = PIN_DEBUG_DATA;
assign RESET          = ~PIN_RESETN;
assign CLK            = PIN_CLK_X1;

assign PIN_ADDR_BUS = ABUS_OEN ? 16'hzzzz : ADDR;
assign PIN_DATA_BUS = DBUS_OEN ? 16'hzzzz : DOUT;
assign DIN          = PIN_DATA_BUS;

assign PIN_STOPPEDN = ~STOPPED;
assign PIN_FETCHN   = ~FETCH;
assign PIN_DECODEN  = ~DECODE;
assign PIN_EXECUTEN = ~EXECUTE;
assign PIN_COMMITN  = ~COMMIT;

assign PIN_RDN_GPIO = ~RD_GPIO;
assign PIN_WRN_GPIO = ~WR_GPIO;

core coreInst(
	
	.CLK(CLK),
	.RESET(RESET),
	
	.STOPPED(STOPPED), .FETCH(FETCH), .DECODE(DECODE), .EXECUTE(EXECUTE), .COMMIT(COMMIT),
	
	.ADDR_BUF(ADDR),
	.DOUT_BUF(DOUT),
	.DIN(CPU_DIN),
	.INT0(INT0),
	.INT1(INT1),
	
	.RDN_BUF(PIN_RDN), 
	.ABUS_OEN(ABUS_OEN),
	.WRN0_BUF(PIN_WRN0), 
	.WRN1_BUF(PIN_WRN1),
	.DEBUG_DIN(DEBUG_DIN),
	.DEBUG_DOUT(DEBUG_DOUT),
	.DEBUG_ADDR(PIN_DEBUG_ADDR),
	.DEBUG_WRN(PIN_DEBUG_WRN),
	.DEBUG_RDN(PIN_DEBUG_RDN)
);

mcuResources mcuResourcesInst(

	.CLK(CLK),
	.RESET(RESET),
	.ADDR(ADDR),
	.CPU_DIN(CPU_DIN),
	.CPU_DOUT(DOUT),
	.RDN(RDN),
	.WR0N(WRN0),
	.WR1N(WRN1),
	.DIN_BUS(DIN),
	// GPIO
	.DIN_GPIO(PIN_DIN_GPIO),
	.RD_GPIO(RD_GPIO),
	.WR_GPIO(WR_GPIO),
	.ADDR_GPIO(PIN_ADDR_GPIO),

	.UART_RXD(PIN_RXD),
	.UART_TXD(PIN_TXD),
	
	.INTS0(PIN_INT0),
	.INTS1(PIN_INT1),
	.INTS2(PIN_INT2),
	.INTS3(PIN_INT3),
	.INTS4(PIN_INT4),
	.INTS5(PIN_INT5),
	.INTS6(PIN_INT6),
	
	.INT0(INT0),
	.INT1(INT1)
	

);

endmodule
