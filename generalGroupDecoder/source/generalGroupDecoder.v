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
	input [3:0] INSTRUCTION_OP,
	
	output reg EIX,
	output reg DIX,
	output reg RETIX,
	output reg HALTX
);

reg EI, DI, RETI, HALT;


always @(*) begin
	case(INSTRUCTION_OP)
		`GEN_OP_HALT: HALT = 1;
		`GEN_OP_EI:   EI = 1;
		`GEN_OP_DI:   DI = 1;
		`GEN_OP_RETI: RETI = 1;
		default: begin
			EI = 0;
			DI = 0;
			RETI = 0;
			HALT = 0;
		end
	endcase
end

always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
		HALTX <= 0;
		EIX <= 0;
		DIX <= 0;
		RETIX <= 0;
	end else if(EXECUTE) begin
		EIX <= EI;
		DIX <= DI;
		RETIX <= RETI;
	end else if(COMMIT) begin
		HALTX <= HALT;
	end
end
		

endmodule