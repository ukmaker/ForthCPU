`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

/*********************************************************
* Test the UART module
* Use a by-10 clock divider
* Instantiate two UARTS, offset clocks by 5 ticks
* Test:
* Write clock dividers
* Write and receive a byte
*  - check status bits during and after transfer
*  - read received byte and recheck status bits
* Enable interrupts
* Resend a byte
*  - check status and interrupt bits
*********************************************************/

module UARTTests;
	
	reg [15:0] DIN;
	wire [15:0] DOUT0;
	wire [15:0] DOUT1;
	reg CLK;
	reg RESET;
	reg [1:0] ADDR;
	reg RD0;
	reg WR0;
	wire INT0;
	reg RD1;
	reg WR1;
	wire INT1;
	
	wire RXD;
	wire TXD;
	
UART transmitter(
	.CLK(CLK),
	.RESET(RESET),
	.ADDR(ADDR),
	.RD(RD0),
	.WR(WR0),
	.UART_INT(INT0),
	.DIN(DIN),
	.DOUT(DOUT0),
	.RXD(RXD),
	.TXD(TXD)
);

UART receiver(
	.CLK(CLK),
	.RESET(RESET),
	.ADDR(ADDR),
	.RD(RD1),
	.WR(WR1),
	.UART_INT(INT1),
	.DIN(DIN),
	.DOUT(DOUT1),
	.RXD(TXD),
	.TXD(RXD)
);


// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	#10
	CLK = 0; 
	RESET = 1;
	DIN = 16'h0000;
	ADDR = 2'b00;
	RD0 = 0;
	WR0 = 0;
	RD1 = 0;
	WR1 = 0;
	`TICKTOCK;
	`TICKTOCK;

	RESET = 0;  
	`TICKTOCK;
	
	// set the clock divider to 4 to speed up the simulation
	ADDR = 2'b10;
	WR0 = 1;
	WR1 = 1;
	DIN = 16'h0004;
	`step(1, "Set clock divider TX")
	WR0 = 0;
	WR1 = 0;
	`TICKTOCK;
	ADDR = 2'b11;
	WR0 = 1;
	WR1 = 1;
	`step(2, "Set clock divider RX")
	WR0 = 0;
	WR1 = 0;
	
	// Send a byte
	WR0 = 1;
	ADDR = 2'b01;
	DIN = 16'habcd;
	`step(3, "Send a byte")
	WR0 = 0;
	`TICKTOCK;
	`TICKTOCK;
		
	// Check the transmitter is transmitting
	ADDR = `UART_REG_STATUS;
	RD0 = 1;
	`step(4, "Transmit a byte - check status running")
	`assert("STATUS", `UART_STATUS_TX_ACTIVE, DOUT0)
	RD1 = 1;
	`TICKTOCK;


	// delay by 10+2 clock cycles
	#4400
	// Now the data should be available in the receiver
	// start by checking for the flag in the status register
	// Expect RXI=1 , TXC=1 (no transmit from this instance yet, so still 
	// at 1 after reset)
	ADDR = `UART_REG_STATUS;
	RD1 = 1;
	`step(5, "Receive a byte - check status")
	`assert("STATUS", (`UART_STATUS_TX_COMPLETE | `UART_STATUS_DATA_AVAILABLE | `UART_STATUS_RX_INTERRUPT), DOUT1)
	RD1 = 0;
	`TICKTOCK;
	ADDR = `UART_REG_DATA;
	RD1 = 1;
	`step(6, "Receive a byte - check data")
	`assert("DATA", 16'h00cd, DOUT1)
	RD1 = 0;
	`TICKTOCK;
	// Re-read the status register and check that the RXI has been cleared
	ADDR = `UART_REG_STATUS;
	RD1 = 1;
	`step(7, "Receive a byte - check status clear")
	`assert("STATUS", `UART_STATUS_TX_COMPLETE, DOUT1)
	RD1 = 0;
	`TICKTOCK;
	
	// Check the transmitter
	ADDR = `UART_REG_STATUS;
	RD0 = 1;
	`step(8, "Transmit a byte - check status complete")
	`assert("STATUS", (`UART_STATUS_TX_COMPLETE | `UART_STATUS_TX_INTERRUPT), DOUT0)
	RD1 = 1;
	`TICKTOCK;
	


end
	
endmodule
	