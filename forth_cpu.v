/**
* The core of the CPU, not including the bus interfaces
**/

module forth_cpu(
	
	input [15:0] DIN,
	output [15:0] DOUT,
	
	output [15:0] ABUS,
	
	input CLK,
	
	input RESETN,
	
	output RD_WRN,
	output MREQN,
	
	input INTN,
	output HALT,
	
	output FETCH,
	output EXECUTE,
	output DECODE,
	output COMMIT
	
);

wire CCZ;
wire CCC;
wire CCP;
wire CCV;

wire [1:0] SOURCEX;
wire [15:0] REG_A;
wire [15:0] REG_B;

wire [3:0] ARG_A;
wire [3:0] ARG_B;

wire [1:0] ARGX;

wire [3:0] ALUX;
wire [15:0] ALU_A;
wire [15:0] ALU_B;
wire [3:0] ADDR_A;
wire [3:0] ADDR_B;

wire INC_DEC_ENABLE_N;
wire INC_DECN;

instruction_decode instruction_decode_inst(
	
	.DIN(DIN),
	.RESETN(RESETN),
	.CLK(CLK),
	.CCZ(CCZ),
	.CCV(CCV),
	.CCP(CCP),
	.CCC(CCC),
	.SOURCEX(SOURCEX),
	.ARGX(ARGX),
	.ALUX(ALUX),
	.ARGA(ARG_A),
	.ARGB(ARG_B),
	.INCX({INC_DEC_ENABLE_N,INC_DECN}),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT)
);

data_sources data_sources_inst(
	.SOURCEX(SOURCEX),
	.REG_A(REG_A),
	.REG_B(REG_B),
	.ARG_A(ARG_A),
	.ARG_B(ARG_B),
	.ALU_A(ALU_A),
	.ALU_B(ALU_B),
	.ADDR_A(ADDR_A),
	.ADDR_B(ADDR_B)
);

alu alu_inst(
	.ALUX(ALUX),
	.ARGA(ALU_A),
	.ARGB(ALU_B),
	.RESULT(DOUT),
	.SIGN(CCV),
	.CARRY(CCC),
	.ZERO(CCZ),
	.PARITY(CCP)
);

register_file register_file_inst(
	.DIN(DOUT),
	.DOUT_A(ALU_A),
	.DOUT_B(ALU_B),
	.DOUT_C(ABUS),
	.ADDR_A(ADDR_A),
	.ADDR_B(ADDR_B),
	.UP_DOWNN(INC_DECN),
	.IDN(INC_DEC_ENABLE_N),
	.LDN(WRITEX),
	.CLK(CLK),
	.RESETN(RESETN)
);












endmodule