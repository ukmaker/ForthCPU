`include "../../constants.v"
/*************************************************
* The address, data and control bus interfaces
* Runs in one of two modes:
* - runtime = normal running
* - debug   = instructions, data and addresses
*             are all supplied by the debugPort
*
* BUS_SEQX states - apply in DECODE and COMMIT
*
* State              DEBUG RD  WR  DRD  DWR  ADDR DATA
* BUS_SEQX_IDLE        0    0   0   0    0     Z    Z
* BUS_SEQX_ARGRD       0    1   0   0    0    ARG   IN
* BUS_SEQX_ARGWR       0    0   1   0    0    ARG  OUT
* BUS_SEQX_DEBUG_DOUT  1    0   0   1    0     DA   DD
**************************************************/

module busInterface(
	
	/****************************************
	* Control signals
	*****************************************/
	input CLK,
	input RESET,
	input FETCH, DECODE, EXECUTE, COMMIT,
	input [2:0] BUS_SEQX,
	
	/****************************************
	* Signals to/from the CPU
	*****************************************/
	// Data
	input  [1:0]   DATA_BUSX,
	input  [15:0]  ALU_R,
	input  [15:0]  REGA_DOUT,
	input  [3:0]   CCREGS_DOUT,
	output [15:0]  CPU_DIN,
	
	// Addresses
	input          BYTEX,
	input [2:0]   ADDR_BUSX,
	
	input [15:0]  PC_A,
	//input [15:0]  ALU_R,
	input [15:0]  REGB_DOUT,
	input [15:0]  HERE,
	
	/****************************************
	* Signals to/from the pin buffers
	*****************************************/
	output reg RD_BUF,
	output reg WR0_BUF,
	output reg WR1_BUF,
	
	output reg [15:0] ADDR_BUF,
	output     [15:0] DOUT_BUF,
	input      [15:0] DIN_BUF,
	
	/****************************************
	* Signals to/from the debugPort
	*****************************************/
	input              DEBUG_MODE_STOP,
	input              DEBUG_MODE_DEBUGX,
	output reg         DEBUG_RD,
	output reg         DEBUG_WR,
	output reg         DEBUG_DATA_OUT_SELX,
	output reg [15:0] DEBUG_DIN,
	input      [15:0] DEBUG_DOUT,
	input      [15:0] DEBUG_ADDR
	
);

reg [15:0] DOUT;
wire HIGH_BYTEX;

wire DEBUGGING;
reg [2:0] ADDR_BUSX_R;

assign DEBUGGING = DEBUG_MODE_STOP & ((DEBUG_MODE_DEBUGX == `DEBUGX_DSTEP) || (DEBUG_MODE_DEBUGX == `DEBUGX_ISTEP)) ;

assign HIGH_BYTEX = ADDR_BUF[0] & BYTEX;
assign CPU_DIN    = DIN_BUF;
assign DOUT_BUF   = HIGH_BYTEX ? {DOUT[7:0], 8'h00} : DOUT;

// During FETCH and DECODE 
// ADDR_BUSX should be set to
// PC_A normally
// DEBUG_ADDR if debugging is active
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		ADDR_BUSX_R = DEBUGGING ? `ADDR_BUSX_DEBUG : `ADDR_BUSX_PC_A;
	end else begin
		if(FETCH | DECODE) begin
			ADDR_BUSX_R = DEBUGGING ? `ADDR_BUSX_DEBUG : `ADDR_BUSX_PC_A;
		end else begin
			ADDR_BUSX_R = ADDR_BUSX;
		end
	end
end

// Address bus mux
always @(*) begin
	case(ADDR_BUSX)
		`ADDR_BUSX_PC_A:      ADDR_BUF = PC_A;
		`ADDR_BUSX_ALU_R:     ADDR_BUF = ALU_R;
		`ADDR_BUSX_REGB_DOUT: ADDR_BUF = REGB_DOUT;
		`ADDR_BUSX_HERE:      ADDR_BUF = HERE;
		`ADDR_BUSX_DEBUG:     ADDR_BUF = DEBUG_ADDR;
		default:              ADDR_BUF = PC_A;
	endcase
end

// Dout mux
always @(*) begin
	case(DATA_BUSX)
		`DATA_BUSX_REGA_DOUT: DOUT = REGA_DOUT;
		`DATA_BUSX_ALU_R:     DOUT = ALU_R;
		`DATA_BUSX_DEBUG:     DOUT = DEBUG_DOUT;
		`DATA_BUSX_CCREGS:    DOUT = {12'h000,CCREGS_DOUT};
	endcase
end

// writes
always @(negedge CLK or posedge RESET) begin
	if(RESET) begin
		WR0_BUF         <= 0;
		WR1_BUF         <= 0;
		DEBUG_WR        <= 0;
		DEBUG_DATA_OUT_SELX <= `DEBUG_DATA_OUT_SELX_INST;
		
	end else begin
		
		if(BUS_SEQX == `BUS_SEQX_ARGWR) begin
			if(DEBUGGING) begin
				DEBUG_DATA_OUT_SELX <= `DEBUG_DATA_OUT_SELX_DATA ;
				if(COMMIT) begin
					DEBUG_WR <= 1;
				end else begin
					DEBUG_WR <= 0;
				end
			end else begin
				if(COMMIT) begin
					WR0_BUF <= ~BYTEX | ~ADDR_BUF[0];
					WR1_BUF <= ~BYTEX |  ADDR_BUF[0];
				end else begin
					WR0_BUF <= 0;
					WR1_BUF <= 0;
				end
			end
			
		end else begin
			DEBUG_DATA_OUT_SELX <= `DEBUG_DATA_OUT_SELX_INST;
			WR0_BUF <= 0;
			WR1_BUF <= 0;
		end
	end
end


// Reads
wire NCLK;
assign NCLK = ~CLK;

always @(negedge CLK or posedge RESET) begin
	if(RESET) begin
		RD_BUF   <= 0;
		DEBUG_RD <= 0;
	end else begin
		// Instruction fetch always happens
		if(DECODE) begin
			if(~DEBUGGING) begin
				RD_BUF <= 1;
			end else begin
				DEBUG_RD <= 1;
			end
		end else if(COMMIT) begin
			if(BUS_SEQX == `BUS_SEQX_ARGRD) begin
				if(~DEBUGGING) begin
					RD_BUF <= 1;
				end else begin
					DEBUG_RD <= 1;
				end
			end 
		end else begin
			RD_BUF <= 0;
			DEBUG_RD <= 0;
		end
	end
end

endmodule