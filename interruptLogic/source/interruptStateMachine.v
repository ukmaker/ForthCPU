`include "../../constants.v"

/*******************************************************
* Keeps track of the processor's privileged INT states.
*
* On entry to an interrupt handler:
* - saves the PC value which would have been executed
* - completes and saves the CC state in the currently 
*   active CC register
* - switches the active CC register
*
* On return from an interrupt handler (RETI)
* - reloads the PC from the active INTPC register
* - switches the active CC register
**/

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
	output reg PC_LD_INT0X,
	output reg PC_LD_INT1X,
	
	output reg CCL_ENRX,
	output reg CCL_EN0X,
	output reg CCL_EN1X,
	output reg [1:0] CC_REGX
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
			// CC source is the normal register
			CC_REGX = `CC_REGX_RUN;
			// and capture new CCs
			CCL_ENRX = 1;
			CCL_EN0X = 0;
			CCL_EN1X = 0;
		end
		
		`INT_STATE_VEC0: begin
			STATE_NEXT = `INT_STATE_RUN0;
			// CC source is the INT0 register
			CC_REGX = `CC_REGX_INT0;
			// and capture new CCs into it
			CCL_ENRX = 0;
			CCL_EN0X = 1;
			CCL_EN1X = 0;
		end
		
		`INT_STATE_VEC1: begin
			// allow INT0 to override
			if(INT0) begin
				STATE_NEXT = `INT_STATE_VEC1_0;
			end else begin
				STATE_NEXT = `INT_STATE_RUN1;
			end
			// CC source is the INT1 register
			CC_REGX = `CC_REGX_INT1;
			// and capture new CCs into it
			CCL_ENRX = 0;
			CCL_EN0X = 0;
			CCL_EN1X = 1;
		end
		
		`INT_STATE_VEC1_0: begin
			STATE_NEXT = `INT_STATE_RUN1_0;
			// CC source is the INT0 register
			CC_REGX = `CC_REGX_INT0;
			// and capture new CCs into it
			CCL_ENRX = 0;
			CCL_EN0X = 1;
			CCL_EN1X = 0;
		end
		
		`INT_STATE_RUN0: begin
			if(RETIX) begin
				STATE_NEXT = `INT_STATE_RETI0;
			end else begin
				STATE_NEXT = `INT_STATE_RUN0;
			end
			// CC source is the INT0 register
			CC_REGX = `CC_REGX_INT0;
			// and capture new CCs into it
			CCL_ENRX = 0;
			CCL_EN0X = 1;
			CCL_EN1X = 0;
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
			// CC source is the INT1 register
			CC_REGX = `CC_REGX_INT1;
			// and capture new CCs into it
			CCL_ENRX = 0;
			CCL_EN0X = 0;
			CCL_EN1X = 1;
		end
		
		`INT_STATE_RUN1_0: begin
			if(RETIX) begin
				STATE_NEXT = `INT_STATE_RETI1_0;
			end else begin
				STATE_NEXT = `INT_STATE_RUN1_0;
			end
			// CC source is the INT0 register
			CC_REGX = `CC_REGX_INT0;
			// and capture new CCs into it
			CCL_ENRX = 0;
			CCL_EN0X = 1;
			CCL_EN1X = 0;
		end
		
		`INT_STATE_RETI0: begin
			STATE_NEXT = `INT_STATE_RUN;
			// CC source is the INT0 register
			CC_REGX = `CC_REGX_INT0;
			// and capture new CCs into it
			CCL_ENRX = 0;
			CCL_EN0X = 1;
			CCL_EN1X = 0;
		end
		
		`INT_STATE_RETI1: begin
			if(INT0) begin
				STATE_NEXT = `INT_STATE_VEC0;
			end else begin
				STATE_NEXT = `INT_STATE_RUN;
			end
			// CC source is the INT1 register
			CC_REGX = `CC_REGX_INT1;
			// and capture new CCs into it
			CCL_ENRX = 0;
			CCL_EN0X = 0;
			CCL_EN1X = 1;
		end
		
		`INT_STATE_RETI1_0: begin
			STATE_NEXT = `INT_STATE_RUN1;
			// CC source is the INT0 register
			CC_REGX = `CC_REGX_INT0;
			// and capture new CCs into it
			CCL_ENRX = 0;
			CCL_EN0X = 1;
			CCL_EN1X = 0;
		end
		
		default: begin
			STATE_NEXT = `INT_STATE_RUN;
			// CC source is the normal register
			CC_REGX = `CC_REGX_RUN;
			// and capture new CCs
			CCL_ENRX = 1;
			CCL_EN0X = 0;
			CCL_EN1X = 0;
		end
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
		PC_LD_INT0X <= 0;
		PC_LD_INT1X <= 0;
		EI <= 0;
	end else if(COMMIT) begin
		STATE <= STATE_NEXT;
		PC_NEXTX <= PC_NEXTX_NEXT;
		PC_LD_INT0X <= PC_LD_INT0_NEXT;
		PC_LD_INT1X <= PC_LD_INT1_NEXT;
		if(EIX) begin
			EI <= 1;
		end else if(DIX) begin
			EI <= 0;
		end
	end
end

endmodule