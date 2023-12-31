`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module addressBusController(
	input CLK, 
	input RESET,	
	input FETCH, 
	input DECODE, 
	input BYTEX,
	
	input [15:0] PC_A,
	input [15:0] ALU_R,
	input [15:0] ALUB_DATA,
	input [15:0] HERE,
	input [15:0] DEBUG_ADDR,
	
	input [2:0] ADDR_BUSX,

	input DEBUG_MODE_DEBUG,

	output reg [15:0] ADDR,
	
	output HIGH_BYTEX
);

reg [2:0] ADDR_BUSX_R;

assign HIGH_BYTEX = ADDR[0] & BYTEX;

// During FETCH and DECODE 
// ADDR_BUSX should be set to
// PC_A normally
// DEBUG_ADDR if debugging is active
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		ADDR_BUSX_R = DEBUG_MODE_DEBUG ? `ADDR_BUSX_DEBUG : `ADDR_BUSX_PC_A;
	end else begin
		if(FETCH | DECODE) begin
			ADDR_BUSX_R = DEBUG_MODE_DEBUG ? `ADDR_BUSX_DEBUG : `ADDR_BUSX_PC_A;
		end else begin
			ADDR_BUSX_R = ADDR_BUSX;
		end
	end
end
		
always @(*) begin
	case(ADDR_BUSX_R)
		`ADDR_BUSX_PC_A:      ADDR = PC_A;
		`ADDR_BUSX_ALU_R:     ADDR = ALU_R;
		`ADDR_BUSX_ALUB_DATA: ADDR = ALUB_DATA;
		`ADDR_BUSX_HERE:      ADDR = HERE;
		`ADDR_BUSX_DEBUG:     ADDR = DEBUG_ADDR;
		default:              ADDR = ALUB_DATA;
	endcase
end
	
endmodule