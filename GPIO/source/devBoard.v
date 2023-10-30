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
		inout  reg [15:0] PIN_DBUS,
		output reg [15:0] PIN_ADDR,
		
		output wire CLK,
		output wire RESET,
		output reg  [15:0] GPI, // Latched signals from the DIP switches
		input  wire [15:0] GPO,
		input  wire RD_GPIO,
		input  wire WR_GPIO,
		input  wire ADDR_GPIO
);

assign CLK = CLK_X1;
assign RESET = ~RESETN;

always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		LED <= 8'b00000000;
		GPI <= 16'h0000;
	end else begin
		
		if(ADDR_GPIO == 0) begin
			GPI <= {12'h000,DIPSW};
		end else begin
			GPI <= {8'h00, LED};
		end
		
		if(WR_GPIO & ADDR_GPIO) begin
			LED <= GPO;
		end
	end
end


endmodule