`include "../../constants.v"

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
reg [3:0] STATE;
reg [3:0] STATE_NEXT;
reg [2:0] PC_NEXTX_NEXT;
reg PC_LD_INT0_NEXT;
reg PC_LD_INT1_NEXT;
	
always @(*) begin
	
	case(STATE)
		`INT_STATE_RUN: begin
			// INT0 takes precedence
			if(INT0) begin
				STATE_NEXT = `INT_STATE_VEC0;
			end else if(EI & INT1) begin
				STATE_NEXT = `INT_STATE_VEC1;
			end else begin
				STATE_NEXT = `INT_STATE_RUN;
			end
		end
		
		`INT_STATE_VEC0: begin
			STATE_NEXT = `INT_STATE_RUN0;
		end
		`INT_STATE_VEC1: begin
			// allow INT0 to override
			if(INT0) begin
				STATE_NEXT = `INT_STATE_VEC1_0;
			end else begin
				STATE_NEXT = `INT_STATE_RUN1;
			end
		end
		`INT_STATE_VEC1_0: begin
			STATE_NEXT = `INT_STATE_RUN1_0;
		end
		
		`INT_STATE_RUN0: begin
			if(RETIX) begin
				STATE_NEXT = `INT_STATE_RETI0;
			end else begin
				STATE_NEXT = `INT_STATE_RUN0;
			end
		end
		`INT_STATE_RUN1: begin
			// INT0 takes precedence
			if(INT0) begin
				STATE_NEXT = `INT_STATE_VEC1_0;
			end else begin
				if(RETIX) begin
					STATE_NEXT = `INT_STATE_RETI1;
				end else begin
					STATE_NEXT = `INT_STATE_RUN1;
				end
			end
		end
		`INT_STATE_RUN1_0: begin
			if(RETIX) begin
				STATE_NEXT = `INT_STATE_RETI1_0;
			end else begin
				STATE_NEXT = `INT_STATE_RUN1_0;
			end
		end
		
		`INT_STATE_RETI0: begin
			STATE_NEXT = `INT_STATE_RUN;
		end
		
		`INT_STATE_RETI1: begin
			if(INT0) begin
				STATE_NEXT = `INT_STATE_VEC0;
			end else begin
				STATE_NEXT = `INT_STATE_RUN;
			end
		end
		
		`INT_STATE_RETI1_0: begin
			STATE_NEXT = `INT_STATE_RUN1;
		end
		
		default:
			STATE_NEXT = `INT_STATE_RUN;
	endcase
	
	case(STATE_NEXT)
		`INT_STATE_RUN: begin
			PC_LD_INT0_NEXT = 0;
			PC_LD_INT1_NEXT = 0;
			PC_NEXTX_NEXT = `PC_NEXTX_NEXT;
		end

		`INT_STATE_VEC0: begin
			PC_LD_INT0_NEXT = 1;
			PC_LD_INT1_NEXT = 0;
			PC_NEXTX_NEXT = `PC_NEXTX_INTV0;
		end

		`INT_STATE_VEC1: begin
			PC_LD_INT0_NEXT = 0;
			PC_LD_INT1_NEXT = 1;
			PC_NEXTX_NEXT = `PC_NEXTX_INTV1;
		end

		`INT_STATE_VEC1_0: begin
			PC_LD_INT0_NEXT = 1;
			PC_LD_INT1_NEXT = 0;
			PC_NEXTX_NEXT = `PC_NEXTX_INTV0;
		end

		`INT_STATE_RUN0: begin
			PC_LD_INT0_NEXT = 0;
			PC_LD_INT1_NEXT = 0;
			PC_NEXTX_NEXT = `PC_NEXTX_NEXT;
		end

		`INT_STATE_RUN1: begin
			PC_LD_INT0_NEXT = 0;
			PC_LD_INT1_NEXT = 0;
			PC_NEXTX_NEXT = `PC_NEXTX_NEXT;
		end

		`INT_STATE_RUN1_0: begin
			PC_LD_INT0_NEXT = 0;
			PC_LD_INT1_NEXT = 0;
			PC_NEXTX_NEXT = `PC_NEXTX_NEXT;
		end

		`INT_STATE_RETI0: begin
			PC_LD_INT0_NEXT = 0;
			PC_LD_INT1_NEXT = 0;
			PC_NEXTX_NEXT = `PC_NEXTX_INTR0;
		end

		`INT_STATE_RETI1: begin
			PC_LD_INT0_NEXT = 0;
			PC_LD_INT1_NEXT = 0;
			PC_NEXTX_NEXT = `PC_NEXTX_INTR1;
		end

		`INT_STATE_RETI1_0: begin
			PC_LD_INT0_NEXT = 0;
			PC_LD_INT1_NEXT = 0;
			PC_NEXTX_NEXT = `PC_NEXTX_INTR0;
		end

		default: begin
			PC_LD_INT0_NEXT = 0;
			PC_LD_INT1_NEXT = 0;
			PC_NEXTX_NEXT = `PC_NEXTX_NEXT;
		end
	endcase
end


	
always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
		STATE <= `INT_STATE_RUN;
		PC_NEXTX <= `PC_NEXTX_NEXT;
		PC_LD_INT0 <= 0;
		PC_LD_INT1 <= 0;
		EI <= 0;
	end else if(COMMIT) begin
		STATE <= STATE_NEXT;
		PC_NEXTX <= PC_NEXTX_NEXT;
		PC_LD_INT0 <= PC_LD_INT0_NEXT;
		PC_LD_INT1 <= PC_LD_INT1_NEXT;
		if(EIX) begin
			EI <= 1;
		end else if(DIX) begin
			EI <= 0;
		end
	end
end

endmodule