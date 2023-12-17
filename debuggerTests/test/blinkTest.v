`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"
`include "../../debuggerTestSetup.v"

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
	// 16 LDI instructions * 4 clock cycles
	#6400;
	`debugReset
	/******************************
	* Verilog test vectors 
	*******************************/
	`debugReadRegistersStart
	`debugExpectWord(16'h0011)
	`debugExpectWord(16'h1111)
	`debugExpectWord(16'h2222)
	`debugExpectWord(16'h3333)
	`debugExpectWord(16'h4444)
	`debugExpectWord(16'h5555)
	`debugExpectWord(16'h6666)
	`debugExpectWord(16'h7777)
	`debugExpectWord(16'h8888)
	`debugExpectWord(16'h9999)
	`debugExpectWord(16'haaaa)
	`debugExpectWord(16'hbbbb)
	`debugExpectWord(16'hcccc)
	`debugExpectWord(16'hdddd)
	`debugExpectWord(16'heeee)
	`debugExpectWord(16'hffff)
	
	

	/******************************
	* Verilog test vectors 
	*******************************
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
	**/
end

endmodule
	
	