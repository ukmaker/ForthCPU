`include "../../constants.v"
/*************************************************************
* The core of the CPU, not including the debug port. 
* Bus multiplexers are tied
**************************************************************/
module core(
	
	input CLK,
	input RESET,
	
	output STOPPED,
	output FETCH,
	output DECODE,
	output EXECUTE,
	output COMMIT,
	
	input [15:0] DIN_BUF,
	output [15:0] DOUT_BUF,
	output [15:0] ADDR_BUF,
	output RD_BUF,
	output WR0_BUF,
	output WR1_BUF

);

/**********************************************
* Internal wiring
***********************************************/
// Debugger - tied off for this impl
wire [2:0]  DEBUG_ADDR_BUSX;
wire [3:0]  DEBUG_ARGBX;
wire [2:0]  DEBUG_BUS_SEQX;
wire [1:0]  DEBUG_CC_REGX;
wire         DEBUG_MODE_STOP;
wire         DEBUG_MODE_DEBUG;
wire         DEBUG_MODE_INC;
wire [2:0]  DEBUG_PC_NEXTX;
wire [3:0]  DEBUG_REG_SEQX;
wire         DEBUG_LD_BKP_EN;


// Interrupt logic
wire [1:0]  INT_CC_REGX;
wire [2:0]  INT_PC_NEXTX;

// General
wire [13:0] INSTRUCTION;
wire [2:0]  GROUPX;
wire        PC_ENX;

wire [15:0] DIN;
wire [15:0] DOUT;
wire [15:0] ADDR;

// Register file <-> ALU
wire [15:0] ALU_R;
wire [15:0] HERE;

/****************************************
* Signals to/from the debugPort
*****************************************/
wire DEBUG_RD;
wire DEBUG_WR;
wire DEBUG_DATA_SELX;
wire [15:0] DEBUG_DIN;
wire [15:0] DEBUG_DOUT;
wire [15:0] DEBUG_ADDR;

// ALU decoder outputs
wire [3:0] ALU_REG_SEQX;
wire [1:0] ALU_REGA_ADDRX;
wire [2:0] ALU_REGB_ADDRX;
wire [3:0] ALU_ALU_OPX;
wire        ALU_CCL_LD;
wire [2:0] ALU_ALUA_SRCX;
wire [2:0] ALU_ALUB_SRCX;

// General decoder outputs
wire GEN_EIX;
wire GEN_DIX;
wire GEN_RETIX;
wire GEN_HALTX;	

// Jumps - decoder inputs
wire CC_ZERO;
wire CC_CARRY;
wire CC_SIGN;
wire CC_PARITY;	
// Jumps - decoder outputs
wire [1:0] JMP_PC_OFFSETX;
wire [1:0] JMP_PC_BASEX;
wire [1:0] JMP_REGA_ADDRX;
wire [2:0] JMP_REGB_ADDRX;
wire [1:0] JMP_REGA_DINX;
wire [3:0] JMP_REG_SEQX;
wire [2:0] JMP_ALUB_SRCX;
wire [2:0] JMP_ADDR_BUSX;
wire [2:0] JMP_BUS_SEQX;

// Load/store
wire [3:0] LDS_REG_SEQX;
wire [3:0] LDS_ALU_OPX;        // ALU operation
wire [2:0] LDS_ALUA_SRCX;
wire [2:0] LDS_ALUB_SRCX;
wire [1:0] LDS_REGA_DINX;
wire [1:0] LDS_REGA_ADDRX;
wire [2:0] LDS_REGB_ADDRX;
wire [1:0] LDS_PC_OFFSETX;
wire [1:0] LDS_DATA_BUSX;
wire [2:0] LDS_BUS_SEQX;
wire       LDS_RDX;
wire       LDS_BYTEX;
wire [2:0] LDS_ADDR_BUSX;


// Active OPX from the mux
wire [2:0]  ADDR_BUSX;
wire [3:0]  ALU_OPX;
wire [2:0]  ALUA_SRCX;
wire [2:0]  ALUB_SRCX;
wire [3:0]  ARGBX;
wire [2:0]  BUS_SEQX;
wire	     BYTEX;
wire         CCL_LD;
wire [1:0]  CC_REGX;
wire [1:0]  DATA_BUSX;
wire [1:0]  PC_BASEX;
wire [2:0]  PC_NEXTX;
wire [1:0]  PC_OFFSETX;
wire [3:0]  REG_SEQX;
wire [1:0]  REGA_ADDRX;
wire [1:0]  REGA_DINX;
wire [2:0]  REGB_ADDRX;

// Register sequencer
wire REGA_EN;
wire REGA_WEN;
wire REGB_EN;
wire REGB_WEN;
wire [15:0] REGA_DOUT;
wire [15:0] REGB_DOUT;

// ALU
wire [3:0] ARGAX;
wire B5;

wire CCL_ENRX;
wire CCL_EN0X;
wire CCL_EN1X;

wire [15:0] ALUA_DATA;
wire [15:0] ALUB_DATA;

// Program Counter
wire PC_LD_INT0X;
wire PC_LD_INT1X;
wire [15:0] PC_A_NEXT;
wire [15:0] PC_A;
wire DEBUG_EN_BKPX;
wire DEBUG_AT_BKP;


/****************************************
* Wire renaming
*****************************************/
assign ARGAX = INSTRUCTION[7:4];
assign ARGBX = INSTRUCTION[3:0];
assign B5    = INSTRUCTION[13];


/****************************************
* Debugger signals hardwiring
*****************************************/
assign DEBUG_REQ        = 1'b0;
assign DEBUG_MODE_STOP  = 1'b0;
assign DEBUG_MODE_DEBUG = 1'b0;
assign DEBUG_MODE_INC   = 1'b0;
assign DEBUG_LD_BKP_EN  = 1'b0;
assign DEBUG_EN_BKPX    = 1'b0;
assign DEBUG_DOUT       = 16'h0000;
assign DEBUG_ADDR       = 16'h0000;


/****************************************
* The modules
*****************************************/
masterSequencer masterSequencerInst(
	.CLK(CLK),
	.RESET(RESET),
	// input DEBUG_MODE_RESET;
	.DEBUG_REQ(DEBUG_REQ),
	.DEBUG_MODE_STOP(DEBUG_MODE_STOP),
	.DEBUG_MODE_INC(DEBUG_MODE_INC),
	.DEBUG_AT_BKP(DEBUG_AT_BKP),
	.DEBUG_IN_WATCH(DEBUG_IN_WATCH),
	.HALTX(HALTX),
	
	.STOPPED(STOPPED),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	
	.DEBUG_ACK(DEBUG_ACK),
	.DEBUG_MR_ADDR_INCX(DEBUG_MR_ADDR_INCX),
	.HALTED(HALTED),
	.PC_ENX(PC_ENX),
	
	.DEBUG_ACTIVE(DEBUG_ACTIVE)
);

instructionLatch instructionLatchInst(
	.CLK(CLK),
	.RESET(RESET),
	.EXECUTE(EXECUTE),
	.DIN(DIN),
	.DEBUG_MODE_DEBUG(DEBUG_MODE_DEBUG),
	.INSTRUCTION(INSTRUCTION),
	.GROUPX(GROUPX)
);
/**********************************************
* Instruction decoders
***********************************************/
aluGroupDecoder aluGroupDecoderInst(
	.CLK(CLK),
	.RESET(RESET),
	.ALU_INSTRUCTION(INSTRUCTION[13:8]),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.REG_SEQX(ALU_REG_SEQX),
	.REGA_ADDRX(ALU_REGA_ADDRX),
	.REGB_ADDRX(ALU_REGB_ADDRX),
	.ALU_OPX(ALU_ALU_OPX),
	.CCL_LD(ALU_CCL_LD),
	.ALUA_SRCX(ALU_ALUA_SRCX),
	.ALUB_SRCX(ALU_ALUB_SRCX)	
);

generalGroupDecoder generalGroupDecoderInst(
	
	.CLK(CLK),
	.RESET(RESET),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.INSTRUCTION_OP(INSTRUCTION[13:10]),
	.EIX(GEN_EIX),
	.DIX(GEN_DIX),
	.RETIX(GEN_RETIX),
	.HALTX(GEN_HALTX)
);

jumpGroupDecoder jumpGroupDecoderInst(

	.CLK(CLK),
	.RESET(RESET),
	
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),

	.GROUPF(INSTRUCTION[15:14]),
	.SKIPF(INSTRUCTION[13:12]),
	.CCF(INSTRUCTION[11:10]),
	.JPF(INSTRUCTION[9:8]),
	.JLF(INSTRUCTION[7]),
	
	.CC_ZERO(CC_ZERO),
	.CC_CARRY(CC_CARRY),
	.CC_SIGN(CC_SIGN),
	.CC_PARITY(CC_PARITY),
	
	.PC_OFFSETX(JMP_PC_OFFSETX),
	.PC_BASEX(JMP_PC_BASEX),
	
	.REGA_ADDRX(JMP_REGA_ADDRX),
	.REGB_ADDRX(JMP_REGB_ADDRX),
	.REGA_DINX(JMP_REGA_DINX),
	
	.ALUB_SRCX(JMP_ALUB_SRCX),
	.ADDR_BUSX(JMP_ADDR_BUSX),
	.REG_SEQX(JMP_REG_SEQX),
	.BUS_SEQX(JMP_BUS_SEQX)
);

loadStoreGroupDecoder loadStoreGroupDecoderInst(
	.CLK(CLK),
	.RESET(RESET),
	.OPF(INSTRUCTION[12:11]),
	.MODEF(INSTRUCTION[10:8]),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.REG_SEQX(LDS_REG_SEQX),
	.ALU_OPX(LDS_ALU_OPX),
	.ALUA_SRCX(LDS_ALUA_SRCX),
	.ALUB_SRCX(LDS_ALUB_SRCX),
	.REGA_DINX(LDS_REGA_DINX),
	.REGA_ADDRX(LDS_REGA_ADDRX),
	.REGB_ADDRX(LDS_REGB_ADDRX),
	.DATA_BUSX(LDS_DATA_BUSX),
	.BUS_SEQX(LDS_BUS_SEQX),
	.BYTEX(LDS_BYTEX),
	.ADDR_BUSX(LDS_ADDR_BUSX),
	.PC_OFFSETX(LDS_PC_OFFSETX)
);
/**********************************************
* OPX Mux
***********************************************/
opxMultiplexer opxMultiplexerInst(
	.INSTRUCTION_GROUP(GROUPX),
	.INSTRUCTION_ARGBX(INSTRUCTION[3:0]),
		
	.ALU_ALU_OPX(ALU_ALU_OPX),
	.ALU_ALUA_SRCX(ALU_ALUA_SRCX),
	.ALU_ALUB_SRCX(ALU_ALUB_SRCX),
	.ALU_CCL_LD(ALU_CCL_LD),
	.ALU_REGA_ADDRX(ALU_REGA_ADDRX),
	.ALU_REGB_ADDRX(ALU_REGB_ADDRX),
	.ALU_REG_SEQX(ALU_REG_SEQX),
	
	.DEBUG_ADDR_BUSX(DEBUG_ADDR_BUSX),
	.DEBUG_ARGBX(DEBUG_ARGBX),
	.DEBUG_BUS_SEQX(DEBUG_BUS_SEQX),
	.DEBUG_CC_REGX(DEBUG_CC_REGX),
	.DEBUG_MODEX(DEBUG_MODEX),
	.DEBUG_PC_NEXTX(DEBUG_PC_NEXTX),
	.DEBUG_REG_SEQX(DEBUG_REG_SEQX),
	
	.INT_CC_REGX(INT_CC_REGX),
	.INT_PC_NEXTX(INT_PC_NEXTX),

	.JMP_ADDR_BUSX(JMP_ADDR_BUSX),
	.JMP_ALUB_SRCX(JMP_ALUB_SRCX),
	.JMP_BUS_SEQX(JMP_BUS_SEQX),
	.JMP_PC_BASEX(JMP_PC_BASEX),
	.JMP_PC_OFFSETX(JMP_PC_OFFSETX),
	.JMP_REG_SEQX(JMP_REG_SEQX),
	.JMP_REGA_DINX(JMP_REGA_DINX),
	.JMP_REGA_ADDRX(JMP_REGA_ADDRX),
	.JMP_REGB_ADDRX(JMP_REGB_ADDRX),

	.LDS_ADDR_BUSX(LDS_ADDR_BUSX),
	.LDS_ALU_OPX(LDS_ALU_OPX),
	.LDS_ALUA_SRCX(LDS_ALUA_SRCX),
	.LDS_ALUB_SRCX(LDS_ALUB_SRCX),
	.LDS_BUS_SEQX(LDS_BUS_SEQX),
	.LDS_BYTEX(LDS_BYTEX),	
	.LDS_DATA_BUSX(LDS_DATA_BUSX),	
	.LDS_PC_OFFSETX(LDS_PC_OFFSETX),
	.LDS_REG_SEQX(LDS_REG_SEQX),
	.LDS_REGA_ADDRX(LDS_REGA_ADDRX),
	.LDS_REGA_DINX(LDS_REGA_DINX),
	.LDS_REGB_ADDRX(LDS_REGB_ADDRX),
	
	/*********************************************
	* Combined outputs
	**********************************************/
	.ADDR_BUSX(ADDR_BUSX),
	.ALU_OPX(ALU_OPX),
	.ALUA_SRCX(ALUA_SRCX),
	.ALUB_SRCX(ALUB_SRCX),
	.ARGBX(ARGBX),
	.BUS_SEQX(BUS_SEQX),
	.BYTEX(BYTEX),
	.CCL_LD(CCL_LD),
	.CC_REGX(CC_REGX),
	.DATA_BUSX(DATA_BUSX),
	.PC_BASEX(PC_BASEX),
	.PC_NEXTX(PC_NEXTX),
	.PC_OFFSETX(PC_OFFSETX),
	.REG_SEQX(REG_SEQX),
	.REGA_ADDRX(REGA_ADDRX),
	.REGA_DINX(REGA_DINX),
	.REGB_ADDRX(REGB_ADDRX)
);

/**********************************************
* Bus Interface
***********************************************/
busInterface busInterfaceInst(
	/****************************************
	* Control signals
	*****************************************/
    .CLK(CLK),
    .RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
    .COMMIT(COMMIT),
    .BUS_SEQX(BUS_SEQX),
	
	/****************************************
	* Signals to/from the CPU
	*****************************************/
    .CPU_DIN(DIN),
    .CPU_ADDR(ADDR),
    .CPU_DOUT(DOUT),
    .CPU_BYTEX(BYTEX),
	
	/****************************************
	* Signals to/from the pin buffers
	*****************************************/
    .RD_BUF(RD_BUF),
    .WR0_BUF(WR0_BUF),
    .WR1_BUF(WR1_BUF),
	
    .ADDR_BUF(ADDR_BUF),
    .DOUT_BUF(DOUT_BUF),
    .DIN_BUF(DIN_BUF),
	
	/****************************************
	* Signals to/from the debugPort
	*****************************************/
	.DEBUG_STOP(DEBUG_MODE_STOP),
	.DEBUG_DEBUG(DEBUG_MODE_DEBUG),
    .DEBUG_RD(DEBUG_RD),
    .DEBUG_WR(DEBUG_WR),
    .DEBUG_DATA_SELX(DEBUG_DATA_SELX),
    .DEBUG_DIN(DEBUG_DIN),
    .DEBUG_DOUT(DEBUG_DOUT),
    .DEBUG_ADDR(DEBUG_ADDR)
);

addressBusController addressBusControllerInst(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.DEBUG_MODE_DEBUG(DEBUG_MODE_DEBUG),
	.PC_A(PC_A),
	.ALU_R(ALU_R),
	.ALUB_DATA(ALUB_DATA),
	.ADDR_BUSX(ADDR_BUSX),
	.ADDR(ADDR),
	.DEBUG_ADDR(DEBUG_ADDR),
	.HERE(HERE),
	.BYTEX(BYTEX),
	.HIGH_BYTEX(HIGH_BYTEX)
);

dataBusController dataBusControllerInst(

	.DATA_BUSX(DATA_BUSX),
	.ALU_R(ALU_R),
	.REGA_DOUT(REGA_DOUT),
	.DEBUG_DOUT(DEBUG_DOUT),
	.CCREGS_DOUT({CC_PARITY,CC_SIGN,CC_CARRY,CC_ZERO}),
	.DOUT(DOUT)
);

/**********************************************
* Register sequencer
***********************************************/	
registerSequencer registerSequencerInst(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH), 
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.REG_SEQX(REG_SEQX),
	.REGA_EN(REGA_EN),
	.REGA_WEN(REGA_WEN),
	.REGB_EN(REGB_EN),
	.REGB_WEN(REGB_WEN)
);

/**********************************************
* Register file
***********************************************/
registerFile registerFileInst (
	.CLK(CLK),
	.RESET(RESET),
	.ALU_R(ALU_R),
	.HERE(HERE),
	.DIN(DIN),
	.REGA_EN(REGA_EN),
	.REGA_WEN(REGA_WEN),
	.ARGAX(INSTRUCTION[7:4]),
	.REGA_ADDRX(REGA_ADDRX),
	.REGB_EN(REGB_EN),
	.REGB_WEN(REGB_WEN),
	.ARGBX(ARGBX),
	
	.REGA_DINX(REGA_DINX),
	.REGA_BYTEX(HIGH_BYTEX),
	.REGB_ADDRX(REGB_ADDRX),
	.REGA_DOUT(REGA_DOUT),
	.REGB_DOUT(REGB_DOUT)
);
/**********************************************
* ALU
***********************************************/
fullALU fullALUInst(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.REGA_DOUT(REGA_DOUT),
	.REGB_DOUT(REGB_DOUT),
	.ALU_OPX(ALU_OPX),
	.ALUA_SRCX(ALUA_SRCX),
	.ALUB_SRCX(ALUB_SRCX),
	.ARGAX(ARGAX),
	.ARGBX(ARGBX),
	.B5(B5),
	.CCL_LD(CCL_LD),
	.CCL_ENRX(CCL_ENRX),
	.CCL_EN0X(CCL_EN0X),
	.CCL_EN1X(CCL_EN1X),
	.CC_REGX(CC_REGX),
	.ALU_R(ALU_R),
	.CC_ZERO(CC_ZERO),
	.CC_CARRY(CC_CARRY),
	.CC_SIGN(CC_SIGN),
	.CC_PARITY(CC_PARITY),
	.ALUA_DATA(ALUA_DATA),
	.ALUB_DATA(ALUB_DATA)
);
/**********************************************
* Program Counter
***********************************************/
programCounter programCounterInst(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.COMMIT(COMMIT),
	
	.PC_ENX(PC_ENX),
	.PC_LD_INT0X(PC_LD_INT0X),
	.PC_LD_INT1X(PC_LD_INT1X),
	.PC_BASEX(PC_BASEX),
	.PC_OFFSETX(PC_OFFSETX),
	
	.DEBUG_LD_BKP_EN(DEBUG_LD_BKP_EN),
	.DEBUG_EN_BKPX(DEBUG_EN_BKPX),
	.DIN_BKP(DEBUG_DOUT),
	.DEBUG_AT_BKP(DEBUG_AT_BKP),

	.REGB_DOUT(REGB_DOUT),
	.DIN(DIN),
	.PC_NEXTX(PC_NEXTX),
	
	.HERE(HERE),
	.PC_A_NEXT(PC_A_NEXT),
	.PC_A(PC_A)
);
/**********************************************
* Interrupt handler
***********************************************/
interruptStateMachine interruptStateMachineInst(
	.CLK(CLK),
	.RESET(RESET),
	.COMMIT(COMMIT),
	.RETIX(RETIX),
	.INT0(INT0),
	.INT1(INT1),
	.EIX(EIX),
	.DIX(DIX),
	.PC_NEXTX(PC_NEXTX),
	.PC_LD_INT0X(PC_LD_INT0X),
	.PC_LD_INT1X(PC_LD_INT1X),
	.CC_REGX(CC_REGX),
	.CCL_ENRX(CCL_ENRX),
	.CCL_EN0X(CCL_EN0X),
	.CCL_EN1X(CCL_EN1X)
);

endmodule
