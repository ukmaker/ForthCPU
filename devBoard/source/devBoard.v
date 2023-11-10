/***********************************************
* I/O definition for the dev board
* LEDS
* DIP switches
* Reset switch
* Address and data buses and control signals
************************************************/
module devBoard (
        // inputs
        input   wire         BPIN_CLK_X1,     // 12M clock from FTDI/X1 crystal
        input   wire         BPIN_RESETN,       // from SW1 pushbutton
        input   wire  [3:0] BPIN_DIPSW,      // from SW2 DIP switches
        
        // outputs
        output reg  [7:0] BPIN_LED,         // to LEDs (D2-D9)
		output reg         BPIN_RDN,
		output reg         BPIN_WR0N,
		output reg         BPIN_WR1N,
		inout      [15:0] BPIN_DBUS,
		output reg [15:0] BPIN_ADDR,
		
		// UART I/O
		input wire BPIN_RXD,
		output reg BPIN_TXD,
		
		// Interrupts
		input wire BPIN_INT0,
		input wire BPIN_INT1,
		input wire BPIN_INT2,
		input wire BPIN_INT3,
		input wire BPIN_INT4,
		input wire BPIN_INT5,
		input wire BPIN_INT6,
		
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
		
		output reg [7:0] DIN_GPIO,
		input wire RD_GPIO,
		input wire WR_GPIO,
		input wire ADDR_GPIO
);

reg [3:0] DIPSW_R;

assign CLK = BPIN_CLK_X1;
assign RESET = ~BPIN_RESETN;
assign BPIN_DBUS = (WR0N == 0 || WR1N == 0) ? DOUT : 16'hZZZZ;

assign INTS0 = BPIN_INT0;
assign INTS1 = BPIN_INT1;
assign INTS2 = BPIN_INT2;
assign INTS3 = BPIN_INT3;
assign INTS4 = BPIN_INT4;
assign INTS5 = BPIN_INT5;
assign INTS6 = BPIN_INT6;
assign UART_RXD = BPIN_RXD;

// Passthru signals
always @(*) begin
	if(RESET) begin	
		BPIN_ADDR = 16'h0000;
		BPIN_RDN  = 1'b1;
		BPIN_WR0N = 1'b1;
		BPIN_WR1N = 1'b1;
		BPIN_TXD  = 1'b0;
		DIN       = BPIN_DBUS;
		DIN_GPIO[7:0] = {4'h0,DIPSW_R};
	end else begin
		BPIN_ADDR = ADDR;
		BPIN_RDN  = RDN;
		BPIN_WR0N = WR0N;
		BPIN_WR1N = WR1N;
		BPIN_TXD  = UART_TXD;
		
		if(RD_GPIO && ADDR_GPIO == 0) begin
			DIN_GPIO[7:0] = {4'h0,DIPSW_R};
		end else begin
			DIN_GPIO[7:0] = BPIN_LED;
		end
		
		if(RDN) begin
			DIN = BPIN_DBUS;
		end else begin
			DIN = DOUT;
		end
	end
end

always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		
		BPIN_LED  <= 8'b00000000;
		DIPSW_R  <= 4'b0000;
		
	end else begin
		
		DIPSW_R <= BPIN_DIPSW;
		
		if(WR_GPIO & ADDR_GPIO) begin
			BPIN_LED <= DOUT;
		end
	end
end


endmodule