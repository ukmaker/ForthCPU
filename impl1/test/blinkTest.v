`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module blinkTests;
	
	reg PIN_CLK_X1;
	reg PIN_RESETN;
	
	wire PIN_STOPPEDN, PIN_FETCHN, PIN_DECODEN, PIN_EXECUTEN, PIN_COMMITN;
	
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
	
	wire [7:0]  PIN_DEBUG_DATA;
	reg  [7:0]  DEBUG_SEND;
	wire [7:0]  DEBUG_RECV;
	
	reg PIN_DEBUG_WRN;
	reg PIN_DEBUG_RDN;
	reg [2:0] PIN_DEBUG_ADDR;
	wire PIN_DEBUG_STOP;
	
	reg [15:0] PIN_DIN_GPIO;
	wire PIN_RDN_GPIO;
	wire PIN_WRN_GPIO;
	wire PIN_ADDR_GPIO;
	
mcu mcuInst(
	.PIN_CLK_X1(PIN_CLK_X1),
	.PIN_RESETN(PIN_RESETN),
	.PIN_STOPPEDN(PIN_STOPPEDN), 
	.PIN_FETCHN(PIN_FETCHN), 
	.PIN_DECODEN(PIN_DECODEN), 
	.PIN_EXECUTEN(PIN_EXECUTEN), 
	.PIN_COMMITN(PIN_COMMITN),
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
	.PIN_DEBUG_DATA(PIN_DEBUG_DATA),
	.PIN_DEBUG_ADDR(PIN_DEBUG_ADDR),
	.PIN_DEBUG_WRN(PIN_DEBUG_WRN),
	.PIN_DEBUG_RDN(PIN_DEBUG_RDN),
	.PIN_DEBUG_STOP(PIN_DEBUG_STOP),
	.PIN_DIN_GPIO(PIN_DIN_GPIO),
	.PIN_RDN_GPIO(PIN_RDN_GPIO),
	.PIN_WRN_GPIO(PIN_WRN_GPIO),
	.PIN_ADDR_GPIO(PIN_ADDR_GPIO)
);

`define debugWrite(reg, value) \
	$display("[T=%09t] WRITE", $realtime); \
	PIN_DEBUG_ADDR = reg; \
	DEBUG_SEND = value; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#100; \
	DEBUG_SEND = 8'hzz; \
	#1000;  

`define debugRead(reg, expected) \
	$display("[T=%09t] READ", $realtime); \
	PIN_DEBUG_ADDR = reg; \
	DEBUG_SEND = 8'hzz; \
	#100; \
	PIN_DEBUG_RDN = 1'b0; \
	#100; \
	PIN_DEBUG_RDN = 1'b1; \
	#100;

`define debugReadPC(expected) \
	$display("[T=%09t] READ PC", $realtime); \
	$display("[T=%09t]   SET MODE", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_ADDRX_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#1000;\
	$display("[T=%09t]   SET OP", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_ADDRX_OP; \
	DEBUG_SEND = {`DEBUG_OPX_RD_PC, `DEBUG_ADDR_INCX_NONE}; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#1000; \
	`debugStep \
	`debugRead( `DEBUG_ADDRX_DL, 8'h00) \
	`debugRead( `DEBUG_ADDRX_DH, 8'h00)

`define debugStop \
	$display("[T=%09t] STOP", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_ADDRX_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#1000;

`define debugStep \
	$display("[T=%09t] STEP", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_ADDRX_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP | `DEBUG_MODEX_REQ; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#1000;
	
	
assign PIN_DEBUG_DATA = DEBUG_SEND;
assign DEBUG_RECV = PIN_DEBUG_DATA;

always begin
	#50 PIN_CLK_X1 = ~PIN_CLK_X1;
end

initial begin
	PIN_CLK_X1 = 0;
	PIN_RESETN = 0;
	DEBUG_SEND = 8'hzz;
	PIN_DEBUG_ADDR = 3'b000;
	PIN_DEBUG_RDN = 1'b1;
	PIN_DEBUG_WRN = 1'b1;
	`TICKTOCK;
	`TICKTOCK;
	PIN_RESETN = 1;
	`TICKTOCK;
	#2000;
	// Write STOP to the debug port
	`debugWrite( `DEBUG_ADDRX_MODE, `DEBUG_MODEX_STOP | `DEBUG_MODEX_DEBUG)
	
	DEBUG_SEND = 8'h01;
	#100;
	PIN_DEBUG_WRN = 1'b0;
	#100;
	PIN_DEBUG_WRN = 1'b1;
	#100;
	DEBUG_SEND = 8'hzz;
	#1000;
	// Read the ROM
	`debugWrite( `DEBUG_ADDRX_AL, 8'h00)
	`debugWrite( `DEBUG_ADDRX_AH, 8'h00)
	`debugWrite( `DEBUG_ADDRX_OP, {`DEBUG_OPX_RD_MEM, `DEBUG_ADDR_INCX_INC} )
	// First read cycle
	`debugWrite( `DEBUG_ADDRX_MODE, `DEBUG_MODEX_STOP | `DEBUG_MODEX_DEBUG | `DEBUG_MODEX_REQ)
	`debugRead( `DEBUG_ADDRX_DL, 8'h00)
	`debugRead( `DEBUG_ADDRX_DH, 8'h00)
	`debugRead( `DEBUG_ADDRX_DL, 8'h00)
	`debugRead( `DEBUG_ADDRX_DH, 8'h00)
	`debugRead( `DEBUG_ADDRX_DL, 8'h00)
	`debugRead( `DEBUG_ADDRX_DH, 8'h00)
	PIN_RESETN = 0;
	DEBUG_SEND = 8'hzz;
	PIN_DEBUG_ADDR = 3'b000;
	PIN_DEBUG_RDN = 1'b1;
	PIN_DEBUG_WRN = 1'b1;
	`TICKTOCK;
	`TICKTOCK;
	PIN_RESETN = 1;
	`TICKTOCK;
	#2000;
	`debugStop
	`debugStep
	`debugReadPC(0)
	`debugStep
	`debugReadPC(0)
	`debugStep
	`debugReadPC(0)
	`debugStep
	`debugReadPC(0)
	`debugStep
	`debugReadPC(0)	
end

endmodule
	
	