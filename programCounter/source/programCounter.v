/**
* The program counter register and control logic
**/
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
module programCounter(
	input CLK,
	input PC_RESETX,
	input [1:0] PC_OPX,
	input [15:0] PC_D,
	
	output reg [15:0] PC_A
);

reg[15:0] next;


always @ (posedge CLK) begin
	
	next = PC_A;
	
	if(PC_RESETX) begin
		next = 0;
	end else begin
		
		case(PC_OPX)
			`PC_OP_NOP: begin
				// nothing
			end
			
			`PC_OP_NEXT: begin
				next = PC_A + 16'b0000000000000010;
			end
			
			`PC_OP_SKIP: begin
				next = PC_A +  16'b0000000000000100;
			end
			
			`PC_OP_LD: begin
				next = PC_D;
			end
		endcase
	end
	
	PC_A = next;
end

endmodule