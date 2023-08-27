module alu(
	input [4:0] OPCODE,
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
			
			case (OPCODE[4:0])
				5'b00000: begin // MOV group. Output copies port B
					RESULT = ARGB;
					end
					
				5'b00001: begin // ADD group. Output is A+B
					{CARRY,RESULT} = ARGA + ARGB;
					arithmetic = 1;
					end
					
				5'b00010: begin // SUB
					{CARRY,RESULT} = ARGA - ARGB;
					arithmetic = 1;
					end
					
				5'b00011: begin // MUL
					arithmetic = 1;
					{tmp,RESULT} = ARGA * ARGB;
					OVFL = | tmp;
					end
					
				5'b00100: begin // OR
					RESULT = ARGA | ARGB;
					end
					
				5'b00101: begin // AND
					RESULT = ARGA & ARGB;
					end
					
				5'b00110: begin // XOR
					RESULT = ARGA ^ ARGB;
					end
					
				5'b00111: begin // SL
					{CARRY,RESULT} = ARGA << ARGB;
					end
					
				5'b01000: begin // SR
					RESULT = ARGA >> ARGB;
					end
					
				5'b01001: begin // SRA (arithmetic - keep the sign bit)
					RESULT = ARGA >>> ARGB;
					end
					
				5'b01010: begin // ROT (rotate right circular)
					RESULT = {ARGA,ARGA} >> ARGB;
					end
					
				5'b01011: begin // BIT
					RESULT = ARGA & (1 << ARGB);
					end
					
				5'b01100: begin // SET
					RESULT = ARGA | (1 << ARGB);
					end
					
				5'b01101: begin // CLR
					RESULT = ARGA & ~(1 << ARGB);
					end
					
				5'b01110: begin // CMP just a SUB, but no write-back of the result
					RESULT = ARGA - ARGB;
					arithmetic = 1;
					end
					
				5'b01111: begin // SEX - sign-extend Ra from the bit-position in Rb
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