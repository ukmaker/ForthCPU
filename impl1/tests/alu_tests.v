`timescale 1 ns / 1 ns

module alu_tests;

	parameter CLOCK_CYCLE = 10;
		reg [15:0] arga;
		reg [15:0] argb;
		reg [3:0] opcode;
		wire [15:0] result;
		wire carry;
		wire zero;
		wire parity;
		wire sign;


	alu alu_inst(.ALUX(opcode), .ARGA(arga), .ARGB(argb), .RESULT(result), .SIGN(sign), .CARRY(carry), .ZERO(zero), .PARITY(parity));
	
	initial begin
		opcode = 4'b0000;
		arga = 16'b0000000000000000;
		argb = 16'b0000000000000000;
	end

	// 100MHz clock generation 


	initial begin		
		#(10*CLOCK_CYCLE);
		#(CLOCK_CYCLE);
			opcode = 4'b0000; // MOV
			arga = 16'b0101010110101010;
			argb = 16'b1010101010101010;	
		#(10*CLOCK_CYCLE);
			opcode = 4'b0001; // ADD
		
		#(10*CLOCK_CYCLE);
			opcode = 4'b0010; // SUB
		
		#(10*CLOCK_CYCLE);
			opcode = 4'b0011; // MUL
		
		#(10*CLOCK_CYCLE);
			opcode = 4'b0100; // OR
		
		#(10*CLOCK_CYCLE);
			opcode = 4'b0101; // AND
		
		#(10*CLOCK_CYCLE);
			opcode = 4'b0110; // XOR
		
		#(10*CLOCK_CYCLE);
			arga = 16'b1000000100100011;
			argb = 16'b0000000000000011;
			opcode = 4'b0111; // SL
		
		#(10*CLOCK_CYCLE);
			opcode = 4'b1000; // SR
		
		#(10*CLOCK_CYCLE);
			opcode = 4'b1001; // SRA
		
		#(10*CLOCK_CYCLE);
			opcode = 4'b1010; // ROT
		
		#(10*CLOCK_CYCLE);
			opcode = 4'b1011; // BIT
		
		#(10*CLOCK_CYCLE);
			opcode = 4'b1100; // SET
		
		#(10*CLOCK_CYCLE);
			opcode = 4'b1101; // CLR
		
		#(10*CLOCK_CYCLE);
			opcode = 4'b1110; // CMP
		
		#(10*CLOCK_CYCLE);
			argb = 16'b0000000000000101;
			opcode = 4'b1111; // SEX
		
		#(500*CLOCK_CYCLE) $finish;
	end
	
endmodule