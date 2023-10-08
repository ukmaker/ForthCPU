`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module interruptStateMachine(
	
	input CLK,
	input RESET,
	input COMMIT,
	
	input RETIX,
	input EIX,
	input DIX,
	input INT0,
	input INT1,
	
	output reg [2:0] PC_NEXTX,
	output reg PC_LD_INT0,
	output reg PC_LD_INT1
);

reg EI;
reg EI_NEXT;
reg [2:0] STATE;
reg [2:0] STATE_NEXT;
reg [2:0] PC_NEXTX_NEXT;
reg PC_LD_INT0_NEXT;
reg PC_LD_INT1_NEXT;
	
always @(*) begin
	// defaults
	EI_NEXT = EI;
	STATE_NEXT = STATE;
	PC_NEXTX_NEXT = PC_NEXTX;
	PC_LD_INT0_NEXT = 0;
	PC_LD_INT1_NEXT = 0;

	if(INT0 == 0 & INT1 == 0) begin
		// Process instructions
		if(EIX) begin
			EI_NEXT = 1;
		end else if(DIX) begin
			EI_NEXT = 0;
		end else if(RETIX) begin
			case(STATE)
				`INT_STATE_RUN: begin
				end
				
				`INT_STATE_RI0: begin
					PC_NEXTX_NEXT = `PC_NEXTX_INTR0;
					STATE_NEXT    = `INT_STATE_RUN;
				end
				
				`INT_STATE_RI1: begin
					PC_NEXTX_NEXT = `PC_NEXTX_INTR1;
					STATE_NEXT    = `INT_STATE_RUN;
				end
					
				`INT_STATE_RI1_0: begin
					PC_NEXTX_NEXT = `PC_NEXTX_INTR0;
					STATE_NEXT    = `INT_STATE_RI1;
				end
			endcase
		end
	end else if(INT0) begin
		case(STATE)
			`INT_STATE_RUN: begin
				PC_NEXTX_NEXT = `PC_NEXTX_INTV0;
				STATE_NEXT    = `INT_STATE_RI0;
				PC_LD_INT0_NEXT = 1;
			end
			
			`INT_STATE_RI0: begin
			end
			
			`INT_STATE_RI1: begin
				PC_NEXTX_NEXT = `PC_NEXTX_INTV0;
				STATE_NEXT    = `INT_STATE_RI1_0;
				PC_LD_INT0_NEXT    = 1;
			end
				
			`INT_STATE_RI1_0: begin
			end
		endcase
	end else if(EI & INT1) begin
		case(STATE)
			`INT_STATE_RUN: begin
				PC_NEXTX_NEXT = `PC_NEXTX_INTV1;
				STATE_NEXT    = `INT_STATE_RI1;
				PC_LD_INT1_NEXT = 1;
			end
			
			`INT_STATE_RI0: begin
			end
			
			`INT_STATE_RI1: begin
			end
				
			`INT_STATE_RI1_0: begin
			end
		endcase
	end
end


	
always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
		STATE <= `INT_STATE_RUN;
		PC_NEXTX <= `PC_NEXTX_NEXT;
		PC_LD_INT0 <= 0;
		PC_LD_INT1 <= 0;
		EI = 0;
	end else begin
		STATE <= STATE_NEXT;
		PC_NEXTX <= PC_NEXTX_NEXT;
		EI = EI_NEXT;
	end
end

endmodule