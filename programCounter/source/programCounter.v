/**
* The program counter register and control logic
**/
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
module programCounter(
	input CLK,
	input RESET,
	input PC_BASEX,
	input CC_SIGN,
	input CC_CARRY,
	input CC_ZERO,
	input CC_PARITY,
	input [1:0] PC_OFFSETX,
	input [1:0] CC_SELECTX,
	input CC_INVERTX,
	input CC_APPLYX,
	input JMP_X,
	input COMMIT,
	
	input [15:0] PC_D,
	
	output wire [15:0] PC_A
);

reg[15:0] NEXT;
wire [15:0] ZERO;
wire [15:0] TWO;
wire [15:0] FOUR;
reg [15:0] OFFSET;
reg [15:0] BASE;
reg [15:0] SUM;
reg CC;

reg PC_LD;

assign ZERO = 16'h0000;
assign TWO  = 16'h0002;
assign FOUR = 16'h0004;

// CC multiplexer
always @(CC_SELECTX or CC_INVERTX or CC_APPLYX or JMP_X or COMMIT) begin
	case(CC_SELECTX)
		`CC_SELECTX_Z: 	CC = CC_INVERTX ? ~CC_ZERO   : CC_ZERO;
		`CC_SELECTX_C: 	CC = CC_INVERTX ? ~CC_CARRY  : CC_CARRY;
		`CC_SELECTX_S: 	CC = CC_INVERTX ? ~CC_SIGN   : CC_SIGN;
		`CC_SELECTX_P: 	CC = CC_INVERTX ? ~CC_PARITY : CC_PARITY;
	endcase
	
	if(COMMIT && JMP_X) begin
		PC_LD = CC | ~CC_APPLYX;
	end else begin
		PC_LD = 0;
	end
end


// the register
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		NEXT <= 16'h0000;
	end else begin
		NEXT <= SUM;
	end
end

assign PC_A = NEXT;

// The base multiplexer
always @(PC_BASEX) begin
	if(PC_BASEX == `BC_BASEX_PC) begin
		BASE = PC_A;
	end else begin
		BASE = ZERO;
	end
end

// The offset multiplexer
always @(PC_OFFSETX) begin
	case(PC_OFFSETX)
		`PC_OFFSETX_D: OFFSET = PC_D;
		`PC_OFFSETX_TWO: OFFSET = TWO;
		`PC_OFFSETX_FOUR: OFFSET = FOUR;
		default: OFFSET = PC_D;
	endcase
end

endmodule