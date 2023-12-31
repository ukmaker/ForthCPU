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
	input COMMIT,
	input DECODE,
	input PC_ENX,
	
	input PC_LD_INT0X,
	input PC_LD_INT1X,
	input [1:0] PC_BASEX,
	input [1:0] PC_OFFSETX,
	
	input DEBUG_LD_BKP_EN,
	input DEBUG_EN_BKPX,
	input [15:0] DIN_BKP,
	output reg DEBUG_AT_BKP,
	
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
reg [15:0] BKP_ADDR;
reg BKP_ACTIVE;
wire [15:0] ZERO = 16'h0000;
wire [15:0] TWO  = 16'h0002;
wire [15:0] FOUR  = 16'h0004;


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
		`PC_NEXTX_NEXT:  PC_A_NEXT = SUM;
		`PC_NEXTX_INTV0: PC_A_NEXT = `INTV0;
		`PC_NEXTX_INTV1: PC_A_NEXT = `INTV1;
		`PC_NEXTX_INTR0: PC_A_NEXT = INTR0;
		`PC_NEXTX_INTR1: PC_A_NEXT = INTR1;
		default:         PC_A_NEXT = SUM;
	endcase
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
	end else if(PC_ENX & FETCH) begin
		HERE <= PC_A_NEXT + 2;
	end
end

// the PC register
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		PC_A <= 16'hfffe;
	end else if(PC_ENX & FETCH) begin
		PC_A <= PC_A_NEXT;
	end
end

// The breakpoint register
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		BKP_ADDR <= 16'h0000;
		BKP_ACTIVE <= 0;
	end else if(DEBUG_LD_BKP_EN) begin
		BKP_ADDR <= DIN_BKP;
		BKP_ACTIVE <= DEBUG_EN_BKPX;
	end
end

// The breakpoint
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		DEBUG_AT_BKP <= 0;
	end else if(BKP_ACTIVE & COMMIT) begin
		if(PC_A_NEXT == BKP_ADDR) begin
			DEBUG_AT_BKP <= 1;
		end else begin
			DEBUG_AT_BKP <= 0;
		end
	end
end


endmodule