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

reg [7:0] TEST_EXPECTED_BYTE;

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

`define debugReadReg(what, reg, expected) \
	$display("[T=%09t] READ %s", $realtime, what); \
	PIN_DEBUG_ADDR = reg; \
	DEBUG_SEND = 8'hzz; \
	#100; \
	PIN_DEBUG_RDN = 1'b0; \
	#100; \
	`assert(what, expected, PIN_DEBUG_DATA) \
	PIN_DEBUG_RDN = 1'b1; \
	#100;
	
`define debugReadWord(expected) \
	TEST_EXPECTED_BYTE = 8'hff & expected; \
	`debugReadReg("MEM Low Byte", `DEBUG_ADDRX_DL,  TEST_EXPECTED_BYTE) \
	TEST_EXPECTED_BYTE = 8'hff & (expected >> 8); \
	`debugReadReg("MEM High Byte", `DEBUG_ADDRX_DH, TEST_EXPECTED_BYTE) \
	#600;

`define debugReadPC(expected) \
	$display("[T=%09t] READ PC", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_ADDRX_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200;\
	PIN_DEBUG_ADDR = `DEBUG_ADDRX_OP; \
	DEBUG_SEND = {`DEBUG_OPX_RD_PC, `DEBUG_ADDR_INCX_NONE}; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200; \
	`debugCycle \
	`debugReadWord(expected)

`define debugReadInstruction(expected) \
	$display("[T=%09t] READ INSTRUCTION", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_ADDRX_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200;\
	PIN_DEBUG_ADDR = `DEBUG_ADDRX_OP; \
	DEBUG_SEND = {`DEBUG_OPX_RD_INSTRUCTION, `DEBUG_ADDR_INCX_NONE}; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200; \
	`debugCycle \
	`debugReadWord(expected)

`define debugReadCC(expected) \
	$display("[T=%09t] READ CC", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_ADDRX_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200;\
	PIN_DEBUG_ADDR = `DEBUG_ADDRX_OP; \
	DEBUG_SEND = {`DEBUG_OPX_RD_CC, `DEBUG_ADDR_INCX_NONE}; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#200; \
	`debugCycle \
	`debugReadReg("CC", `DEBUG_ADDRX_DL, expected) 

`define debugStop \
	$display("[T=%09t] STOP", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_ADDRX_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#1000;

`define debugReset \
	$display("[T=%09t] RESET", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_ADDRX_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP | `DEBUG_MODEX_RESET; \
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
	
`define debugCycle \
	$display("[T=%09t] CYCLE", $realtime); \
	PIN_DEBUG_ADDR = `DEBUG_ADDRX_MODE; \
	DEBUG_SEND = `DEBUG_MODEX_STOP | `DEBUG_MODEX_REQ | `DEBUG_MODEX_DEBUG; \
	#100; \
	PIN_DEBUG_WRN = 1'b0; \
	#100; \
	PIN_DEBUG_WRN = 1'b1; \
	#1000;
	
`define debugStepCheck(addr, asm, instr) \
	`step(addr, asm) \
	`debugStep \
	`debugReadPC(addr) \
	`debugReadInstruction(instr)
	
`define debugStepCheckST(addr, asm, instr) \
	`step(addr, asm) \
	`debugStep \
	`debugReadPC(addr) \
	`debugReadInstruction(instr)

`define debugStepCheckCC(addr, asm, instr, cc) \
	`step(addr, asm) \
	`debugStep \
	`debugReadPC(addr) \
	`debugReadInstruction(instr) \
	`debugReadCC(cc)

	
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
	// Let it run for a few cycles
	#4000;
	// Write RESET to the debug port
	`debugWrite( `DEBUG_ADDRX_MODE, `DEBUG_MODEX_STOP | `DEBUG_MODEX_RESET | `DEBUG_MODEX_DEBUG)
	// Setup to read the ROM
	`debugWrite( `DEBUG_ADDRX_AL, 8'h00)
	`debugWrite( `DEBUG_ADDRX_AH, 8'h00)
	`debugWrite( `DEBUG_ADDRX_OP, {`DEBUG_OPX_RD_MEM, `DEBUG_ADDR_INCX_INC})
	`debugCycle
	
	/**	
	; Test loading immediates
	MOVI R0,5
	MOVI R1,3
	ST R0,R1
	LDI R2,0x1234
	LDI R3,0x3456
	MOV R3,R4
	ST R2,R1
	ST R3,R2
	AND R1,R1
	SUB R1,R0
	ST R1,R3
	JPI 0x0000
	
	0000: c105
	0002: c113
	0004: 5001
	0006: 4120
	0008: 1234
	000a: 4130
	000c: 3456
	000e: c034
	0010: 5021
	0012: 5032
	0014: d411
	0016: c810
	0018: 5013
	001a: 8200
	001c: 0000
	**/
	// Repeat RAM read cycles
	// LDI R0,0x1234
	`debugReadWord(16'hc105) 
	`debugReadWord(16'hc113)
	`debugReadWord(16'h5001) 
	`debugReadWord(16'h4120)
	`debugReadWord(16'h1234)
	`debugReadWord(16'h4130)
	`debugReadWord(16'h3456)
	`debugReadWord(16'hc034)
	`debugReadWord(16'h5021)
	`debugReadWord(16'h5032)
	`debugReadWord(16'hd411)
	`debugReadWord(16'hc810)
	`debugReadWord(16'h5013)
	`debugReadWord(16'h8200)
	`debugReadWord(16'h0000)

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
	`debugReset

	/******************************
	* Verilog test vectors 
	*******************************/
	`debugStepCheck(16'h0000,"MOVI R0,5",16'hc105)
	`debugStepCheck(16'h0002,"MOVI R1,3",16'hc113)
	`debugStepCheck(16'h0004,"ST R0,R1",16'h5001)
	`debugStepCheck(16'h0006,"LDI R2,1234",16'h4120)
	`debugStepCheck(16'h000a,"LDI R3,3456",16'h4130)
	`debugStepCheck(16'h000e,"MOV R3,R4",16'hc034)
	`debugStepCheck(16'h0010,"ST R2,R1",16'h5021)
	`debugStepCheck(16'h0012,"ST R3,R2",16'h5032)
	`debugStepCheck(16'h0014,"AND R1,R1",16'hd411)
	`debugStepCheck(16'h0016,"SUB R1,R0",16'hc810)
	`debugStepCheck(16'h0018,"ST R1,R3",16'h5013)
	`debugStepCheck(16'h001a,"JPI 0000",16'h8200)
	
end

endmodule
	
	