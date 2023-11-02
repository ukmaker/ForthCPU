/**
* All the CPU functional units together, but without the pin bindings
**/
`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module core(
	
	input CLK,
	input RESET,
	
	output wire FETCH, DECODE, EXECUTE, COMMIT,
	
	output [15:0] ADDR_BUF,
	output [15:0] DOUT_BUF,
	input  [15:0] DIN,
	input INT0,
	input INT1,
	
	output RDN_BUF, 
	output ABUS_OEN,
	output WRN0_BUF, 
	output WRN1_BUF
	
);

/***************************************
* Wiring
****************************************/
wire [1:0]  ADDR_BUSX;
wire [3:0]  ALU_OPX;
wire [15:0] ALU_R;
wire [15:0] ALUA_DATA;
wire [2:0]  ALUA_SRCX;
wire [15:0] ALUB_DATA;
wire [2:0]  ALUB_SRCX;
wire [3:0]  ARGA_X;
wire [3:0]  ARGB_X;
wire         CCL_LD;
wire         CC_ZERO;
wire         CC_CARRY;
wire         CC_PARITY;
wire         CC_SIGN;
wire         CC_APPLYX;
wire         CC_INVERTX;
wire [1:0]  CC_SELECTX;
wire [1:0]  DATA_BUSX;
wire         DIX;
wire         EIX;
wire [15:0] HERE;
wire [15:0] INSTRUCTION;
wire [1:0]  LDSINCF;
wire [15:0] PC_A;
wire [15:0] PC_A_NEXT;
wire [1:0]  PC_BASEX;
wire         PC_LD_INT0X;
wire         PC_LD_INT1X;
wire [2:0]  PC_NEXTX;
wire [1:0]  PC_OFFSETX;
wire         PC_ENX;
wire [1:0]  REGA_ADDRX;
wire [1:0]  REGA_BYTE_ENX;
wire [1:0]  REGA_DINX;
wire [15:0] REGA_DOUT;
wire         REGA_EN;
wire         REGA_WEN;
wire [2:0]  REGB_ADDRX;
wire [1:0]  REGB_BYTE_ENX;
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
wire [1:0]  ALU_REGA_ADDRX;
wire         ALU_REGA_EN;
wire [2:0]  ALU_REGB_ADDRX;
wire         ALU_REGB_EN;
wire         ALU_REGA_WEN;
wire         ALU_REGB_WEN;

wire [1:0]  LDS_ADDR_BUSX;
wire [2:0]  LDS_ALUA_SRCX;
wire [2:0]  LDS_ALUB_SRCX;
wire [3:0]  LDS_ALU_OPX;
wire         LDS_BYTEX;
wire [1:0]  LDS_DATA_BUSX;
wire [1:0]  LDS_PC_BASEX;
wire [1:0]  LDS_PC_OFFSETX;
wire         LDS_RDX;
wire         LDS_REGA_EN;
wire         LDS_REGA_WEN;
wire         LDS_REGB_EN;
wire         LDS_REGB_WEN;
wire [1:0]  LDS_REGA_ADDRX;
wire [1:0]  LDS_REGA_BYTE_ENX;
wire [1:0]  LDS_REGA_DINX;
wire [2:0]  LDS_REGB_ADDRX;
wire [1:0]  LDS_REGB_BYTE_ENX;
wire         LDS_WRX;

wire [1:0]  JMP_ADDR_BUSX;
wire [1:0]  JMP_PC_BASEX;
wire [1:0]  JMP_PC_OFFSETX;
wire [1:0]  JMP_REGA_ADDRX;
wire [2:0]  JMP_REGB_ADDRX;
wire         JMP_REGA_EN;
wire         JMP_REGA_WEN;
wire         JMP_REGB_EN;
wire [2:0]  JMP_ALUB_SRCX;

/**
* No ABUS tristate control yet
**/
assign ABUS_OEN = 0;

/***************************************
* Instruction Phase Decoder
****************************************/
instructionPhaseDecoder instructionPhaseDecoderInst(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.DIN(DIN),
	.INSTRUCTION(INSTRUCTION),
	.PC_ENX(PC_ENX)
);

/***************************************
* ALU
****************************************/
fullALU fullALUInst(
	.CLK(CLK),
	.RESET(RESET),
	.REGA_DOUT(REGA_DOUT),
	.REGB_DOUT(REGB_DOUT),
	
	.ALU_OPX(ALU_OPX),
	.ALUA_SRCX(ALUA_SRCX),
	.ALUB_SRCX(ALUB_SRCX),
	
	.ARGA_X(ARGA_X),
	.ARGB_X(ARGB_X),
	.B5(INSTRUCTION[13]),
	
	.CCL_LD(CCL_LD),
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
	.PC_A_NEXT(PC_A_NEXT),
	.REGA_EN(REGA_EN),
	.REGA_WEN(REGA_WEN),
	.REGB_EN(REGB_EN),
	.REGB_WEN(REGB_WEN),
	.REGA_BYTE_EN(REGA_BYTE_ENX),
	.REGB_BYTE_EN(REGB_BYTE_ENX),
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
	.DECODE(DECODE),
	.COMMIT(COMMIT),
	.PC_A(PC_A),
	.ALU_R(ALU_R),
	.ALUB_DATA(ALUB_DATA),
	.ADDR_BUSX(ADDR_BUSX),
	.ADDR_BUF(ADDR_BUF),
	.REGA_DOUT(REGA_DOUT),
	.DATA_BUSX(DATA_BUSX),
	.BYTEX(BYTEX),
	.WRX(WRX),
	.RDX(RDX),
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
	.PC_NEXTX(PC_NEXTX),
	.PC_LD_INT0(PC_LD_INT0X),
	.PC_LD_INT1(PC_LD_INT1X)
);

/***************************************
* ALU Group Decoder
****************************************/
aluGroupDecoder aluGroupDecoderInst(
	.CLK(CLK),
	.RESET(RESET),
	.INSTRUCTION(INSTRUCTION),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.REGA_EN(ALU_REGA_EN),
	.REGB_EN(ALU_REGB_EN),
	.REGA_WEN(ALU_REGA_WEN),
	.REGB_WEN(ALU_REGB_WEN),
	.REGA_ADDRX(ALU_REGA_ADDRX),
	.REGB_ADDRX(ALU_REGB_ADDRX),
	.ALU_OPX(ALU_ALU_OPX),
	.CCL_LD(CCL_LD),
	.ALUA_SRCX(ALU_ALUA_SRCX),
	.ALUB_SRCX(ALU_ALUB_SRCX),
	.ARGA_X(ARGA_X),
	.ARGB_X(ARGB_X)
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
	.REGA_EN(LDS_REGA_EN),
	.REGB_EN(LDS_REGB_EN),
	.REGA_WEN(LDS_REGA_WEN),
	.REGB_WEN(LDS_REGB_WEN),
	.ALUA_SRCX(LDS_ALUA_SRCX),
	.ALUB_SRCX(LDS_ALUB_SRCX),
	.ALU_OPX(LDS_ALU_OPX),
	.REGA_DINX(LDS_REGA_DINX),
	.REGA_ADDRX(LDS_REGA_ADDRX),
	.REGB_ADDRX(LDS_REGB_ADDRX),
	.REGA_BYTE_ENX(LDS_REGA_BYTE_ENX),
	.REGB_BYTE_ENX(LDS_REGB_BYTE_ENX),
	.DATA_BUSX(LDS_DATA_BUSX),
	.BYTEX(LDS_BYTEX),
	.PC_OFFSETX(LDS_PC_OFFSETX),
	.WRX(LDS_WRX),
	.RDX(LDS_RDX),
	.ADDR_BUSX(LDS_ADDR_BUSX)
);

/***************************************
* Jump Group Decoder
****************************************/
jumpGroupDecoder jumpGroupDecoderInst(
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
	.ADDR_BUSX(JMP_ADDR_BUSX),
	.REGA_ADDRX(JMP_REGA_ADDRX),
	.REGB_ADDRX(JMP_REGB_ADDRX),
	.REGA_EN(JMP_REGA_EN),
	.REGB_EN(JMP_REGB_EN),
	.REGA_WEN(JMP_REGA_WEN),
	.ALUB_SRCX(JMP_ALUB_SRCX)
);

/***************************************
* General Group Decoder
****************************************/
generalGroupDecoder generalGroupDecoderInst(
	
	.CLK(CLK),
	.RESET(RESET),
	.EXECUTE(EXECUTE), 
	.COMMIT(COMMIT),
	.INSTRUCTION_GROUP(INSTRUCTION[15:14]),
	.INSTRUCTION_OP(INSTRUCTION[10:8]),
	
	.EIX(EIX),
	.DIX(DIX),
	.RETIX(RETIX),
	.PC_ENX(PC_ENX)
);

/***************************************
* Control Signal Multiplexer
****************************************/
opxMultiplexer opxMultiplexerInst(

	.CLK(CLK),
	.INSTRUCTION_GROUP(INSTRUCTION[15:14]),

	.FETCH(FETCH),
	.EXECUTE(EXECUTE),

	.ALU_ALU_OPX(ALU_ALU_OPX),
	.ALU_ALUA_SRCX(ALU_ALUA_SRCX),
	.ALU_ALUB_SRCX(ALU_ALUB_SRCX),
	.ALU_REGA_ADDRX(ALU_REGA_ADDRX),
	.ALU_REGA_EN(ALU_REGA_EN),
	.ALU_REGB_ADDRX(ALU_REGB_ADDRX),
	.ALU_REGB_EN(ALU_REGB_EN),
	.ALU_REGA_WEN(ALU_REGA_WEN),
	.ALU_REGB_WEN(ALU_REGB_WEN),

	.LDS_ADDR_BUSX(LDS_ADDR_BUSX),
	.LDS_ALU_OPX(LDS_ALU_OPX),
	.LDS_ALUA_SRCX(LDS_ALUA_SRCX),
	.LDS_ALUB_SRCX(LDS_ALUB_SRCX),
	.LDS_BYTEX(LDS_BYTEX),	
	.LDS_DATA_BUSX(LDS_DATA_BUSX),	
	.LDS_PC_OFFSETX(LDS_PC_OFFSETX),
	.LDS_RDX(LDS_RDX),
	.LDS_REGA_EN(LDS_REGA_EN),
	.LDS_REGA_WEN(LDS_REGA_WEN),
	.LDS_REGA_ADDRX(LDS_REGA_ADDRX),
	.LDS_REGA_BYTE_ENX(LDS_REGA_BYTE_ENX),
	.LDS_REGA_DINX(LDS_REGA_DINX),
	.LDS_REGB_EN(LDS_REGB_EN),
	.LDS_REGB_WEN(LDS_REGB_WEN),
	.LDS_REGB_ADDRX(LDS_REGB_ADDRX),
	.LDS_REGB_BYTE_ENX(LDS_REGB_BYTE_ENX),
	.LDS_WRX(LDS_WRX),

	.JMP_ADDR_BUSX(JMP_ADDR_BUSX),
	.JMP_ALUB_SRCX(JMP_ALUB_SRCX),
	.JMP_REGA_ADDRX(JMP_REGA_ADDRX),
	.JMP_REGB_ADDRX(JMP_REGB_ADDRX),
	.JMP_REGA_EN(JMP_REGA_EN),
	.JMP_REGA_WEN(JMP_REGA_WEN),
	.JMP_REGB_EN(JMP_REGB_EN),
	.JMP_PC_BASEX(JMP_PC_BASEX),
	.JMP_PC_OFFSETX(JMP_PC_OFFSETX),

	/*********************************************
	* Combined outputs
	**********************************************/
	.ADDR_BUSX(ADDR_BUSX),
	.ALU_OPX(ALU_OPX),
	.ALUA_SRCX(ALUA_SRCX),
	.ALUB_SRCX(ALUB_SRCX),
	.BYTEX(BYTEX),
	.DATA_BUSX(DATA_BUSX),
	.PC_BASEX(PC_BASEX),
	.PC_OFFSETX(PC_OFFSETX),	
	.RDX(RDX),
	.REGA_EN(REGA_EN),
	.REGA_WEN(REGA_WEN),
	.REGA_ADDRX(REGA_ADDRX),
	.REGA_BYTE_ENX(REGA_BYTE_ENX),
	.REGA_DINX(REGA_DINX),
	.REGB_EN(REGB_EN),
	.REGB_WEN(REGB_WEN),
	.REGB_ADDRX(REGB_ADDRX),
	.REGB_BYTE_ENX(REGB_BYTE_ENX),
	.WRX(WRX)

);





endmodule