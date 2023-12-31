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

reg [15:0] DEBUG_DIN_DISPLAY;
reg [15:0] DEBUG_REGA_DISPLAY;
reg [15:0] DEBUG_ADDR_DISPLAY;
reg [15:0] DEBUG_INSTR_DISPLAY;
reg [7:0]  DEBUG_CC_DISPLAY;

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

`define debugReadWord \
	$display("[T=%09t]   READ DL", $realtime); \
	`debugRead( `DEBUG_REG_ADDR_DL, 8'h00) \
	$display("[T=%09t]   READ DH", $realtime); \
	`debugRead( `DEBUG_REG_ADDR_DH, 8'h00)	\
	#800;
	
`define debugReadRegistersStart \
	$display("[T=%09t] READ REGS", $realtime); \
	`debugStop \
	`debugWrite( `DEBUG_REG_ADDR_OP, {`DEBUG_OPX_RD_REG, `DEBUG_ADDR_INCX_INC}) \
	`debugCycle

`define debugReadRegisters \
	`debugReadRegistersStart \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord \
    `debugReadWord 	
	
`define debugReadPC(expected) \
	$display("[T=%09t] READ PC", $realtime); \
	$display("[T=%09t]   SET MODE", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200;\
	$display("[T=%09t]   SET OP", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_OP; \
	DEBUG_SEND = {`DEBUG_OPX_RD_PC, `DEBUG_ADDR_INCX_NONE}; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200; \
	`debugCycle \
	$display("[T=%09t]   READ DL", $realtime); \
	`debugRead( `DEBUG_REG_ADDR_DL, 8'h00) \
	$display("[T=%09t]   READ DH", $realtime); \
	`debugRead( `DEBUG_REG_ADDR_DH, 8'h00)

`define debugReadInstruction(expected) \
	$display("[T=%09t] READ INSTRUCTION", $realtime); \
	$display("[T=%09t]   SET MODE", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200;\
	$display("[T=%09t]   SET OP", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_OP; \
	DEBUG_SEND = {`DEBUG_OPX_RD_INSTRUCTION, `DEBUG_ADDR_INCX_NONE}; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200; \
	`debugCycle \
	$display("[T=%09t]   READ DL", $realtime); \
	`debugRead( `DEBUG_REG_ADDR_DL, 8'h00) \
	$display("[T=%09t]   READ DH", $realtime); \
	`debugRead( `DEBUG_REG_ADDR_DH, 8'h00)

`define debugReadCC(expected) \
	$display("[T=%09t] READ CC", $realtime); \
	$display("[T=%09t]   SET MODE", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200;\
	$display("[T=%09t]   SET OP", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_OP; \
	DEBUG_SEND = {`DEBUG_OPX_RD_CC, `DEBUG_ADDR_INCX_NONE}; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200; \
	`debugCycle \
	$display("[T=%09t]   READ DL", $realtime); \
	`debugRead( `DEBUG_REG_ADDR_DL, 8'h00) 

`define debugStop \
	$display("[T=%09t] STOP", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#1000;

`define debugStep \
	$display("[T=%09t] STEP", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP | `DEBUG_MODEX_REQ; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#1000;
	
`define debugCycle \
	$display("[T=%09t] STEP", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_REG_ADDR_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP | `DEBUG_MODEX_REQ | `DEBUG_MODEX_DEBUG; \
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
	PIN_RXD = 0;
	PIN_INT0 = 0;
	PIN_INT1 = 0;
	PIN_INT2 = 0;
	PIN_INT3 = 0;
	PIN_INT4 = 0;
	PIN_INT5 = 0;
	PIN_INT6 = 0;
	
	`TICKTOCK;
	`TICKTOCK;
	PIN_RESETN = 1;
	`TICKTOCK;
	// Let it run for a few cycles
	#4000;
	// Write STOP to the debug port
	`debugWrite( `DEBUG_REG_ADDR_MODE, `DEBUG_MODEX_STOP | `DEBUG_MODEX_DEBUG)
	
	// Read the ROM
	`debugWrite( `DEBUG_REG_ADDR_AL, 8'h00)
	`debugWrite( `DEBUG_REG_ADDR_AH, 8'h00)
	`debugWrite( `DEBUG_REG_ADDR_OP, {`DEBUG_OPX_RD_MEM, `DEBUG_ADDR_INCX_INC} )
	// First read cycle
	`debugWrite( `DEBUG_REG_ADDR_MODE, `DEBUG_MODEX_STOP | `DEBUG_MODEX_DEBUG | `DEBUG_MODEX_REQ)
	`debugRead( `DEBUG_REG_ADDR_DL, 8'h00)
	`debugRead( `DEBUG_REG_ADDR_DH, 8'h00)
	`debugRead( `DEBUG_REG_ADDR_DL, 8'h00)
	`debugRead( `DEBUG_REG_ADDR_DH, 8'h00)
	`debugRead( `DEBUG_REG_ADDR_DL, 8'h00)
	`debugRead( `DEBUG_REG_ADDR_DH, 8'h00)
	// Write RESET to the debug port
	`debugWrite( `DEBUG_REG_ADDR_MODE, `DEBUG_MODEX_STOP | `DEBUG_MODEX_RESET)
	// Write STOP to the debug port
	`debugWrite( `DEBUG_REG_ADDR_MODE, `DEBUG_MODEX_STOP | `DEBUG_MODEX_DEBUG)
	// Repeat RAM read cycles
	`debugWrite( `DEBUG_REG_ADDR_MODE, `DEBUG_MODEX_STOP | `DEBUG_MODEX_DEBUG | `DEBUG_MODEX_REQ)
	`debugRead( `DEBUG_REG_ADDR_DL, 8'h00)
	`debugRead( `DEBUG_REG_ADDR_DH, 8'h00)
	`debugRead( `DEBUG_REG_ADDR_DL, 8'h00)
	`debugRead( `DEBUG_REG_ADDR_DH, 8'h00)
	`debugRead( `DEBUG_REG_ADDR_DL, 8'h00)
	`debugRead( `DEBUG_REG_ADDR_DH, 8'h00)

	PIN_RESETN = 0;
	DEBUG_SEND = 8'hzz;
	PIN_DEBUG_ADDR = 3'b000;
	PIN_DEBUG_RDN = 1'b1;
	PIN_DEBUG_WRN = 1'b1;
	`TICKTOCK;
	`TICKTOCK;
	PIN_RESETN = 1;
	`TICKTOCK;
	#200;
	`comment("Start stepping")
	`debugStop
	`debugStep
	`step(1, "readPC")
	`debugReadPC(0)
	`debugReadInstruction(0)
	
	`step(2, "readPC")
	`debugReadPC(0)
	`debugReadInstruction(0)
	`debugReadCC(0)
	`debugStep
	
	`step(3, "readPC")
	`debugReadRegisters
	`debugReadPC(0)
	`debugReadInstruction(0)
	`debugReadCC(0)
	`debugStep
	
	`step(4, "readPC")
	`debugReadPC(0)
	`debugReadInstruction(0)
	`debugReadCC(0)
	`debugStep
	
	`step(5, "readPC")
	`debugReadPC(0)
	`debugReadInstruction(0)
	`debugReadCC(0)
	`debugStep
	
	`step(6, "readPC")
	`debugReadPC(0)
	`debugReadInstruction(0)
	`debugReadCC(0)
	`debugStep
	
	`step(7, "readPC")
	`debugReadPC(0)
	`debugReadInstruction(0)
	`debugReadCC(0)
	`debugStep
	
	PIN_RESETN = 0;
	DEBUG_SEND = 8'hzz;
	PIN_DEBUG_ADDR = 3'b000;
	PIN_DEBUG_RDN = 1'b1;
	PIN_DEBUG_WRN = 1'b1;
	`TICKTOCK;
	`TICKTOCK;
	PIN_RESETN = 1;
	`TICKTOCK;

end

endmodule
	
	