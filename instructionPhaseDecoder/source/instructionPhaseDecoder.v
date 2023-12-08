`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`timescale 1 ns / 1 ns

/********************************************************************************
* Provides phases to the sequencers
* Modes
* DEBUG_STOPX HALTED   Mode
*      0        1      HALTX   - clock and phases continue to run
*                              - PC_ENX <= 0
*      0        0      RUN     - normal run state
*                              - PC_ENX <= 1
*      1        x      STOPPED - phases halted on STOPPED
*                              - DEBUG_ACTIVE = 1
*                              - PC_ENX <= 0
*                              - A positive edge on DEBUG_STEP_REQ
*                              - should trigger a single full cycle
*							   - with DEBUG_ACTIVE
*							   - cycle terminated with a single DEBUG_ACK pulse					   
**********************************************************************************/
							  
module instructionPhaseDecoder(
	input               CLK,
	input               DEBUG_STOPX,
	input               DEBUG_STEP_REQ,
	input [15:0]       DIN,
	input               HALTX,
	input               RESET,
	
	output reg          COMMIT,
	output reg          DECODE,
	output reg          DEBUG_STEP_ACK,
	output reg          DEBUG_ACTIVE,
	output reg          EXECUTE,
	output reg          FETCH,
	output reg [15:0]  INSTRUCTION,
	output reg          PC_ENX,
	output reg          STOPPED
);

// Internal state
reg [3:0] PHASE_R;
reg [3:0] PHASE_NEXT;

wire DEBUG_ACTIVE_NEXT;

assign DEBUG_ACTIVE_NEXT = 
     PHASE_NEXT == `PHI_DEBUG_STOPPED 
  || PHASE_NEXT == `PHI_DEBUG_FETCH 
  || PHASE_NEXT == `PHI_DEBUG_DECODE 
  || PHASE_NEXT == `PHI_DEBUG_EXECUTE 
  || PHASE_NEXT == `PHI_DEBUG_COMMIT 
  || PHASE_NEXT == `PHI_DEBUG_ACK;

always @(*) begin
	case(PHASE_R)
		`PHI_STOPPED: begin
			if(DEBUG_STOPX) begin
				PHASE_NEXT = `PHI_DEBUG_STOPPED;
			end else if(!HALTX) begin
				PHASE_NEXT = `PHI_FETCH;
			end
		end
		
		`PHI_FETCH:   PHASE_NEXT = `PHI_DECODE;
		`PHI_DECODE:  PHASE_NEXT = `PHI_EXECUTE;
		`PHI_EXECUTE: PHASE_NEXT = `PHI_COMMIT;
		`PHI_COMMIT:  begin
			if(DEBUG_STOPX) begin
				PHASE_NEXT = `PHI_DEBUG_STOPPED;
			end else begin
				PHASE_NEXT = `PHI_FETCH;
			end
		end
		
		`PHI_DEBUG_STOPPED: begin
			if(DEBUG_STEP_REQ) begin
				PHASE_NEXT = `PHI_DEBUG_FETCH;
			end else if(!DEBUG_STOPX) begin
				PHASE_NEXT = `PHI_STOPPED;
			end
		end
		
		`PHI_DEBUG_FETCH:  PHASE_NEXT = `PHI_DEBUG_DECODE;
		`PHI_DEBUG_DECODE: PHASE_NEXT = `PHI_DEBUG_EXECUTE;
		`PHI_DEBUG_EXECUTE:PHASE_NEXT = `PHI_DEBUG_COMMIT;
		`PHI_DEBUG_COMMIT: PHASE_NEXT = `PHI_DEBUG_ACK;
		
		`PHI_DEBUG_ACK: begin
			// Wait for REQ to go low
			if(!DEBUG_STEP_REQ) begin
				PHASE_NEXT = `PHI_DEBUG_STOPPED;
			end
		end
		
		default: begin
			// shouldn't be possible
			PHASE_NEXT = `PHI_STOPPED;
		end
	endcase
end

/**************************
* Keep the PC running?
**************************/
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		PC_ENX <= 1;
		DEBUG_ACTIVE <= 0;
	end else begin
		PC_ENX <= ~HALTX;
	end
end
		

/**************************
* Phase outputs
***************************/
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		STOPPED <= 1;
		FETCH   <= 0;
		DECODE  <= 0;
		EXECUTE <= 0;
		COMMIT  <= 0;
		PHASE_R <= 0;
		DEBUG_STEP_ACK <= 0;
	end else begin
		STOPPED <= PHASE_NEXT == `PHI_STOPPED || PHASE_NEXT == `PHI_DEBUG_STOPPED || PHASE_NEXT == `PHI_DEBUG_ACK;
		FETCH   <= PHASE_NEXT == `PHI_FETCH   || PHASE_NEXT == `PHI_DEBUG_FETCH;
		DECODE  <= PHASE_NEXT == `PHI_DECODE  || PHASE_NEXT == `PHI_DEBUG_DECODE;
		EXECUTE <= PHASE_NEXT == `PHI_EXECUTE || PHASE_NEXT == `PHI_DEBUG_EXECUTE;
		COMMIT  <= PHASE_NEXT == `PHI_COMMIT  || PHASE_NEXT == `PHI_DEBUG_COMMIT;
		DEBUG_STEP_ACK <= PHASE_NEXT == `PHI_DEBUG_ACK;
		PHASE_R <= PHASE_NEXT;
	end
end

always @(negedge CLK or posedge RESET) begin
	if(RESET) begin
		INSTRUCTION <= 0;
	end else if(EXECUTE) begin
		INSTRUCTION <= DIN;
	end
end

endmodule