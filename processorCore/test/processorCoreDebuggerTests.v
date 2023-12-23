`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"
`include "../../debuggerTestSetup.v"

module processorCoreDebuggerTests;
	
reg CLK;
reg RESETN;
wire RESET;
wire STOPPED;
wire FETCH;
wire DECODE;
wire EXECUTE;
wire COMMIT;

reg INT0;
reg INT1;

wire [15:0] ADDR_BUF;
wire [15:0] DOUT_BUF;
reg  [15:0] DIN;

wire RDN_BUF;
wire ABUS_OEN;
wire WRN0_BUF;
wire WRN1_BUF;

// Debugger interface
wire  [7:0]  DEBUG_DIN;
wire [7:0]  DEBUG_DOUT;
reg [2:0]   DEBUG_REG_ADDR;
wire          DEBUG_RDN;
wire          DEBUG_WRN;

PUR PUR_INST(.PUR(1'b1));
GSR GSR_INST(.GSR(1'b1));
	
	

core testInstance(
	
	.CLK(CLK),
	.RESETN(RESETN),
	.RESET(RESET),
	
	.STOPPED(STOPPED),
	.FETCH(FETCH), 
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.INT0(INT0),
	.INT1(INT1),
	
	.ADDR_BUF(ADDR_BUF),
	.DOUT_BUF(DOUT_BUF),
	.DIN(DIN),
	
	.RDN_BUF(RDN_BUF),
	.WRN0_BUF(WRN0_BUF),
	.WRN1_BUF(WRN1_BUF),
	
	.ABUS_OEN(ABUS_OEN),
	
	.DEBUG_DIN(DEBUG_DIN),
	.DEBUG_DOUT(DEBUG_DOUT),
	.DEBUG_REG_ADDR(DEBUG_REG_ADDR),
	.DEBUG_RDN(DEBUG_RDN),
	.DEBUG_WRN(DEBUG_WRN)
);

// test harness to use the debuggerTestSetup macros
reg PIN_DEBUG_WRN;
reg PIN_DEBUG_RDN;
wire [7:0]  PIN_DEBUG_DATA;
reg  [7:0]  DEBUG_SEND;
wire [7:0]  DEBUG_RECV;
reg [7:0] TEST_EXPECTED_BYTE;
	
assign PIN_DEBUG_DATA = DEBUG_SEND;
assign DEBUG_RECV = PIN_DEBUG_DATA;
assign DEBUG_WRN = PIN_DEBUG_WRN;
assign DEBUG_RDN = PIN_DEBUG_RDN;
assign DEBUG_DIN = PIN_DEBUG_DATA;

// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 0; 
	`TICK;
	RESETN = 0;
	DIN = 16'h0000;

	PIN_DEBUG_RDN = 1;
	PIN_DEBUG_WRN = 1;
	DEBUG_REG_ADDR = 0;
	INT0 = 0;
	INT1 = 0;
	`TICKTOCK;
	#5 RESETN = 1;
	`TICKTOCK;
	`TICKTOCK;
	`debugReset
	// set a breakpoint
	`debugWriteData(16'h0008)
	`debugWrite(`DEBUG_REG_ADDR_OP, `DEBUG_OPX_WR_BKP)
	`debugCycle
	// now restart the PC
	`debugWrite(`DEBUG_REG_ADDR_MODE, `DEBUG_MODEX_RUN | `DEBUG_MODEX_EN_BKP)
	// and supply NOPS until we get to the breakpoint
	DIN = 16'h0000;
	`STEP;
	`STEP;
	`STEP;
	`STEP;
	`STEP;
	`assert("ADDR", 16'h0008, ADDR_BUF)
	`STEP;
	`assert("ADDR", 16'h0008, ADDR_BUF)
	`STEP;
	// Now restart the PC from the breakpoint
	`debugCycle
	`debugWrite(`DEBUG_REG_ADDR_MODE, `DEBUG_MODEX_RUN | `DEBUG_MODEX_EN_BKP)
	`STEP;
	`assert("ADDR", 16'h000a, ADDR_BUF)
	`STEP;
	`STEP;
	`STEP;
	`STEP;
	`STEP;
	`STEP;
	`STEP;
	`STEP;
	`STEP;
	`STEP;
	`STEP;

	
	
end

endmodule