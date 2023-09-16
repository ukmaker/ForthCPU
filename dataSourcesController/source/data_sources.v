/**
* Data routing between
* - register file
* - ALU
* - address bus
* - data bus
* - control registers
* - program counter
**/
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
module data_sources(
	
	input [2:0] ALU_A_SOURCEX,
	input [2:0] ALU_B_SOURCEX,
	input [1:0] DATA_BUSX,
	input [1:0] ADDR_BUSX,
	input [1:0] REGA_SOURCEX,
	input [1:0] REGB_SOURCEX,
	
	input [15:0] PC_ADDR,
	input [15:0] REG_A,
	input [15:0] REG_B,
	input [15:0] ALU_RESULT,
	input [15:0] DIN,
	input [3:0] ARG_A,
	input [3:0] ARG_B,
	
	output reg [15:0] PC_DATA,
	output reg [15:0] ALU_A,
	output reg [15:0] ALU_B,
	output reg [15:0] DOUT,
	output reg [15:0] AOUT,
	output reg [15:0] REGA_I,
	output reg [15:0] REGB_I,
	output reg [3:0] REG_ADDR_A,
	output reg [3:0] REG_ADDR_B
	
);

wire [15:0]ARG_U4 = {12'b000000000000,ARG_B};
wire [15:0]ARG_U8 = {8'b00000000,ARG_A,ARG_B};
wire [15:0]ARG_U8RB = {ARG_A,ARG_B,REG_B[7:0]};
wire [15:0]CONST_0 = {16'h0000};
wire [15:0]CONST_2 = {16'h0002};
wire [15:0]CONST_4 = {16'h0004};


always @(ALU_A_SOURCEX) begin
	REG_ADDR_A = ARG_A;
	
	case(ALU_A_SOURCEX)
		`ALU_A_SOURCEX_REG_A: begin
			ALU_A = REG_A;
		end
		`ALU_A_SOURCEX_RA: begin
			ALU_A = REG_A;
			REG_ADDR_A = `RA;
		end
		`ALU_A_SOURCEX_RB: begin
			ALU_A = REG_A;
			REG_ADDR_A = `RB;
		end
		`ALU_A_SOURCEX_SP: begin
			ALU_A = REG_A;
			REG_ADDR_A = `RSP;
		end
		`ALU_A_SOURCEX_FP: begin
			ALU_A = REG_A;
			REG_ADDR_A = `RFP;
		end
		`ALU_A_SOURCEX_RS: begin
			ALU_A = REG_A;
			REG_ADDR_A = `RRS;
		end
	endcase
end

always @(ALU_B_SOURCEX) begin
	
	REG_ADDR_B = ARG_B;
	
	case(ALU_B_SOURCEX)
		`ALU_B_SOURCEX_REG_B: begin
			ALU_B = REG_B;
		end
		`ALU_B_SOURCEX_ARG_U4: begin
			ALU_B = ARG_U4;
		end
		`ALU_B_SOURCEX_ARG_U8: begin
			ALU_B = ARG_U8;
		end
		`ALU_B_SOURCEX_U8_REG_B: begin
			ALU_B = ARG_U8RB;
		end
		`ALU_B_SOURCEX_TWO: begin
			ALU_B = CONST_2;
		end
	endcase
end

always @(DATA_BUSX) begin
	case(DATA_BUSX)
		`DATA_BUSX_REG_A: begin
			DOUT = REG_A;
		end
		`DATA_BUSX_REG_B: begin
			DOUT = REG_B;
		end
		`DATA_BUSX_ALU: begin
			DOUT = ALU_RESULT;
		end
	endcase
end


always @(ADDR_BUSX) begin
	case(ADDR_BUSX)
		`ADDR_BUSX_PC: begin
			AOUT = PC_ADDR;
		end
		`ADDR_BUSX_REG_A: begin
			AOUT = REG_A;
		end
		`ADDR_BUSX_REG_B: begin
			AOUT = REG_B;
		end
		`ADDR_BUSX_ALU: begin
			AOUT = ALU_RESULT;
		end
	endcase
end

always @(REGA_SOURCEX) begin
	case(REGA_SOURCEX)
		`REG_SOURCEX_REGB: begin
			REGA_I = REG_B;
		end
		`REG_SOURCEX_ALU: begin
			REGA_I = ALU_RESULT;
		end
		`REG_SOURCEX_DIN: begin
			REGA_I = DIN;
		end
		`REG_SOURCEX_PC_ADDR: begin
			REGA_I = PC_ADDR;
		end
	endcase
end

always @(REGB_SOURCEX) begin
	case(REGB_SOURCEX)
		`REG_SOURCEX_REGB: begin
			REGB_I = REG_B;
		end
		`REG_SOURCEX_ALU: begin
			REGB_I = ALU_RESULT;
		end
		`REG_SOURCEX_DIN: begin
			REGB_I = DIN;
		end
		`REG_SOURCEX_PC_ADDR: begin
			REGB_I = PC_ADDR;
		end
	endcase
end


endmodule
	
	