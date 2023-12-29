`include "../../constants.v"

module masterSequencer(
	
	input CLK,
	input RESET,
	// input DEBUG_MODE_RESET,
	input DEBUG_REQ,
	input DEBUG_MODE_STOP,
	input DEBUG_MODE_INC,
	input DEBUG_AT_BKP,
	input DEBUG_IN_WATCH,
	input HALTX,
	
	output reg STOPPED,
	output reg FETCH,
	output reg DECODE,
	output reg EXECUTE,
	output reg COMMIT,
	
	output reg DEBUG_ACK,
	output reg DEBUG_MR_ADDR_INCX,
	output reg HALTED,
	output reg PC_ENX,
	
	output reg DEBUG_ACTIVE
	
);

/********************************************
* PC_ENX is active if
* - DEBUG_MODE_STOP == 0 && HALTX == 0
* 
* PC_ENX goes low at
* - posedge CLK && FETCH && (DEBUG_MODE_STOP || DEBUG_AT_BKP || DEBUG_IN_WATCH)
* - PHI stops with STOPPED high
* - DEBUG_ACTIVE goes high
*
* A cycle is triggered when DEBUG_REQ goes high
* - PC_ENX goes high
* - DEBUG_ACTIVE stays high
* - DEBUG_ACK is issued for one cycle with FETCH 
*   if (DEBUG_MODE_STOP || DEBUG_AT_BKP || DEBUG_IN_WATCH)
*     return to STOPPED*   else 
*     continue
*
* - If DEBUG_MODE_INC is high, DEBUG_MR_ADDR_INCX goes high with FETCH
*
***/

// Internal state
reg [3:0] PHASE_R;
reg [3:0] PHASE_NEXT;
reg RESET_R;
wire PC_STOP;

wire DEBUG_ACTIVE_NEXT;

assign DEBUG_ACTIVE_NEXT = 
     PHASE_NEXT == `PHI_DEBUG_STOPPED 
  || PHASE_NEXT == `PHI_DEBUG_FETCH 
  || PHASE_NEXT == `PHI_DEBUG_DECODE 
  || PHASE_NEXT == `PHI_DEBUG_EXECUTE 
  || PHASE_NEXT == `PHI_DEBUG_COMMIT 
  || PHASE_NEXT == `PHI_DEBUG_ACK;
  
assign PC_STOP = DEBUG_ACTIVE_NEXT;


/***************************************************
* Startup out of reset
***************************************************/
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		PC_ENX <= 0;
		RESET_R <= 1;
	end else begin
		RESET_R <= 0;
		PC_ENX  <= ~PC_STOP & ~RESET_R;
	end
end

always @(*) begin
	case(PHASE_R)
		`PHI_STOPPED: begin
			if(DEBUG_MODE_STOP | DEBUG_AT_BKP | DEBUG_IN_WATCH) begin
				PHASE_NEXT = `PHI_DEBUG_STOPPED;
			end else if(!HALTX) begin
				PHASE_NEXT = RESET_R ? `PHI_FETCH : `PHI_DECODE;
			end else begin
				PHASE_NEXT = `PHI_FETCH;
			end
		end
		
		`PHI_FETCH: begin
			if(DEBUG_MODE_STOP | DEBUG_AT_BKP | DEBUG_IN_WATCH) begin
				PHASE_NEXT = `PHI_DEBUG_STOPPED;
			end else begin
				PHASE_NEXT = `PHI_DECODE;
			end
		end		
		
		`PHI_DECODE:  PHASE_NEXT = `PHI_EXECUTE;
		`PHI_EXECUTE: PHASE_NEXT = `PHI_COMMIT;
		`PHI_COMMIT:  PHASE_NEXT = `PHI_FETCH;
		
		`PHI_DEBUG_STOPPED: begin
			if(DEBUG_REQ) begin
				PHASE_NEXT = `PHI_DEBUG_DECODE;
			end else if(!(DEBUG_MODE_STOP | DEBUG_AT_BKP | DEBUG_IN_WATCH)) begin
				PHASE_NEXT = `PHI_STOPPED;
			end else begin
				PHASE_NEXT = `PHI_DEBUG_STOPPED;
			end
		end
		
		`PHI_DEBUG_DECODE: PHASE_NEXT = `PHI_DEBUG_EXECUTE;
		`PHI_DEBUG_EXECUTE:PHASE_NEXT = `PHI_DEBUG_COMMIT;
		`PHI_DEBUG_COMMIT: PHASE_NEXT = `PHI_DEBUG_FETCH;
		`PHI_DEBUG_FETCH:  PHASE_NEXT = `PHI_DEBUG_ACK;
		
		`PHI_DEBUG_ACK: begin
			// Wait for REQ to go low
			if(!DEBUG_REQ) begin
				PHASE_NEXT = `PHI_DEBUG_STOPPED;
			end else begin
				PHASE_NEXT = `PHI_DEBUG_ACK;
			end
		end
		
		default: begin
			// shouldn't be possible
			PHASE_NEXT = `PHI_STOPPED;
		end
	endcase
end

always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		STOPPED            <= 1;
		FETCH              <= 0;
		DECODE             <= 0;
		EXECUTE            <= 0;
		COMMIT             <= 0;
		PHASE_R            <= `PHI_STOPPED;
		//PHASE_NEXT         <= `PHI_FETCH;
		DEBUG_ACK          <= 0;
		DEBUG_MR_ADDR_INCX <= 0;
		HALTED             <= 0;
		DEBUG_ACTIVE       <= 0;
	end else begin
		STOPPED            <= PHASE_NEXT == `PHI_STOPPED || PHASE_NEXT == `PHI_DEBUG_STOPPED;
		FETCH              <= PHASE_NEXT == `PHI_FETCH   || PHASE_NEXT == `PHI_DEBUG_FETCH;
		DECODE             <= PHASE_NEXT == `PHI_DECODE  || PHASE_NEXT == `PHI_DEBUG_DECODE;
		EXECUTE            <= PHASE_NEXT == `PHI_EXECUTE || PHASE_NEXT == `PHI_DEBUG_EXECUTE;
		COMMIT             <= PHASE_NEXT == `PHI_COMMIT  || PHASE_NEXT == `PHI_DEBUG_COMMIT;
		PHASE_R            <= PHASE_NEXT;		
		DEBUG_ACK          <= PHASE_NEXT == `PHI_DEBUG_ACK;
		DEBUG_MR_ADDR_INCX <= (PHASE_NEXT == `PHI_DEBUG_ACK) && DEBUG_MODE_INC;
		HALTED             <= (PHASE_NEXT == `PHI_DECODE  || PHASE_NEXT == `PHI_DEBUG_DECODE) && HALTX;
		DEBUG_ACTIVE       <= DEBUG_ACTIVE_NEXT;
	end
end

endmodule