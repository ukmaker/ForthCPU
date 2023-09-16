module alu(
	input [3:0] ALUX,
	input signed [15:0] ARGA,
	input signed [15:0] ARGB,
	
	output reg[15:0] RESULT,
	
	output reg SIGN,
	output reg CARRY,
	output reg ZERO,
	output reg PARITY
	

);

reg arithmetic;
reg sex;

reg OVFL;

wire [31:0] w_result;
reg [15:0] tmp;
	
always @ (*)
	
		begin
			arithmetic = 0;
			
			case (ALUX[3:0])
				5'b0000: begin // MOV group. Output copies port B
					RESULT = ARGB;
					end
					
				5'b0001: begin // ADD group. Output is A+B
					{CARRY,RESULT} = ARGA + ARGB;
					arithmetic = 1;
					end
					
				5'b0010: begin // SUB
					{CARRY,RESULT} = ARGA - ARGB;
					arithmetic = 1;
					end
					
				5'b0011: begin // MUL
					arithmetic = 1;
					{tmp,RESULT} = ARGA * ARGB;
					OVFL = | tmp;
					end
					
				5'b0100: begin // OR
					RESULT = ARGA | ARGB;
					end
					
				5'b0101: begin // AND
					RESULT = ARGA & ARGB;
					end
					
				5'b0110: begin // XOR
					RESULT = ARGA ^ ARGB;
					end
					
				5'b0111: begin // SL
					{CARRY,RESULT} = ARGA << ARGB;
					end
					
				5'b1000: begin // SR
					RESULT = ARGA >> ARGB;
					end
					
				5'b1001: begin // SRA (arithmetic - keep the sign bit)
					RESULT = ARGA >>> ARGB;
					end
					
				5'b1010: begin // ROT (rotate right circular)
					RESULT = {ARGA,ARGA} >> ARGB;
					end
					
				5'b1011: begin // BIT
					RESULT = ARGA & (1 << ARGB);
					end
					
				5'b1100: begin // SET
					RESULT = ARGA | (1 << ARGB);
					end
					
				5'b1101: begin // CLR
					RESULT = ARGA & ~(1 << ARGB);
					end
					
				5'b1110: begin // CMP just a SUB, but no write-back of the result
					RESULT = ARGA - ARGB;
					arithmetic = 1;
					end
					
				5'b1111: begin // SEX - sign-extend Ra from the bit-position in Rb
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
				if(arithmetic) begin
					PARITY = OVFL;
				end else begin
					PARITY = RESULT[0];
				end
				
			end
				
endmodule