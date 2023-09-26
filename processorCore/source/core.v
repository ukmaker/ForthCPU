/**
* All the CPU functional units together, but without the pin bindings
**/
`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module core(
	
	input CLK,
	input RESET,
	
	output wire FETCH, DECODE, EXECUTE, COMMIT,
	
	output [15:0] ABUS,
	output [15:0] DBUS_OUT,
	input  [15:0] DBUS_IN,
	
	output RD,
	output WR
	
);

wire [15:0] INSTRUCTION;

wire [15:0] PC_A;
wire [15:0] PC_D;
wire [15:0] REG_B;
wire [15:0] ALUA_DIN;
wire [1:0] ADDR_BUSX;
wire [1:0] DATA_BUSX;
wire [15:0] ADDR;
wire [15:0] REGA_DOUT;
wire [15:0] REGB_DOUT;
wire [3:0] ARGA_X;
wire [3:0] ARGB_X;
wire       ALUA_SRCX;
wire [2:0] ALUB_SRCX;
wire [1:0] ALUA_CONSTX;
wire [3:0] ALU_OPX;
wire [1:0] LDS_SRCX;
wire ALU_LD;
wire CCL_LD;
wire [15:0] ALUA_DATA;
wire [15:0] ALUB_DATA;
wire [15:0] ALU_R;
wire [15:0] ALUA_PP;
wire [3:0]  CCN;
wire [2:0] REGA_ADDRX;
wire [1:0] REGB_ADDRX;
wire [1:0] REGA_DINX;

wire PC_EN;
wire JRX;
wire JMP_X;
wire CC_APPLYX;
wire CC_INVERTX;
wire [1:0]CC_SELECTX;


/**
* Wires from decoders to opx multiplexer
**/
wire [3:0] ALU_ALU_OPX;
wire [3:0] LDS_ALU_OPX;

wire ALU_ALU_LD;
wire LDS_ALU_LD;

wire ALU_REGA_EN;
wire ALU_REGB_EN;
wire ALU_REGA_WEN;
wire ALU_REGB_WEN;

wire LDS_REGA_EN;
wire LDS_REGB_EN;
wire LDS_REGA_WEN;
wire LDS_REGB_WEN;

wire [1:0] ALU_ALUA_CONSTX;
wire [1:0] LDS_ALUA_CONSTX;

wire ALU_ALUA_SRCX;
wire LDS_ALUA_SRCX;

wire [2:0] ALU_ALUB_SRCX;
wire [2:0] LDS_ALUB_SRCX;
wire [2:0] PCC_ALUB_SRCX;

wire [1:0] ALU_REGA_DINX;
wire [1:0] LDS_REGA_DINX;

wire [2:0] ALU_REGA_ADDRX;
wire [2:0] LDS_REGA_ADDRX;

wire [1:0] ALU_REGB_ADDRX;
wire [1:0] LDS_REGB_ADDRX;
wire [1:0] PCC_REGB_ADDRX;

wire [1:0] ALU_DATA_BUSX;
wire [1:0] LDS_DATA_BUSX;

wire        ALU_DATA_BUS_OEN;
wire        LDS_DATA_BUS_OEN;

wire [1:0] ALU_ADDR_BUSX;
wire [1:0] LDS_ADDR_BUSX;	


/**
* Aliases
**/
assign PC_D = ALUB_DATA;
assign INSTRUCTION = DBUS_IN;

instructionPhaseDecoder ipd(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT)
);

opxMultiplexer opxMux(

	
	.CLK(CLK),
	.RESET(RESET),
	.INSTRUCTION(INSTRUCTION),
	
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	
	.ALU_ALU_OPX(ALU_ALU_OPX),
	.LDS_ALU_OPX(LDS_ALU_OPX),
	
	.ALU_ALU_LD(ALU_ALU_LD),
	.LDS_ALU_LD(LDS_ALU_LD),
	
	.ALU_REGA_EN(ALU_REGA_EN),
	.ALU_REGB_EN(ALU_REGB_EN),
	.ALU_REGA_WEN(ALU_REGA_WEN),
	.ALU_REGB_WEN(ALU_REGB_WEN),
	
	.LDS_REGA_EN(LDS_REGA_EN),
	.LDS_REGB_EN(LDS_REGB_EN),
	.LDS_REGA_WEN(LDS_REGA_WEN),
	.LDS_REGB_WEN(LDS_REGB_WEN),
	
	.ALU_ALUA_CONSTX(ALU_ALUA_CONSTX),
	.LDS_ALUA_CONSTX(LDS_ALUA_CONSTX),
	
	.ALU_ALUA_SRCX(ALU_ALUA_SRCX),
	.LDS_ALUA_SRCX(LDS_ALUA_SRCX),

	.ALU_ALUB_SRCX(ALU_ALUB_SRCX),
	.LDS_ALUB_SRCX(LDS_ALUB_SRCX),
	.PCC_ALUB_SRCX(PCC_ALUB_SRCX),

	.ALU_REGA_DINX(ALU_REGA_DINX),
	.LDS_REGA_DINX(LDS_REGA_DINX),
	
	.ALU_REGA_ADDRX(ALU_REGA_ADDRX),
	.LDS_REGA_ADDRX(LDS_REGA_ADDRX),
	
	.ALU_REGB_ADDRX(ALU_REGB_ADDRX),
	.LDS_REGB_ADDRX(LDS_REGB_ADDRX),
	.PCC_REGB_ADDRX(PCC_REGB_ADDRX),
	
	.ALU_DATA_BUSX(ALU_DATA_BUSX),
	.LDS_DATA_BUSX(LDS_DATA_BUSX),
	
	.ALU_DATA_BUS_OEN(ALU_DATA_BUS_OEN),
	.LDS_DATA_BUS_OEN(LDS_DATA_BUS_OEN),
	
	.ALU_ADDR_BUSX(ALU_ADDR_BUSX),	
	.LDS_ADDR_BUSX(LDS_ADDR_BUSX),	
	
	/**
	* OUTPUTS
	**/
	/**
	* Register file
	**/
	.REGA_EN(REGA_EN),
	.REGB_EN(REGB_EN),
	.REGA_WEN(REGA_WEN),
	.REGB_WEN(REGB_WEN),
	
	/**
	* ALU
	**/
	.ALU_OPX(ALU_OPX),        // ALU operation
	.ALU_LD(ALU_LD),
	.ALUA_CONSTX(ALUA_CONSTX),

	/**
	* Data Sources
	**/
	.ALUA_SRCX(ALUA_SRCX),
	.ALUB_SRCX(ALUB_SRCX),	
	.REGA_DINX(REGA_DINX),
	.REGA_ADDRX(REGA_ADDRX),
	.REGB_ADDRX(REGB_ADDRX),
		
	/**
	* Bus control
	**/
	.DATA_BUSX(DATA_BUSX),
	.DATA_BUS_OEN(DATA_BUS_OEN),
	.ADDR_BUSX(ADDR_BUSX)
	
);

addressBusController abusController(
	.PC_A(PC_A),
	.ALU_R(ALU_R),
	.REG_B(REGB_DOUT),
	.ALUA_DIN(ALUA_DATA),
	.ADDR_BUSX(ADDR_BUSX),
	.ADDR(ABUS)
);

dataBusController dbusController(
	.DATA_BUSX(DATA_BUSX),
	.PC_A(PC_A),
	.ALU_R(ALU_R),
	.REGA_DOUT(REGA_DOUT),
	.DOUT(DBUS_OUT)
);

fullALU alu(
	.CLK(CLK),
	.RESET(RESET),
	.REGA_DOUT(REGA_DOUT),
	.REGB_DOUT(REGB_DOUT),
	.ALU_OPX(ALU_OPX),
	.ARGA_X(ARGA_X),
	.ARGB_X(ARGB_X),
	.ALUA_SRCX(ALUA_SRCX),
	.ALUA_CONSTX(ALUA_CONSTX),
	.ALUB_SRCX(ALUB_SRCX),
	.LDS_SRCX(LDS_SRCX),
	.ALU_LD(ALU_LD),
	.CCL_LD(CCL_LD),
	.ALUA_DATA(ALUA_DATA),
	.ALUB_DATA(ALUB_DATA),
	.ALU_R(ALU_R),
	.ALUA_PP(ALUA_PP),
	.CCN(CCN)
);

aluGroupDecoder aluDecoder(
	.CLK(CLK),
	.RESET(RESET),
	.INSTRUCTION(INSTRUCTION),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.REGA_CLKEN(ALU_REGA_EN),
	.REGB_CLKEN(ALU_REGB_EN),
	.REGA_WEN(ALU_REGA_WEN),
	.REGB_WEN(ALU_REGB_WEN),
	.ALU_OPX(ALU_OPX),
	.ALU_LD(ALU_ALU_LD),
	.CCL_LD(ALU_CCL_LD),
	.ALUA_SRCX(ALU_ALUA_SRCX),
	.ALUB_SRCX(ALU_ALUB_SRCX),
	.ALUA_CONSTX(ALU_ALUA_CONSTX),
	.ARGA_X(ARGA_X),
	.ARGB_X(ARGB_X),
	.REGA_ADDRX(ALU_REGA_ADDRX),
	.REGB_ADDRX(ALU_REGB_ADDRX)
	
);

jumpGroupDecoder pcDecoder(
	.CLK(CLK),
	.RESET(RESET),
	.INSTRUCTION(INSTRUCTION),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.PC_EN(PC_EN),
	.JRX(JRX),
	.JMP_X(JMP_X),
	.CC_APPLYX(CC_APPLYX),
	.CC_INVERTX(CC_INVERTX),
	.CC_SELECTX(CC_SELECTX),
	.REGB_ADDRX(PCC_REGB_ADDRX),
	.ALUB_SRCX(PCC_ALUB_SRCX)
);

programCounter pc(
	.CLK(CLK),
	.RESET(RESET),
	.PC_EN(PC_EN),
	.COMMIT(COMMIT),
	.PC_D(PC_D),
	.JRX(JRX),
	.JMPX(JMP_X),
	.CC_SIGN(CC_SIGN),
	.CC_CARRY(CC_CARRY),
	.CC_ZERO(CC_ZERO),
	.CC_PARITY(CC_PARITY),
	.CC_SELECTX(CC_SELECTX),
	.CC_INVERTX(CC_INVERTX),
	.CC_APPLYX(CC_APPLYX),
	.PC_A(PC_A)
);
loadStoreGroupDecoder ldsDecoder(
	.CLK(CLK),
	.RESET(RESET),
	.INSTRUCTION(INSTRUCTION[13:8]),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	
	.REGA_EN(LDS_REGA_EN),
	.REGB_EN(LDS_REGB_EN),
	.REGA_WEN(LDS_REGA_WEN),
	.REGB_WEN(LDS_REGB_WEN),
	.ALU_OPX(LDS_ALU_OPX),
	.ALU_LD(LDS_ALU_LD),
	.ALUA_CONSTX(LDS_ALUA_CONSTX),
	.ALUA_SRCX(LDS_ALUA_SRCX),
	.ALUB_SRCX(LDS_ALUB_SRCX),
	.REGA_DINX(LDS_REGA_DINX),
	.REGA_ADDRX(LDS_REGA_ADDRX),
	.REGB_ADDRX(LDS_REGB_ADDRX),
	.DATA_BUSX(DATA_BUSX),
	.DATA_BUS_OEN(DATA_BUS_OEN),
	.ADDR_BUSX(ADDR_BUSX)
);
register_file registers(
	.CLK(CLK),
	.RESET(RESET),
	.ALU_R(ALU_R),
	.PC_A(PC_A),
	.ALUA_PP(ALUA_PP),
	.DIN(DBUS_IN),
	.REGA_EN(REGA_EN),
	.REGA_WEN(REGA_WEN),
	.REGB_EN(REGB_EN),
	.REGB_WEN(REGB_WEN),
	.ARGA_X(ARGA_X),
	.REGA_ADDRX(REGA_ADDRX),
	.REGB_ADDRX(REGB_ADDRX),
	.REGA_DINX(REGA_DINX),
	.ARGB_X(ARGB_X),
	.REGA_DOUT(REGA_DOUT),
	.REGB_DOUT(REGB_DOUT)
);
endmodule