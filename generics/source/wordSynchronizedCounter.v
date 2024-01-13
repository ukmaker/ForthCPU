`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/***********************************************
* Cross domain loadable up counter
* With preload, increment and reset inputs
************************************************/

module wordSynchronizedCounter(
	
	input SLOWCLK,
	input RESET,
	input FASTCLK,
	input EN0,
	input EN1,
	input LD,
	input CLR,
	input COUNT,
	input [7:0] D,
	output reg [15:0] Q

);

reg [15:0] Q_R;
reg [15:0] Q_PHI0;

reg XFER;
reg [1:0] DONE;

/****************
* Write latch
*****************/
always @(posedge SLOWCLK or posedge RESET) begin
	if(RESET) begin
		Q_R        <= 0;
		XFER       <= 0;
	end else if(LD & EN0) begin
		Q_R[7:0]  <= D;
		XFER       <= 0;
	end else if(LD & EN1) begin
		Q_R[15:8] <= D;
		XFER       <= 1;
	end
end

/****************
* Resynchronizer
*****************/
always @(posedge FASTCLK or posedge RESET or posedge CLR) begin
	if(RESET) begin
		Q_PHI0  <= 0;
		Q       <= 0;
		DONE    <= 2'b00;

	end else begin
		if(XFER & DONE == 2'b00) begin
			Q_PHI0 <= Q_R;
			Q      <= Q_PHI0;
			DONE   <= 2'b01;
		end else if(XFER & DONE == 2'b01) begin
			Q_PHI0 <= Q_R;
			Q      <= Q_PHI0;
			DONE   <= 2'b10;
		end else if(~XFER & DONE == 2'b10) begin
			DONE = 2'b00;
		end else if(~XFER & DONE == 2'b00) begin
			if(COUNT) begin
				Q <= Q + 2;
			end
		end
	end
end

endmodule