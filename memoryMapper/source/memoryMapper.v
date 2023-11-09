`include "../../constants.v"

/***************************************************
* Provide select signals for on-chip devices and 
* route data appropriately
* RAM
* ROM
* UART
* Interrupts
****************************************************/
module memoryMapper(
	
	input RESET,
	
	
	// Interface to the CPU
	input       [15:0] ADDR,
	output reg  [15:0] CPU_DIN,
	input RDN,
	input WR0N,
	input WR1N,
	
	// Bus interface
	input  [15:0] DIN_BUS,

	// ROM
	input  [15:0] DIN_ROM,
	
	// RAM
	input  [15:0] DIN_RAM,
	output reg BE0,
	output reg BE1,
	output reg WR_RAM,
	output reg EN_RAM,
	
	// UART
	input  [15:0] DIN_UART,
	output reg WR_UART,
	output reg RD_UART,
	output [1:0] ADDR_UART,
	
	// Interrupt control
	input [15:0] DIN_INT,
	output reg WR_INT,
	output reg RD_INT,
	output [1:0] ADDR_INT,
	
	// GPIO
	input [15:0] DIN_GPIO,
	output reg WR_GPIO,
	output reg RD_GPIO,
	output     ADDR_GPIO
);

wire READ;
wire WRITE;
wire RAM_MAP;
wire ROM_MAP;
wire UART_MAP;
wire INT_MAP;
wire GPIO_MAP;
/************************************************
* Decode the address to enable RAM or ROM
* ROM 0x0000 to 0x2000 
*   16'b 0000 0000 0000 0000 
*   16'b 0010 0000 0000 0000
* RAM 0x2000 to 0x6000 
*   16'b 0010 0000 0000 0000
*   16'b 0110 0000 0000 0000
* UART is at 0xffe0 - 0xffe7 0 - Status, 2 - Data, 4 - RXDIV, 6 - TXDIV
* INT  is at 0xffe8 - 0xffef
* GPIO is at 0xfff0 - 0xfff3
* 
************************************************/
assign ROM_MAP   = (ADDR >= 16'h0000 && ADDR < 16'h2000);
assign RAM_MAP   = (ADDR >= 16'h2000 && ADDR < 16'h6000 );
assign UART_MAP  = (ADDR >= 16'hffe0 && ADDR <= 16'hffe7);
assign INT_MAP   = (ADDR >= 16'hffe8 && ADDR <= 16'hffef);
assign GPIO_MAP  = (ADDR >= 16'hfff0 && ADDR <= 16'hfff3);
assign WRITE     = (WR0N == 0 || WR1N == 0);
assign READ      = ~RDN;
assign ADDR_UART = ADDR[2:1];
assign ADDR_INT  = ADDR[2:1];
assign ADDR_GPIO = ADDR[1];

// Select the data source
always @(*) begin
	if(RAM_MAP) begin
		CPU_DIN = DIN_RAM;
	end else if(ROM_MAP) begin
		CPU_DIN = DIN_ROM;
	end else if(UART_MAP) begin
		CPU_DIN = DIN_UART;
	end else if(INT_MAP) begin
		CPU_DIN = DIN_INT;
	end else if(GPIO_MAP) begin
		CPU_DIN = DIN_GPIO;
	end else begin
		CPU_DIN = DIN_BUS;
	end
end

// Control signals
always @(*) begin
	BE0     = 0;
	BE1     = 0;
	WR_RAM  = 0;
	EN_RAM  = 0;
	RD_UART = 0;
	WR_UART = 0;
	RD_INT  = 0;
	WR_INT  = 0;
	RD_GPIO = 0;
	WR_GPIO = 0;
	
	if(!RESET) begin
	
		if(UART_MAP) begin
			WR_UART = WRITE;
			RD_UART = READ;
		end 
		
		if(INT_MAP) begin
			RD_INT = READ;
			WR_INT = WRITE;
		end
		
		if(GPIO_MAP) begin
			RD_GPIO = READ;
			WR_GPIO = WRITE;
		end
		
		if(RAM_MAP) begin
			EN_RAM = 1;
			if(READ) begin
				BE0 = 1;
				BE1 = 1;
				WR_RAM = 0;
			end else if(WRITE) begin
				BE1 = ~WR0N; // note enables seem to be numbered in reverse order
				BE0 = ~WR1N;
				WR_RAM = 1;
			end else begin
				BE0 = 0;
				BE1 = 0;
				WR_RAM = 0;
			end
		end
	end
end

endmodule