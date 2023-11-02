/**
* The program counter register and control logic
* Input multiplexers feed an adder to calculate the next address
* - PC+2
* - Jump relative or absolute
* Two registers save the next address when an interrupt occurs
* Memory address latched from the next address or one of two interrupt vectors
* INT0 = 0x0004 ; Highest priority
* INT1 = 0x0008
*
* Reset address is 0x0000
* each vector should contain a jump instruction
**/
`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
module programCounter(
	input CLK,
	input RESET,
	input FETCH,
	input DECODE,
	input PC_ENX,
	
	input PC_LD_INT0X,
	input PC_LD_INT1X,
	input [1:0] PC_BASEX,
	input [1:0] PC_OFFSETX,
	
	input [15:0] REGB_DOUT,
	input [15:0] DIN,
	input [2:0]  PC_NEXTX,
	
	output reg [15:0] HERE,
	output reg [15:0] PC_A_NEXT,
	output reg [15:0] PC_A
);

// Internal wiring
reg [15:0] ARGA;
reg [15:0] ARGB;
reg [15:0] SUM;
reg [15:0] INTR0;
reg [15:0] INTR1;
wire [15:0] ZERO = 16'h0000;
wire [15:0] TWO  = 16'h0002;
wire [15:0] FOUR  = 16'h0004;
reg [15:0] PC_NEXT;


// The input muxes and adder
always @(*) begin
	case(PC_OFFSETX)
		`PC_OFFSETX_0: ARGA = ZERO;
		`PC_OFFSETX_2: ARGA = TWO;
		`PC_OFFSETX_4: ARGA = FOUR;
		default:       ARGA = DIN;
	endcase
	
	case(PC_BASEX)
		`PC_BASEX_PC_A:      ARGB = PC_A;
		`PC_BASEX_REGB_DOUT: ARGB = REGB_DOUT;
		`PC_BASEX_0:         ARGB = ZERO;
 		default:             ARGB = PC_A;
	endcase

	SUM = ARGA + ARGB;
end

// The next address mux
always @(*) begin
	case(PC_NEXTX) 
		`PC_NEXTX_NEXT:  PC_NEXT = SUM;
		`PC_NEXTX_INTV0: PC_NEXT = `INTV0;
		`PC_NEXTX_INTV1: PC_NEXT = `INTV1;
		`PC_NEXTX_INTR0: PC_NEXT = INTR0;
		`PC_NEXTX_INTR1: PC_NEXT = INTR1;
		default:         PC_NEXT = SUM;
	endcase
	
	PC_A_NEXT = SUM;
end

// The INT0 register
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		INTR0 <= 16'h0000;
	end else if(PC_LD_INT0X & FETCH) begin
		INTR0 <= SUM;
	end
end

// The INT1 register
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		INTR1 <= 16'h0000;
	end else if(PC_LD_INT1X & FETCH) begin
		INTR1 <= SUM;
	end
end

// The HERE register
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		HERE <= 16'h0000;
	end else if(PC_ENX & DECODE) begin
		HERE <= SUM;
	end
end

// the PC register
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		PC_A <= 16'h0000;
	end else if(PC_ENX & FETCH) begin
		PC_A <= PC_NEXT;
	end
end

endmodule