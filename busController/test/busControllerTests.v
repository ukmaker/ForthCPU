`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module busControllerTests;
	
	reg CLK, RESET;
	wire STOPPED,FETCH, DECODE, EXECUTE, COMMIT;
	
	reg [1:0] BUS_SEQX;
	
	/**
	* OPX
	**/
	reg [2:0]  ADDR_BUSX_MUX;
	reg [1:0]  PC_BASEX_MUX;
	reg [1:0]  PC_OFFSETX_MUX;
	
	/**
	* Address
	**/
	reg [15:0] PC_A;
	reg [15:0] ALU_R;
	reg [15:0] ALUB_DATA;
	reg [15:0] HERE;
	wire [15:0] ADDR_BUF;

	/**
	* Data
	**/
	reg [15:0]  REGA_DOUT;
	reg [1:0]   DATA_BUSX;
	reg          BYTEX;
	wire [15:0] DOUT_BUF;
	
	wire HIGH_BYTEX;
	wire DBUS_OEN;
	wire RDN_BUF;
	wire WRN0_BUF;
	wire WRN1_BUF;

	reg          HALTX;
	wire         PC_ENX;
	reg  [15:0] DIN;
	wire [15:0] INSTRUCTION;
	
	reg DEBUG_STOPX;
	reg DEBUG_STEP_REQ;
	wire DEBUG_STEP_ACK;
	wire DEBUG_ACTIVE;
	
instructionPhaseDecoder decoder(
	.CLK(CLK),
	.DEBUG_STOPX(DEBUG_STOPX),
	.DEBUG_STEP_REQ(DEBUG_STEP_REQ),
	.DIN(DIN),
	.HALTX(HALTX),
	.RESET(RESET),
	
	.COMMIT(COMMIT),
	.DECODE(DECODE),
	.DEBUG_STEP_ACK(DEBUG_STEP_ACK),
	.DEBUG_ACTIVE(DEBUG_ACTIVE),
	.EXECUTE(EXECUTE),
	.FETCH(FETCH),
	.INSTRUCTION(INSTRUCTION),
	.PC_ENX(PC_ENX),
	.STOPPED(STOPPED)
);

busController testInstance(
	.CLK(CLK),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.DEBUG_ACTIVE(DEBUG_ACTIVE),
	.BUS_SEQX(BUS_SEQX),
	.ADDR_BUSX_MUX(ADDR_BUSX_MUX),
	.PC_BASEX_MUX(PC_BASEX_MUX),
	.PC_OFFSETX_MUX(PC_OFFSETX_MUX),
	
	.PC_A(PC_A),
	.ALU_R(ALU_R),
	.ALUB_DATA(ALUB_DATA),
	.HERE(HERE),
	.ADDR_BUF(ADDR_BUF),
	
	.REGA_DOUT(REGA_DOUT),
	.DATA_BUSX(DATA_BUSX),
	.BYTEX(BYTEX),
	.DOUT_BUF(DOUT_BUF),
	
	.HIGH_BYTEX(HIGH_BYTEX),
	.RDN_BUF(RDN_BUF),
	.WRN0_BUF(WRN0_BUF),
	.WRN1_BUF(WRN1_BUF)
);

// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 0; 
	`TICK;
	RESET = 1;
	PC_A = 16'haaaa;
	ALU_R = 16'hbbbb;
	REGA_DOUT = 16'hcccc;
	ALUB_DATA = 16'hdddd;
	ADDR_BUSX_MUX = `ADDR_BUSX_PC_A;
	DATA_BUSX = `DATA_BUSX_REGA_DOUT;
	BYTEX = 0;
	BUS_SEQX = 2'b00;
	HALTX = 1;
	DIN = 16'h0000;
	DEBUG_STOPX = 0;

	`TICKTOCK;
	`TICKTOCK;	 
	RESET = 0; 
	HALTX = 0;	
	`TICKTOCK; // 
	`TICKTOCK; //	
	`TICKTOCK; //
	`TICKTOCK; //	
	`TICKTOCK; //
	
	/******************************************************************
	* Word read cycles
	******************************************************************/
	`TICKTOCK; // FETCH
	BUS_SEQX = `BUS_SEQX_FETCH;
	`TICKTOCK; // DECODE
	BUS_SEQX = `BUS_SEQX_NONE;
	`TICKTOCK; // EXECUTE - Control signals become valid here
	`mark(1)
	`assert("ADDR_BUF", 16'haaaa, ADDR_BUF)
	`assert("DOUT_BUF", 16'hcccc, DOUT_BUF)
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`assert("HIGH_BYTEX", 0, HIGH_BYTEX)
	`TICKTOCK; // COMMIT

	`TICKTOCK; // FETCH
	`TICKTOCK; // DECODE
	`TICKTOCK; // EXECUTE - Control signals become valid here

	ADDR_BUSX_MUX = `ADDR_BUSX_ALU_R;
	#10
	`mark(2)
	`assert("ADDR_BUF", 16'hbbbb, ADDR_BUF)
	`assert("DOUT_BUF", 16'hcccc, DOUT_BUF)
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`assert("HIGH_BYTEX", 0, HIGH_BYTEX)
	`TICKTOCK; // COMMIT
	
	`TICKTOCK; // FETCH
	BUS_SEQX = `BUS_SEQX_FETCH;
	`TICKTOCK; // DECODE
	BUS_SEQX = `BUS_SEQX_NONE;
	`TICKTOCK; // EXECUTE - Control signals become valid here

	ADDR_BUSX_MUX = `ADDR_BUSX_ALUB_DATA;
	#10
	`mark(3)
	`assert("ADDR_BUF", 16'hdddd, ADDR_BUF)
	`assert("DOUT_BUF", 16'hcccc, DOUT_BUF)
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`assert("HIGH_BYTEX", 0, HIGH_BYTEX)
	`TICKTOCK; // COMMIT
		
	/******************************************************************
	* Byte addressing
	******************************************************************/
	`TICKTOCK; // FETCH
	BUS_SEQX = `BUS_SEQX_FETCH;
	`TICKTOCK; // DECODE
	BUS_SEQX = `BUS_SEQX_NONE;
	`TICKTOCK; // EXECUTE - Control signals become valid here

	ADDR_BUSX_MUX = `ADDR_BUSX_PC_A;
	BYTEX = 1;
	#10
	`mark(4)
	`assert("ADDR_BUF", 16'haaaa, ADDR_BUF)
	`assert("DOUT_BUF", 16'hcccc, DOUT_BUF)
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`assert("HIGH_BYTEX", 0, HIGH_BYTEX)
	`TICKTOCK; // COMMIT

	`TICKTOCK; // FETCH
	BUS_SEQX = `BUS_SEQX_FETCH;
	`TICKTOCK; // DECODE
	BUS_SEQX = `BUS_SEQX_NONE;
	`TICKTOCK; // EXECUTE - Control signals become valid here

	ADDR_BUSX_MUX = `ADDR_BUSX_ALU_R;
	#10
	`mark(5)
	`assert("ADDR_BUF", 16'hbbbb, ADDR_BUF)
	`assert("DOUT_BUF", 16'hcc00, DOUT_BUF)
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`assert("HIGH_BYTEX", 1, HIGH_BYTEX)
	`TICKTOCK; // COMMIT

		
	/******************************************************************
	* Byte addressing, writes
	******************************************************************/
	`TICKTOCK; // FETCH
	BUS_SEQX = `BUS_SEQX_FETCH;
	`TICKTOCK; // DECODE
	BUS_SEQX = `BUS_SEQX_NONE;
	`TICKTOCK; // EXECUTE - Control signals become valid here

	ADDR_BUSX_MUX = `ADDR_BUSX_PC_A;
	BYTEX = 1;
	BUS_SEQX = `BUS_SEQX_WRITE;
	#10
	`mark(6)
	`assert("ADDR_BUF", 16'haaaa, ADDR_BUF)
	`assert("DOUT_BUF", 16'hcccc, DOUT_BUF)
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`assert("HIGH_BYTEX", 0, HIGH_BYTEX)
	`TICKTOCK; // COMMIT

	`assert("WRN0_BUF", 0, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)

	`TICKTOCK; // FETCH
	BUS_SEQX = `BUS_SEQX_FETCH;
	`TICKTOCK; // DECODE
	BUS_SEQX = `BUS_SEQX_NONE;
	`TICKTOCK; // EXECUTE - Control signals become valid here

	ADDR_BUSX_MUX = `ADDR_BUSX_ALU_R;
	BUS_SEQX = `BUS_SEQX_WRITE;
	#10
	`mark(7)
	`assert("ADDR_BUF", 16'hbbbb, ADDR_BUF)
	`assert("DOUT_BUF", 16'hcc00, DOUT_BUF)
	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 1, WRN1_BUF)
	`assert("HIGH_BYTEX", 1, HIGH_BYTEX)
	`TICKTOCK; // COMMIT

	`assert("WRN0_BUF", 1, WRN0_BUF)
	`assert("WRN1_BUF", 0, WRN1_BUF)

 end
 
 endmodule
