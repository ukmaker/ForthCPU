/**
* All the CPU functional units together, but without the pin bindings
**/
`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module core(
	
	input CLK,
	input RESETN,
	output RESET,
	
	output wire STOPPED, FETCH, DECODE, EXECUTE, COMMIT,
	
	output [15:0] ADDR_BUF,
	output [15:0] DOUT_BUF,
	input  [15:0] DIN,
	input INT0,
	input INT1,
	
	output RDN_BUF, 
	output ABUS_OEN,
	output WRN0_BUF, 
	output WRN1_BUF,
	
	// Debugger interface
	input  [7:0]  DEBUG_DIN,
	output [7:0]  DEBUG_DOUT,
	input [2:0]   DEBUG_REG_ADDR,
	input          DEBUG_RDN,
	input          DEBUG_WRN
);

/***************************************
* Wiring
****************************************/
wire [2:0]  ADDR_BUSX;
wire [3:0]  ALU_OPX;
wire [15:0] ALU_R;
wire [15:0] ALUA_DATA;
wire [2:0]  ALUA_SRCX;
wire [15:0] ALUB_DATA;
wire [2:0]  ALUB_SRCX;
wire [3:0]  ARGA_X;
wire [3:0]  ARGB_X;
wire [1:0]  BUS_SEQX;
wire         CCL_LD;
wire         CCL_ENRX;
wire         CCL_EN0X;
wire         CCL_EN1X;
wire [1:0]  CC_REGX;
wire         CC_ZERO;
wire         CC_CARRY;
wire         CC_PARITY;
wire         CC_SIGN;
wire [1:0]  DATA_BUSX;

wire [15:0] DEBUG_ADDR_OUT;
wire [15:0] DEBUG_DATA_OUT;
wire [2:0]  DEBUG_ARG;
wire [3:0]  DEBUG_ARGBX;
wire [2:0]  DEBUG_OP;
wire [2:0]  DEBUG_OP_I;
wire         DEBUG_ADDR_INC_I;
wire [4:0]  DEBUG_OPX;
wire         DEBUG_MODEX;
wire         DEBUG_STOPX;
wire         DEBUG_REQ;
wire         DEBUG_ACK;

wire [15:0] DIN_LATCHED;
wire         DIX;
wire         EIX;
wire         HALTX;
wire [1:0]  GROUPX;
wire [15:0] HERE;
wire [13:0] INSTRUCTION;
wire [15:0] PC_A;
wire [15:0] PC_A_NEXT;
wire [1:0]  PC_BASEX;
wire         PC_LD_INT0X;
wire         PC_LD_INT1X;
wire [2:0]  PC_NEXTX;
wire [1:0]  PC_OFFSETX;
wire         PC_ENX;
wire [3:0]  REG_SEQX;
wire [1:0]  REGA_ADDRX;
wire [1:0]  REGA_DINX;
wire [15:0] REGA_DOUT;
wire         REGA_EN;
wire         REGA_WEN;
wire [2:0]  REGB_ADDRX;
wire [15:0] REGB_DOUT;
wire         REGB_EN;
wire         REGB_WEN;
wire         RETIX;

/***************************************
* Wiring from decoders
****************************************/
wire [3:0]  ALU_ALU_OPX;
wire [2:0]  ALU_ALUA_SRCX;
wire [2:0]  ALU_ALUB_SRCX;
wire [3:0]  ALU_ARGB_X;
wire         ALU_CCL_LD;
wire [3:0]  ALU_REG_SEQX;
wire [1:0]  ALU_REGA_ADDRX;
wire [2:0]  ALU_REGB_ADDRX;

// Outputs
wire [1:0]  DEBUG_BUS_SEQX;
wire [1:0]  DEBUG_CC_REGX;
wire [2:0]  DEBUG_PC_NEXTX;
wire [3:0]  DEBUG_REG_SEQX;
wire [2:0]  DEBUG_ADDR_BUSX;
wire         DEBUG_ADDR_INCX;
wire         DEBUG_LD_ARGX;
wire         DEBUG_LD_DATAX;
wire [2:0]  DEBUG_DATAX;


wire [1:0]  INT_CC_REGX;
wire [2:0]  INT_PC_NEXTX;

wire [2:0]  LDS_ADDR_BUSX;
wire [2:0]  LDS_ALUA_SRCX;
wire [2:0]  LDS_ALUB_SRCX;
wire [3:0]  LDS_ALU_OPX;
wire [1:0]  LDS_BUS_SEQX;
wire         LDS_BYTEX;
wire [1:0]  LDS_DATA_BUSX;
wire [1:0]  LDS_PC_OFFSETX;
wire         LDS_RDX;
wire [3:0]  LDS_REG_SEQX;
wire [1:0]  LDS_REGA_ADDRX;
wire [1:0]  LDS_REGA_DINX;
wire [2:0]  LDS_REGB_ADDRX;
wire         LDS_WRX;

wire [2:0]  JMP_ADDR_BUSX;
wire [1:0]  JMP_BUS_SEQX;
wire [1:0]  JMP_PC_BASEX;
wire [1:0]  JMP_PC_OFFSETX;
wire         JMP_RDX;
wire [1:0]  JMP_REGA_DINX;
wire [1:0]  JMP_REGA_ADDRX;
wire [2:0]  JMP_REGB_ADDRX;
wire [3:0]  JMP_REG_SEQX;
wire [2:0]  JMP_ALUB_SRCX;

/******************************************
* Data routing to the debugger
*******************************************/
wire [15:0] DEBUG_DIN_DIN   = DIN_LATCHED;
wire [15:0] DEBUG_REGB_DATA = REGB_DOUT;
wire [15:0] DEBUG_CC_DATA   = {12'h000,CC_SIGN,CC_CARRY,CC_ZERO,CC_PARITY};
wire [15:0] DEBUG_PC_A      = PC_A;
wire [15:0] DEBUG_PC_A_NEXT = PC_A_NEXT;

/**
* No ABUS tristate control yet
**/
assign ABUS_OEN = 0;
assign ARGA_X = INSTRUCTION[7:4];

assign DEBUG_ARG   = DEBUG_ADDR_OUT[2:0];
assign DEBUG_ARGBX = DEBUG_ADDR_OUT[3:0];

/***************************************
* Latch for input data
****************************************/
register #(.BUS_WIDTH(16)) dinLatch(
	.CLK(CLK),
	.RESET(RESET),
	.LD(~RDN_BUF),
	.EN(DECODE | COMMIT),
	.DIN(DIN),
	.DOUT(DIN_LATCHED)
);

/***************************************
* Debugging external interface
****************************************/
debugPort debugger(
	.CLK(CLK),
	.RESET(RESET),
	.RESETN(RESETN),
	.DEBUG_DIN(DEBUG_DIN),
	.DEBUG_DOUT(DEBUG_DOUT),
	.DEBUG_REG_ADDR(DEBUG_REG_ADDR),
	.DEBUG_RDN(DEBUG_RDN),
	.DEBUG_WRN(DEBUG_WRN),
	
	.DEBUG_ADDR_INC(DEBUG_ADDR_INC),
	.DEBUG_OP(DEBUG_OP),
	.DEBUG_MODE(DEBUG_MODE),	
	.DEBUG_ADDR_OUT(DEBUG_ADDR_OUT),
	
	.DEBUG_DATA_OUT(DEBUG_DATA_OUT),
	.DEBUG_ADDR_INC_EN(DEBUG_ADDR_INC_EN),
	
	.DEBUG_LD_ARG_EN(DEBUG_LD_ARG_EN),
	.DEBUG_LD_DATA_EN(DEBUG_LD_DATA_EN),
	.DEBUG_DATAX(DEBUG_DATAX),

	.DEBUG_DIN_DIN(DEBUG_DIN_DIN),
	.DEBUG_REGB_DATA(DEBUG_REGB_DATA),
	.DEBUG_CC_DATA(DEBUG_CC_DATA),
	.DEBUG_PC_A(DEBUG_PC_A),
	.DEBUG_INSTRUCTION({GROUPX,INSTRUCTION}),
	
	// Signals to the instruction phase decoder
	.DEBUG_STOP(DEBUG_STOP),
	.DEBUG_REQ(DEBUG_REQ),
	.DEBUG_ACK(DEBUG_ACK)

);

/***************************************
* Debugging operation decoder
****************************************/
debugDecoder debugDecoderInst(
	.DEBUG_ADDR_INC_I(DEBUG_ADDR_INC_I),
	.DEBUG_OP_I(DEBUG_OP_I),
	.DEBUG_ARG(DEBUG_ARG),
	
	.DEBUG_ADDR_BUSX(DEBUG_ADDR_BUSX),
	.DEBUG_ADDR_INCX(DEBUG_ADDR_INCX),
	.DEBUG_LD_ARGX(DEBUG_LD_ARGX),
	.DEBUG_LD_DATAX(DEBUG_LD_DATAX),
	.DEBUG_DATAX(DEBUG_DATAX),
	.DEBUG_BUS_SEQX(DEBUG_BUS_SEQX),
	.DEBUG_REG_SEQX(DEBUG_REG_SEQX),
	.DEBUG_CC_REGX(DEBUG_CC_REGX),
	.DEBUG_PC_NEXTX(DEBUG_PC_NEXTX)

);
/***************************************
* Debugging latches sequencer
****************************************/
debugSequencer debugSequencerInst(	
	.CLK(CLK),
	.RESET(RESET),
	.COMMIT(COMMIT),
	.EXECUTE(EXECUTE),
	.DEBUG_ADDR_INCX(DEBUG_ADDR_INCX),
	.DEBUG_LD_ARGX(DEBUG_LD_ARGX),
	.DEBUG_LD_DATAX(DEBUG_LD_DATAX),
	.DEBUG_ADDR_INC_EN(DEBUG_ADDR_INC_EN),
	.DEBUG_LD_DATA_EN(DEBUG_LD_DATA_EN),
	.DEBUG_LD_ARG_EN(DEBUG_LD_ARG_EN)
);

/***************************************
* Instruction Phase Decoder
****************************************/
instructionPhaseDecoder instructionPhaseDecoderInst(
	.CLK(CLK),
	.RESET(RESET),
	.HALTX(HALTX),
	.DEBUG_STOP(DEBUG_STOP),
	.DEBUG_MODE(DEBUG_MODE),
	.DEBUG_STEP_REQ(DEBUG_REQ),
	
	.STOPPED(STOPPED),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),

	.DEBUG_STEP_ACK(DEBUG_ACK),
	.DEBUG_ACTIVE(DEBUG_ACTIVE),
	.PC_ENX(PC_ENX)
);

/***************************************
* Instruction Latch
****************************************/
instructionLatch instructionLatchInst(
	.CLK(CLK),
	.RESET(RESET),
	.EXECUTE(EXECUTE),
	.DIN(DIN),
	.DEBUG_OP(DEBUG_OP),
	.DEBUG_ADDR_INC(DEBUG_ADDR_INC),
	.DEBUG_MODE(DEBUG_MODE),
	.INSTRUCTION(INSTRUCTION),
	.GROUPX(GROUPX),
	.DEBUG_ADDR_INC_I(DEBUG_ADDR_INC_I),
	.DEBUG_OP_I(DEBUG_OP_I),
	.DEBUG_MODE_I(DEBUG_MODE_I)
);

/***************************************
* ALU
****************************************/
fullALU fullALUInst(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.REGA_DOUT(REGA_DOUT),
	.REGB_DOUT(REGB_DOUT),
	
	.ALU_OPX(ALU_OPX),
	.ALUA_SRCX(ALUA_SRCX),
	.ALUB_SRCX(ALUB_SRCX),
	
	.ARGA_X(ARGA_X),
	.ARGB_X(ARGB_X),
	.B5(INSTRUCTION[13]),
	
	.CCL_LD(CCL_LD),
	.CCL_ENRX(CCL_ENRX),
	.CCL_EN0X(CCL_EN0X),
	.CCL_EN1X(CCL_EN1X),
	.CC_REGX(CC_REGX),
	.ALU_R(ALU_R),
	.CC_ZERO(CC_ZERO),
	.CC_SIGN(CC_SIGN),
	.CC_CARRY(CC_CARRY),
	.CC_PARITY(CC_PARITY),
	.ALUA_DATA(ALUA_DATA),
	.ALUB_DATA(ALUB_DATA)
);

/***************************************
* Register File
****************************************/
registerFile registerFileInst(
	.CLK(CLK),
	.RESET(RESET),
	.ALU_R(ALU_R),
	.DIN(DIN),
	.HERE(HERE + 16'h0002),
	.REGA_EN(REGA_EN),
	.REGA_WEN(REGA_WEN),
	.REGB_EN(REGB_EN),
	.REGB_WEN(REGB_WEN),
	.REGA_BYTE_EN(2'b11),
	.REGB_BYTE_EN(2'b11),
	.ARGA_X(ARGA_X),
	.ARGB_X(ARGB_X),
	.REGA_ADDRX(REGA_ADDRX),
	.REGB_ADDRX(REGB_ADDRX),
	.REGA_DINX(REGA_DINX),
	.REGA_BYTEX(HIGH_BYTEX),
	.REGA_DOUT(REGA_DOUT),
	.REGB_DOUT(REGB_DOUT)
);

/***************************************
* Bus Controller
****************************************/
busController busControllerInst(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.BUS_SEQX(BUS_SEQX),
	.DEBUG_MA(DEBUG_ADDR_OUT),
	.DEBUG_MD(DEBUG_DATA_OUT),
	.PC_A(PC_A),
	.ALU_R(ALU_R),
	.ALUB_DATA(ALUB_DATA),
	.ADDR_BUSX(ADDR_BUSX),
	.ADDR_BUF(ADDR_BUF),
	.REGA_DOUT(REGA_DOUT),
	.DATA_BUSX(DATA_BUSX),
	.BYTEX(BYTEX),
	.DOUT_BUF(DOUT_BUF),
	.HERE(HERE),
	.HIGH_BYTEX(HIGH_BYTEX),
	.RDN_BUF(RDN_BUF),
	.WRN0_BUF(WRN0_BUF),
	.WRN1_BUF(WRN1_BUF)
);

/***************************************
* Program Counter
****************************************/
programCounter programCounterInst(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.PC_ENX(PC_ENX),
	.PC_LD_INT0X(PC_LD_INT0X),
	.PC_LD_INT1X(PC_LD_INT1X),
	.PC_BASEX(PC_BASEX),
	.PC_OFFSETX(PC_OFFSETX),
	.REGB_DOUT(ALUB_DATA),
	.DIN(DIN),
	.PC_NEXTX(PC_NEXTX),
	.HERE(HERE),
	.PC_A_NEXT(PC_A_NEXT),
	.PC_A(PC_A)
);

/***************************************
* Interrupt Logic
****************************************/
interruptStateMachine interruptStateMachineInst(
	.CLK(CLK),
	.RESET(RESET),
	.COMMIT(COMMIT),
	.RETIX(RETIX),
	.EIX(EIX),
	.DIX(DIX),
	.INT0(INT0),
	.INT1(INT1),
	.PC_NEXTX(INT_PC_NEXTX),
	.PC_LD_INT0(PC_LD_INT0X),
	.PC_LD_INT1(PC_LD_INT1X),
	.CCL_ENRX(CCL_ENRX),
	.CCL_EN0X(CCL_EN0X),
	.CCL_EN1X(CCL_EN1X),
	.CC_REGX(INT_CC_REGX)
);

/***************************************
* ALU Group Decoder
****************************************/
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

/***************************************
* Load/Store Group Decoder
****************************************/
loadStoreGroupDecoder loadStoreGroupDecoderInst(
	.CLK(CLK),
	.RESET(RESET),
	.OPF(INSTRUCTION[12:11]),
	.MODEF(INSTRUCTION[10:8]),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.ALUA_SRCX(LDS_ALUA_SRCX),
	.ALUB_SRCX(LDS_ALUB_SRCX),
	.ALU_OPX(LDS_ALU_OPX),
	.BUS_SEQX(LDS_BUS_SEQX),
	.REG_SEQX(LDS_REG_SEQX),
	.REGA_DINX(LDS_REGA_DINX),
	.REGA_ADDRX(LDS_REGA_ADDRX),
	.REGB_ADDRX(LDS_REGB_ADDRX),
	.DATA_BUSX(LDS_DATA_BUSX),
	.BYTEX(LDS_BYTEX),
	.PC_OFFSETX(LDS_PC_OFFSETX),
	.ADDR_BUSX(LDS_ADDR_BUSX)
);

/***************************************
* Jump Group Decoder
****************************************/
jumpGroupDecoder jumpGroupDecoderInst(
	.CLK(CLK),
	.RESET(RESET),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.GROUPF(GROUPX),
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
	.ADDR_BUSX(JMP_ADDR_BUSX),
	.REGA_DINX(JMP_REGA_DINX),
	.REGA_ADDRX(JMP_REGA_ADDRX),
	.REGB_ADDRX(JMP_REGB_ADDRX),
	.REG_SEQX(JMP_REG_SEQX),
	.ALUB_SRCX(JMP_ALUB_SRCX),
	.BUS_SEQX(JMP_BUS_SEQX)
);

/***************************************
* General Group Decoder
****************************************/
generalGroupDecoder generalGroupDecoderInst(
	
	.CLK(CLK),
	.RESET(RESET),
	.EXECUTE(EXECUTE), 
	.COMMIT(COMMIT),
	.INSTRUCTION_GROUP(GROUPX),
	.INSTRUCTION_OP(INSTRUCTION[10:8]),
	
	.EIX(EIX),
	.DIX(DIX),
	.RETIX(RETIX),
	.HALTX(HALTX)
);

/***************************************
* Control Signal Multiplexer
****************************************/
opxMultiplexer opxMultiplexerInst(

	.INSTRUCTION_GROUP(GROUPX),
	.INSTRUCTION_ARGBX(INSTRUCTION[3:0]),

	.ALU_ALU_OPX(ALU_ALU_OPX),
	.ALU_ALUA_SRCX(ALU_ALUA_SRCX),
	.ALU_ALUB_SRCX(ALU_ALUB_SRCX),
	.ALU_CCL_LD(ALU_CCL_LD),
	.ALU_REG_SEQX(ALU_REG_SEQX),
	.ALU_REGA_ADDRX(ALU_REGA_ADDRX),
	.ALU_REGB_ADDRX(ALU_REGB_ADDRX),
	
	.DEBUG_ARGBX(DEBUG_ARGBX),
	.DEBUG_ADDR_BUSX(DEBUG_ADDR_BUSX),
	.DEBUG_MODEX(DEBUG_MODE),
	.DEBUG_BUS_SEQX(DEBUG_BUS_SEQX),
	.DEBUG_CC_REGX(DEBUG_CC_REGX),
	.DEBUG_PC_NEXTX(DEBUG_PC_NEXTX),
	.DEBUG_REG_SEQX(DEBUG_REG_SEQX),
	
	.INT_CC_REGX(INT_CC_REGX),
	.INT_PC_NEXTX(INT_PC_NEXTX),
	
	.LDS_ADDR_BUSX(LDS_ADDR_BUSX),
	.LDS_ALU_OPX(LDS_ALU_OPX),
	.LDS_ALUA_SRCX(LDS_ALUA_SRCX),
	.LDS_ALUB_SRCX(LDS_ALUB_SRCX),
	.LDS_BYTEX(LDS_BYTEX),	
	.LDS_BUS_SEQX(LDS_BUS_SEQX),
	.LDS_DATA_BUSX(LDS_DATA_BUSX),	
	.LDS_PC_OFFSETX(LDS_PC_OFFSETX),
	.LDS_REG_SEQX(LDS_REG_SEQX),
	.LDS_REGA_ADDRX(LDS_REGA_ADDRX),
	.LDS_REGA_DINX(LDS_REGA_DINX),
	.LDS_REGB_ADDRX(LDS_REGB_ADDRX),

	.JMP_ADDR_BUSX(JMP_ADDR_BUSX),
	.JMP_ALUB_SRCX(JMP_ALUB_SRCX),
	.JMP_BUS_SEQX(JMP_BUS_SEQX),
	.JMP_REG_SEQX(JMP_REG_SEQX),
	.JMP_REGA_DINX(JMP_REGA_DINX),
	.JMP_REGA_ADDRX(JMP_REGA_ADDRX),
	.JMP_REGB_ADDRX(JMP_REGB_ADDRX),
	.JMP_PC_BASEX(JMP_PC_BASEX),
	.JMP_PC_OFFSETX(JMP_PC_OFFSETX),

	/*********************************************
	* Combined outputs
	**********************************************/
	.ADDR_BUSX(ADDR_BUSX),
	.ALU_OPX(ALU_OPX),
	.ALUA_SRCX(ALUA_SRCX),
	.ALUB_SRCX(ALUB_SRCX),
	.ARGBX(ARGB_X),
	.BUS_SEQX(BUS_SEQX),
	.BYTEX(BYTEX),
	.CCL_LD(CCL_LD),
	.CC_REGX(CC_REGX),
	.DATA_BUSX(DATA_BUSX),
	.PC_BASEX(PC_BASEX),
	.PC_OFFSETX(PC_OFFSETX),	
	.PC_NEXTX(PC_NEXTX),
	.REG_SEQX(REG_SEQX),
	.REGA_ADDRX(REGA_ADDRX),
	.REGA_DINX(REGA_DINX),
	.REGB_ADDRX(REGB_ADDRX)
);

/*********************************************
* register file sequencer
**********************************************/
registerSequencer registerSequencerInst(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.STOPPED(STOPPED),
	
	.REG_SEQX(REG_SEQX),

	.REGA_EN(REGA_EN),
	.REGA_WEN(REGA_WEN),
	.REGB_EN(REGB_EN),
	.REGB_WEN(REGB_WEN)
);

endmodule