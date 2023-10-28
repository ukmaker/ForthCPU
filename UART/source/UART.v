`include "../../constants.v"

/********************************************************
* Wrap the UART IP so that:
* The data available flag is latched and reset on a read
* There is a status register
* Addr 0 => Read       Status
* Addr 1 => Read/write Data
* Addr 2 => Read/write RX CLK_DIV
* Addr 3 => Read/write TX CLK_DIV
*
* Status  0 - RX Data Available
*         1 - TX Active
*         2 - TX Done
*********************************************************/

module UART(
	
	input CLK,
	input RESET,
	
	input RD,
	input WR,
	
	output reg UART_INT,
	
	input [1:0] ADDR,
	
	input  [15:0] DIN,
	output reg [15:0] DOUT,
	
	input RXD,
	output TXD
	
);

wire DATA_AVAILABLE;
wire [7:0] RX_BYTE;

wire TX_ACTIVE;
wire TX_DONE;
reg START_TX;

reg [15:0] STATUS;
reg [15:0] RX_CLK_DIV;
reg [15:0] TX_CLK_DIV;
wire RESETN;

assign RESETN = ~RESET;

UART_RX uartRXInst(
   .i_Clock(CLK),
   .i_RX_Serial(RXD),
   .o_RX_DV(DATA_AVAILABLE),
   .o_RX_Byte(RX_BYTE),
   .CLKS_PER_BIT(RX_CLK_DIV)
);

UART_TX uartTxInst(
   .i_Rst_L(RESETN),
   .i_Clock(CLK),
   .i_TX_DV(START_TX),
   .i_TX_Byte(DIN[7:0]), 
   .o_TX_Active(TX_ACTIVE),
   .o_TX_Serial(TXD),
   .o_TX_Done(TX_DONE),
   .CLKS_PER_BIT(TX_CLK_DIV)
);

always @(*) begin
	UART_INT = STATUS[`UART_STATUS_DATA_AVAILABLE] | STATUS[`UART_STATUS_TX_COMPLETE];
end

always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		START_TX <= 0;
		STATUS <= 16'h0000;
		RX_CLK_DIV <= 16'd217;
		TX_CLK_DIV <= 16'd217;
	end else if(CLK) begin
		// latch completions
		if(DATA_AVAILABLE) begin
			STATUS[`UART_STATUS_DATA_AVAILABLE] <= 1;
		end
		
		STATUS[`UART_STATUS_TX_ACTIVE] <= TX_ACTIVE;
		
		if(TX_DONE) begin
			STATUS[`UART_STATUS_TX_COMPLETE] <= 1;
		end
			
		if(TX_ACTIVE) begin
			START_TX <= 0;
		end
			
		if(RD) begin
			case(ADDR)
				2'b00: begin // Read status
					DOUT <= STATUS;
				end
				
				2'b01: begin // Read data, reset flag
					DOUT <= RX_BYTE;
					STATUS[`UART_STATUS_DATA_AVAILABLE] <= 0;
				end
				
				2'b10: begin // Read RX_CLK_DIV
					DOUT <= RX_CLK_DIV;
				end
				
				2'b11: begin
					DOUT <= TX_CLK_DIV;
				end
			endcase
		end
			
		if(WR) begin
			case(ADDR)
				2'b00: begin end // Ignore status writes
				2'b01: begin     // Write data, clear sent flag
					START_TX <= 1;
					STATUS[`UART_STATUS_TX_COMPLETE] <= 0;
				end
				2'b10: begin     // RX_CLK_DIV
					RX_CLK_DIV <= DIN;
				end
				2'b11: begin
					TX_CLK_DIV <= DIN;
				end
			endcase
		end
	end
end
   
   
endmodule