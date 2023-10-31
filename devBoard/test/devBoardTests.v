`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module devBoardTests;
	
       // inputs
        reg         PIN_CLK_X1;     // 12M clock from FTDI/X1 crystal
        reg         PIN_RESETN;       // from SW1 pushbutton
        reg [3:0]  PIN_DIPSW;      // from SW2 DIP switches
        
        // outputs
        wire [7:0]  PIN_LED;         // to LEDs (D2-D9)
		wire         PIN_RDN;
		wire         PIN_WR0N;
		wire         PIN_WR1N;
		wire [15:0] PIN_DBUS;
		wire [15:0] PIN_ADDR;
		
		// UART I/O
		reg PIN_RXD;
		wire PIN_TXD;
		
		// Interrupts
		reg PIN_INT0;
		reg PIN_INT1;
		reg PIN_INT2;
		reg PIN_INT3;
		reg PIN_INT4;
		reg PIN_INT5;
		reg PIN_INT6;
		
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
        .PIN_CLK_X1(PIN_CLK_X1),    // 12M clock from FTDI/X1 crystal
        .PIN_RESETN(PIN_RESETN),       // from SW1 pushbutton
        .PIN_DIPSW(PIN_DIPSW),      // from SW2 DIP switches
        
        // outputs
        .PIN_LED(PIN_LED),         // to LEDs (D2-D9)
		.PIN_RDN(PIN_RDN),
		.PIN_WR0N(PIN_WR0N),
		.PIN_WR1N(PIN_WR1N),
		.PIN_DBUS(PIN_DBUS),
		.PIN_ADDR(PIN_ADDR),
		
		// UART I/O
		.PIN_RXD(PIN_RXD),
		.PIN_TXD(PIN_TXD),
		// Interrupts
		.PIN_INT0(PIN_INT0),
		.PIN_INT1(PIN_INT1),
		.PIN_INT2(PIN_INT2),
		.PIN_INT3(PIN_INT3),
		.PIN_INT4(PIN_INT4),
		.PIN_INT5(PIN_INT5),
		.PIN_INT6(PIN_INT6),

		
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

reg [15:0] PIN_DBUS_IN;

always begin
	#50 PIN_CLK_X1 = ~PIN_CLK_X1;
end

assign PIN_DBUS = PIN_DBUS_IN;

initial begin
	PIN_CLK_X1 = 0;
	PIN_RESETN = 0;
	PIN_DIPSW = 4'b0000;
	PIN_DBUS_IN = 16'h1234;
	PIN_RXD = 1'b0;
	PIN_INT0 = 1'b0;
	PIN_INT1 = 1'b0;
	PIN_INT2 = 1'b0;
	PIN_INT3 = 1'b0;
	PIN_INT4 = 1'b0;
	PIN_INT5 = 1'b0;
	PIN_INT6 = 1'b0;
	
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
	PIN_RESETN = 1;
	`TICKTOCK;
	
	// Write to the LEDs - incorrect address so no write
	DOUT = 16'haaaa;
	WR_GPIO = 1;
	`TICKTOCK;
	`assert("LEDS", 8'h00, PIN_LED)
	
	// Write to the LEDs - correct address
	ADDR_GPIO = 1'b1;
	DOUT = 16'haaaa;
	WR_GPIO = 1;
	`TICKTOCK;
	`assert("LEDS", 8'haa, PIN_LED)
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
	`assert("LEDS", 8'h55, PIN_LED)
	// Read them  back
	WR_GPIO = 1'b0;
	RD_GPIO = 1'b1;
	`TICKTOCK;
	`assert("DIN_GPIO", 8'h55, DIN_GPIO)
	
end


endmodule