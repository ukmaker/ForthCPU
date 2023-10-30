`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module alu(
	input [3:0] ALUX,
	input signed [15:0] ARGA,
	input signed [15:0] ARGB,
	
	output reg signed[15:0] RESULT,
	
	output reg SIGN,
	output reg CARRY,
	output reg ZERO,
	output reg PARITY
	

);

reg mul;
reg arithmetic;
reg sex;

reg OVFL;

reg [15:0] tmp;
	
always @ (*)
	
		begin
			mul = 0;
			arithmetic = 0;
			OVFL = 0;
			
			case (ALUX[3:0])
				`ALU_OPX_MOV: begin // MOV group. Output copies port B
					RESULT = ARGB;
					end
					
				`ALU_OPX_ADD: begin // ADD group. Output is A+B
					{CARRY,RESULT} = ARGA + ARGB;
					arithmetic = 1;
					end
					
				`ALU_OPX_SUB: begin // SUB
					{CARRY,RESULT} = ARGA - ARGB;
					arithmetic = 1;
					end
					
				`ALU_OPX_MUL: begin // MUL
					mul = 1;
					{tmp,RESULT} = ARGA * ARGB;
					end
					
				`ALU_OPX_OR: begin // OR
					RESULT = ARGA | ARGB;
					end
					
				`ALU_OPX_AND: begin // AND
					RESULT = ARGA & ARGB;
					end
					
				`ALU_OPX_XOR: begin // XOR
					RESULT = ARGA ^ ARGB;
					end
					
				`ALU_OPX_SL: begin // SL
					{CARRY,RESULT} = ARGA << ARGB;
					end
					
				`ALU_OPX_SR: begin // SR
					RESULT = ARGA >> ARGB;
					end
					
				`ALU_OPX_SRA: begin // SRA (arithmetic - keep the sign bit)
					RESULT = ARGA >>> ARGB;
					end
					
				`ALU_OPX_ROT: begin // ROT (rotate right circular)
					RESULT = (ARGA << (16 - ARGB)) | (ARGA >> ARGB);
					end
					
				`ALU_OPX_BIT: begin // BIT
					RESULT = ARGA & (1 << ARGB);
					end
					
				`ALU_OPX_SET: begin // SET
					RESULT = ARGA | (1 << ARGB);
					end
					
				`ALU_OPX_CLR: begin // CLR
					RESULT = ARGA & ~(1 << ARGB);
					end
					
				`ALU_OPX_CMP: begin // CMP just a SUB, but no write-back of the result
					RESULT = ARGA - ARGB;
					arithmetic = 1;
					end
					
				`ALU_OPX_SEX: begin // SEX - sign-extend Ra from the bit-position in Rb
					sex = |(ARGA & (1 << ARGB));
					tmp = 16'hffff << ARGB;
					if(sex) begin
						RESULT = ARGA | tmp;
					end else begin
						RESULT = ARGA & ~tmp;
					end
					
					arithmetic = 1;
					end
					
				default: begin
					RESULT = 16'b1111111111111111;
					end
				endcase
				
				ZERO = (RESULT == 0);
				SIGN = RESULT[15];
				OVFL = ARGA[15] & ARGB[15] & ~RESULT[15] | ~ARGA[15] & ~ARGB[15] & RESULT[15];
				if(mul) begin
					PARITY = | tmp;
				end else if(arithmetic) begin
					PARITY = OVFL;
				end else begin
					PARITY = RESULT[0];
				end			
			end
				
endmodule