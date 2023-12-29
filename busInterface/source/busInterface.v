`include "../../constants.v"
/*************************************************
* The address, data and control bus interfaces
* Runs in one of two modes:
* - runtime = normal running
* - debug   = instructions, data and addresses
*             are all supplied by the debugPort
*
* BUS_SEQX states
*
* State              RD  WR  DRD  DWR  ADDR DATA
* BUS_SEQX_IDLE       0   0   0    0     Z    Z
* BUS_SEQX_IFETCH     1   0   0    0     PC   IN
* BUS_SEQX_ARGRD      1   0   0    0    ARG   IN
* BUS_SEQX_ARGWR      0   1   0    0    ARG  OUT
* BUS_SEQX_DFETCH     0   0   1    0     Z    IN
* BUS_SEQX_DARGRD     0   0   1    0     DA   DD
* BUS_SEQX_DARGWR     0   0   0    1     DA  OUT
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
	output     [15:0] CPU_DIN,
	input      [15:0] CPU_ADDR,
	input      [15:0] CPU_DOUT,
	input              CPU_BYTEX,
	
	/****************************************
	* Signals to/from the pin buffers
	*****************************************/
	output reg RD_BUF,
	output reg WR0_BUF,
	output reg WR1_BUF,
	
	output     [15:0] ADDR_BUF,
	output     [15:0] DOUT_BUF,
	input      [15:0] DIN_BUF,
	
	/****************************************
	* Signals to/from the debugPort
	*****************************************/
	output reg DEBUG_RD,
	output reg DEBUG_WR,
	output reg DEBUG_DATA_SELX,
	output reg [15:0] DEBUG_DIN,
	input      [15:0] DEBUG_DOUT,
	input      [15:0] DEBUG_ADDR
	
);

wire HIGH_BYTEX;

wire DEBUGGING;

assign DEBUGGING = BUS_SEQX == `BUS_SEQX_DFETCH || BUS_SEQX == `BUS_SEQX_DARGRD || BUS_SEQX == `BUS_SEQX_DARGWR;

assign HIGH_BYTEX = CPU_ADDR[0] & CPU_BYTEX;
assign CPU_DIN    = DEBUGGING ? DEBUG_DOUT : DIN_BUF;
assign DOUT_BUF   = HIGH_BYTEX ? {CPU_DOUT[7:0], 8'h00} : CPU_DOUT;
assign ADDR_BUF   = DEBUGGING ? DEBUG_ADDR : CPU_ADDR;

// writes
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		WR0_BUF         <= 0;
		WR1_BUF         <= 0;
		DEBUG_WR        <= 0;
		DEBUG_DATA_SELX <= `DEBUG_DATA_SELX_OP;
		
	end else begin	
		
		case(BUS_SEQX)
			`BUS_SEQX_ARGWR: begin
				if(COMMIT) begin
					WR0_BUF <= ~CPU_BYTEX | ~CPU_ADDR[0];
					WR1_BUF <= ~CPU_BYTEX |  CPU_ADDR[0];
				end else begin
					WR0_BUF <= 0;
					WR1_BUF <= 0;
				end
			end
			
			`BUS_SEQX_DARGWR: begin
				DEBUG_DATA_SELX <= `DEBUG_DATA_SELX_ARG ;
				if(COMMIT) begin
					DEBUG_WR <= 1;
				end else begin
					DEBUG_WR <= 0;
				end
			end
			
			default: begin
				DEBUG_DATA_SELX <= `DEBUG_DATA_SELX_OP;
				WR0_BUF <= 0;
				WR1_BUF <= 0;
			end
		endcase
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
		case(BUS_SEQX)
			`BUS_SEQX_IFETCH: RD_BUF   <= DECODE;
			`BUS_SEQX_ARGRD:  RD_BUF   <= COMMIT;
			`BUS_SEQX_DFETCH: DEBUG_RD <= DECODE;
			`BUS_SEQX_DARGRD: DEBUG_RD <= COMMIT;
			default: begin
				RD_BUF <= 0;
				DEBUG_RD <= 0;
			end
		endcase
	end
end

endmodule