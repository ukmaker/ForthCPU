`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module devBoardTests;
	
       // inputs
        reg         BPIN_CLK_X1;     // 12M clock from FTDI/X1 crystal
        reg         BPIN_RESETN;       // from SW1 pushbutton
        reg [3:0]  BPIN_DIPSW;      // from SW2 DIP switches
        
        // outputs
        wire [7:0]  BPIN_LED;         // to LEDs (D2-D9)
		wire         BPIN_RDN;
		wire         BPIN_WR0N;
		wire         BPIN_WR1N;
		wire [15:0] BPIN_DBUS;
		wire [15:0] BPIN_ADDR;
		
		// UART I/O
		reg BPIN_RXD;
		wire BPIN_TXD;
		
		// Interrupts
		reg BPIN_INT0;
		reg BPIN_INT1;
		reg BPIN_INT2;
		reg BPIN_INT3;
		reg BPIN_INT4;
		reg BPIN_INT5;
		reg BPIN_INT6;
		
		/********************************
		* Internal signals
		*********************************/
		wire CLK;
		wire RESET;
		
		reg   [15:0] ADDR;
		
		reg   [15:0] DOUT;
		wire  [15:0] DIN;
		
		wire INTS0;
		wire INTS1;
		wire INTS2;
		wire INTS3;
		wire INTS4;
		wire INTS5;
		wire INTS6;
		
		reg RDN;
		reg WR0N;
		reg WR1N;
		
		wire UART_RXD;
		reg UART_TXD;
		
		wire [7:0] DIN_GPIO;
		reg RD_GPIO;
		reg WR_GPIO;
		reg ADDR_GPIO;
		
devBoard testInst(
        .BPIN_CLK_X1(BPIN_CLK_X1),    // 12M clock from FTDI/X1 crystal
        .BPIN_RESETN(BPIN_RESETN),       // from SW1 pushbutton
        .BPIN_DIPSW(BPIN_DIPSW),      // from SW2 DIP switches
        
        // outputs
        .BPIN_LED(BPIN_LED),         // to LEDs (D2-D9)
		.BPIN_RDN(BPIN_RDN),
		.BPIN_WR0N(BPIN_WR0N),
		.BPIN_WR1N(BPIN_WR1N),
		.BPIN_DBUS(BPIN_DBUS),
		.BPIN_ADDR(BPIN_ADDR),
		
		// UART I/O
		.BPIN_RXD(BPIN_RXD),
		.BPIN_TXD(BPIN_TXD),
		// Interrupts
		.BPIN_INT0(BPIN_INT0),
		.BPIN_INT1(BPIN_INT1),
		.BPIN_INT2(BPIN_INT2),
		.BPIN_INT3(BPIN_INT3),
		.BPIN_INT4(BPIN_INT4),
		.BPIN_INT5(BPIN_INT5),
		.BPIN_INT6(BPIN_INT6),

		
		/********************************
		* Internal signals
		*********************************/
		.CLK(CLK),
		.RESET(RESET),
		
		.ADDR(ADDR),
		
		.DOUT(DOUT),
		.DIN(DIN),
		
		.INTS0(INTS0),
		.INTS1(INTS1),
		.INTS2(INTS2),
		.INTS3(INTS3),
		.INTS4(INTS4),
		.INTS5(INTS5),
		.INTS6(INTS6),

		
		.RDN(RDN),
		.WR0N(WR0N),
		.WR1N(WR1N),
		
		.UART_RXD(UART_RXD),
		.UART_TXD(UART_TXD),
		
		.DIN_GPIO(DIN_GPIO),
		.RD_GPIO(RD_GPIO),
		.WR_GPIO(WR_GPIO),
		.ADDR_GPIO(ADDR_GPIO)
);

reg [15:0] BPIN_DBUS_IN;

always begin
	#50 BPIN_CLK_X1 = ~BPIN_CLK_X1;
end

assign BPIN_DBUS = BPIN_DBUS_IN;

initial begin
	BPIN_CLK_X1 = 0;
	BPIN_RESETN = 0;
	BPIN_DIPSW = 4'b0000;
	BPIN_DBUS_IN = 16'h1234;
	BPIN_RXD = 1'b0;
	BPIN_INT0 = 1'b0;
	BPIN_INT1 = 1'b0;
	BPIN_INT2 = 1'b0;
	BPIN_INT3 = 1'b0;
	BPIN_INT4 = 1'b0;
	BPIN_INT5 = 1'b0;
	BPIN_INT6 = 1'b0;
	
	ADDR = 16'h0000;
	DOUT = 16'h0000;
	RDN = 1'b1;
	WR0N = 1'b1;
	WR1N = 1'b1;
	UART_TXD = 1'b1;
	
	RD_GPIO = 1'b0;
	WR_GPIO = 1'b0;
	ADDR_GPIO = 1'b0;
	
	`TICKTOCK;
	BPIN_RESETN = 1;
	`TICKTOCK;
	
	// Write to the LEDs - incorrect address so no write
	DOUT = 16'haaaa;
	WR_GPIO = 1;
	`TICKTOCK;
	`assert("LEDS", 8'h00, BPIN_LED)
	
	// Write to the LEDs - correct address
	ADDR_GPIO = 1'b1;
	DOUT = 16'haaaa;
	WR_GPIO = 1;
	`TICKTOCK;
	`assert("LEDS", 8'haa, BPIN_LED)
	// Read them  back
	WR_GPIO = 1'b0;
	RD_GPIO = 1'b1;
	`TICKTOCK;
	`assert("DIN_GPIO", 8'haa, DIN_GPIO)
	
	
	// Write to the LEDs - correct address
	DOUT = 16'h5555;
	RD_GPIO = 1'b0;
	WR_GPIO = 1'b1;
	`TICKTOCK;
	`assert("LEDS", 8'h55, BPIN_LED)
	// Read them  back
	WR_GPIO = 1'b0;
	RD_GPIO = 1'b1;
	`TICKTOCK;
	`assert("DIN_GPIO", 8'h55, DIN_GPIO)
	
end


endmodule