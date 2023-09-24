/**
* The program counter register and control logic
**/
`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
module programCounter(
	input CLK,
	input RESET,
	input PC_EN,
	input COMMIT,
	input [15:0] PC_D,
	input JRX,
	
	input CC_SIGN,
	input CC_CARRY,
	input CC_ZERO,
	input CC_PARITY,

	input [1:0] CC_SELECTX,
	input CC_INVERTX,
	input CC_APPLYX,
	input JMPX,
	
	output reg [15:0] PC_A
);

reg[15:0] NEXT;
wire [15:0] TWO;
reg [15:0] SUM;
reg [15:0] OFFSET;
reg CC;
reg DOJMP;

reg OFFSET_SEL;
reg NEXT_SEL;

assign TWO  = 16'h0002;

// CC multiplexer
always @(*) begin
	case(CC_SELECTX)
		`CC_SELECTX_Z: 	CC = CC_INVERTX ? ~CC_ZERO   : CC_ZERO;
		`CC_SELECTX_C: 	CC = CC_INVERTX ? ~CC_CARRY  : CC_CARRY;
		`CC_SELECTX_S: 	CC = CC_INVERTX ? ~CC_SIGN   : CC_SIGN;
		`CC_SELECTX_P: 	CC = CC_INVERTX ? ~CC_PARITY : CC_PARITY;
	endcase
	
	DOJMP = (CC & CC_APPLYX) | JMPX;
	OFFSET_SEL = DOJMP & JRX;
	NEXT_SEL   = DOJMP & ~JRX;

// NEXT mux
	OFFSET = OFFSET_SEL ? PC_D : TWO;
	SUM    = OFFSET + PC_A;
	NEXT   = NEXT_SEL ? PC_D : SUM;
end


// the register
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		PC_A <= 16'h0000;
	end else if(PC_EN & COMMIT) begin
		PC_A <= NEXT;
	end

end

//assign 	PC_A = PC_EN ? PC_A_NEXT : PC_A;

endmodule