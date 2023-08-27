/**
*	Decode the opcode to select the appropriate data sources for the ALU
*	
**/

module data_sources(
	
	input [1:0] SOURCEX, // 00 : Ra,Rb | 01 : Ra,U4 | 10 : RA,U8L | 11 : RA, U8H
	
	input [15:0] REG_A, // from the register file
	input [15:0] REG_B, // from the register file
	
	input [3:0] ARG_A, // From the instruction LSB
	input [3:0] ARG_B, // From the instruction LSB
	
	output reg[15:0] ALU_A, // To the ALU	
	output reg[15:0] ALU_B,  // To the ALU	
	
	output reg[15:0] ADDR_A, // To the Register file	
	output reg[15:0] ADDR_B  // To the Register file	

);

always @ (*)
begin
				
	case (SOURCEX[1:0])
		2'b00: 
		begin // Ra,U4
			ADDR_A = ARG_A;
			ADDR_B = ARG_B;
			ALU_A = REG_A;
			ALU_B = REG_B;
		end

		2'b01: 
		begin // Ra,U4
			ADDR_A = ARG_A;
			ADDR_B = 0;
			ALU_A = REG_A;
			ALU_B = {12'h000, ARG_B};
		end

		2'b10: 
		begin // RA,U8L
			ADDR_A = 8;
			ADDR_B = 0;
			ALU_A = REG_A;
			ALU_B = {8'h00, ARG_A, ARG_B};
		end

		2'b11: 
		begin // RA,U8H
			ADDR_A = 8;
			ADDR_B = 0;
			ALU_A = REG_A;
			ALU_B = {ARG_A, ARG_B, 8'h00};
		end

	endcase

end
endmodule