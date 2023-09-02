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

wire [3:0] REGAX;
wire [3:0] REGBX;

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
	.REGAX(REGAX),
	.REGBX(REGBX),
	.REGAOPX(REGAOPX),
	.REGBOPX(REGBOPX),
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
	.ADDR_A(ADDR_A),
	.ADDR_B(ADDR_B),
	.REGBOPX(REGBOPX),
	.REGAOPX(REGAOPX),
	.CLK(CLK),
	.RESETN(RESETN)
);












endmodule