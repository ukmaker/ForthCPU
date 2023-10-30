/***********************************************
* I/O definition for the dev board
* LEDS
* DIP switches
* Reset switch
* Address and data buses and control signals
************************************************/
module devBoard (
        // inputs
        input   wire         PIN_CLK_X1,     // 12M clock from FTDI/X1 crystal
        input   wire         PIN_RESETN,       // from SW1 pushbutton
        input   wire  [3:0] PIN_DIPSW,      // from SW2 DIP switches
        
        // outputs
        output reg  [7:0] PIN_LED,         // to LEDs (D2-D9)
		output reg         PIN_RDN,
		output reg         PIN_WR0N,
		output reg         PIN_WR1N,
		inout      [15:0] PIN_DBUS,
		output reg [15:0] PIN_ADDR,
		
		// UART I/O
		input wire PIN_RXD,
		output reg PIN_TXD,
		
		// Interrupts
		input wire PIN_INT0,
		input wire PIN_INT1,
		input wire PIN_INT2,
		input wire PIN_INT3,
		input wire PIN_INT4,
		input wire PIN_INT5,
		input wire PIN_INT6,
		
		/********************************
		* Internal signals
		*********************************/
		output wire CLK,
		output wire RESET,
		
		input wire [15:0] ADDR,
		
		input  wire [15:0] DOUT,
		output reg  [15:0] DIN,
		
		output wire INTS0,
		output wire INTS1,
		output wire INTS2,
		output wire INTS3,
		output wire INTS4,
		output wire INTS5,
		output wire INTS6,
		
		input wire RDN,
		input wire WR0N,
		input wire WR1N,
		
		output wire UART_RXD,
		input  wire UART_TXD,
		
		output reg [15:0] DIN_GPIO,
		input wire RD_GPIO,
		input wire WR_GPIO,
		input wire ADDR_GPIO
);

assign CLK = PIN_CLK_X1;
assign RESET = ~PIN_RESETN;
assign PIN_DBUS = (WR0N == 0 || WR1N == 0) ? DOUT : 16'hZZZZ;

assign INTS0 = PIN_INT0;
assign INTS1 = PIN_INT1;
assign INTS2 = PIN_INT2;
assign INTS3 = PIN_INT3;
assign INTS4 = PIN_INT4;
assign INTS5 = PIN_INT5;
assign INTS6 = PIN_INT6;
assign UART_RXD = PIN_RXD;
assign DIN_GPIO[15:8] = 8'h00;

always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		
		PIN_LED  <= 8'b00000000;
		DIN_GPIO[7:0] <= 8'h00;
		DIN      <= 16'h0000;
		PIN_ADDR <= 16'h0000;
		PIN_RDN  <= 1'b1;
		PIN_WR0N <= 1'b1;
		PIN_WR1N <= 1'b1;
		PIN_TXD  <= 1'b0;
		
	end else begin
		
		PIN_RDN  <= RDN;
		PIN_WR0N <= WR0N;
		PIN_WR1N <= WR1N;
		PIN_ADDR <= ADDR;
		PIN_TXD  <= UART_TXD;
		
		if(RD_GPIO && ADDR_GPIO == 0) begin
			DIN_GPIO[7:0] <= {4'h0,PIN_DIPSW};
		end else begin
			DIN_GPIO[7:0] <= PIN_LED;
		end
		
		if(WR_GPIO & ADDR_GPIO) begin
			PIN_LED <= DOUT;
		end
		
		if(RDN) 
			DIN <= PIN_DBUS;
		else
			DIN <= DOUT;
	end
end


endmodule