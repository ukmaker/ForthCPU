`timescale 1 ns / 1 ns

module testbench;

	parameter CLOCK_CYCLE = 10;
		reg [15:0] arga;
		reg [15:0] argb;
		reg [4:0] opcode;
		wire [15:0] result;
		wire carry;
		wire zero;
		wire parity;
		wire sign;


	alu alu_inst(.ALUX(opcode), .ARGA(arga), .ARGB(argb), .RESULT(result), .SIGN(sign), .CARRY(carry), .ZERO(zero), .PARITY(parity));
	
	initial begin
		opcode = 5'b00000;
		arga = 16'b0000000000000000;
		argb = 16'b0000000000000000;
	end

	// 100MHz clock generation 


	initial begin		
		#(10*CLOCK_CYCLE);
		#(CLOCK_CYCLE);
			opcode = 5'b00000; // MOV
			arga = 16'b0101010110101010;
			argb = 16'b1010101010101010;	
		#(10*CLOCK_CYCLE);
			opcode = 5'b00001; // ADD
		
		#(10*CLOCK_CYCLE);
			opcode = 5'b00010; // SUB
		
		#(10*CLOCK_CYCLE);
			opcode = 5'b00011; // MUL
		
		#(10*CLOCK_CYCLE);
			opcode = 5'b00100; // OR
		
		#(10*CLOCK_CYCLE);
			opcode = 5'b00101; // AND
		
		#(10*CLOCK_CYCLE);
			opcode = 5'b00110; // XOR
		
		#(10*CLOCK_CYCLE);
			arga = 16'b1000000100100011;
			argb = 16'b0000000000000011;
			opcode = 5'b00111; // SL
		
		#(10*CLOCK_CYCLE);
			opcode = 5'b01000; // SR
		
		#(10*CLOCK_CYCLE);
			opcode = 5'b01001; // SRA
		
		#(10*CLOCK_CYCLE);
			opcode = 5'b01010; // ROT
		
		#(10*CLOCK_CYCLE);
			opcode = 5'b01011; // BIT
		
		#(10*CLOCK_CYCLE);
			opcode = 5'b01100; // SET
		
		#(10*CLOCK_CYCLE);
			opcode = 5'b01101; // CLR
		
		#(10*CLOCK_CYCLE);
			opcode = 5'b01110; // CMP
		
		#(10*CLOCK_CYCLE);
			argb = 16'b0000000000000101;
			opcode = 5'b01111; // SEX
		
		#(500*CLOCK_CYCLE) $finish;
	end
	
endmodule