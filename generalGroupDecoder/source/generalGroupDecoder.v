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
	input FETCH, DECODE, EXECUTE, COMMIT,
	input [15:0] INSTRUCTION,
	
	output reg EIX,
	output reg DIX,
	output reg RETIX,
	output reg PC_ENX
);

wire [1:0] GROUP;
wire [2:0] OP;

reg EI, DI, RETI, HALT;

assign GROUP = INSTRUCTION[15:14];
assign OP    = INSTRUCTION[10:8];

always @(posedge CLK or posedge RESET) begin
	EI   = 0;
	DI   = 0;
	RETI = 0;
	HALT = 0;
	
	if(RESET) begin
		PC_ENX <= 1;
		EIX <= 0;
		DIX <= 0;
		RETIX <= 0;
	end else if(GROUP == 2'b00) begin
		case(OP)
			`GEN_OP_HALT: HALT = 1;
			`GEN_OP_EI:   EI = 1;
			`GEN_OP_DI:   DI = 1;
			`GEN_OP_RETI: RETI = 1;
		endcase
	end
	
	EIX <= EI;
	DIX <= DI;
	if(COMMIT) PC_ENX <= ~HALT;
	RETIX <= RETI;
end
		

endmodule