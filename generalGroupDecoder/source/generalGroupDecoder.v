`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/**
* Decode the general instructions
*
* EI
* DI
* RETI
* HALT
**/

module generalGroupDecoder(
	
	input CLK,
	input RESET,
	input EXECUTE, COMMIT,
	input [1:0] INSTRUCTION_GROUP,
	input [2:0] INSTRUCTION_OP,
	
	output reg EIX,
	output reg DIX,
	output reg RETIX,
	output reg PC_ENX
);

reg GEN, EI, DI, RETI, HALT;


always @(*) begin
	// decode the instruction
	GEN = 0;
	EI = 0;
	DI = 0;
	RETI = 0;
	HALT = 0;
	
	if(INSTRUCTION_GROUP == 2'b00) begin
		GEN = 1;
		case(INSTRUCTION_OP)
			`GEN_OP_HALT: HALT = 1;
			`GEN_OP_EI:   EI = 1;
			`GEN_OP_DI:   DI = 1;
			`GEN_OP_RETI: RETI = 1;
		endcase
	end
end

always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
		PC_ENX <= 1;
		EIX <= 0;
		DIX <= 0;
		RETIX <= 0;
	end else if(EXECUTE) begin
		EIX <= EI;
		DIX <= DI;
		RETIX <= RETI;
	end else if(COMMIT) begin
		PC_ENX <= ~HALT;
	end
end
		

endmodule