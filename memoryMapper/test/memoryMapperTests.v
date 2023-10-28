`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module memoryMapperTests;
	
reg CLK;
reg RESET;

reg RDN;
reg WR0N;
reg WR1N;

reg [15:0] ADDR;
wire[15:0] CPU_DIN;

reg [15:0] DIN_BUS;
reg [15:0] DIN_ROM;
reg [15:0] DIN_RAM;
reg [15:0] DIN_UART;
reg [15:0] DIN_INT;

wire RD_UART;
wire WR_UART;
wire [1:0] ADDR_UART;

wire RD_INT;
wire WR_INT;
wire [1:0] ADDR_INT;

PUR PUR_INST(.PUR(1'b1));
GSR GSR_INST(.GSR(1'b1));


memoryMapper testInstance(
	.CLK(CLK),
	.RESET(RESET),
	.ADDR(ADDR),
	.CPU_DIN(CPU_DIN),
	.RDN(RDN),
	.WR0N(WR0N),
	.WR1N(WR1N),
	.DIN_BUS(DIN_BUS),
	.DIN_ROM(DIN_ROM),
	.DIN_RAM(DIN_RAM),
	.BE0(BE0),
	.BE1(BE1),
	.WR_RAM(WR_RAM),
	.EN_RAM(EN_RAM),
	.DIN_UART(DIN_UART),
	.WR_UART(WR_UART),
	.RD_UART(RD_UART),
	.ADDR_UART(ADDR_UART),
	
	.DIN_INT(DIN_INT),
	.WR_INT(WR_INT),
	.RD_INT(RD_INT),
	.ADDR_INT(ADDR_INT)
);

// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 0; 
	`TICK;
	RESET       = 1;
	RDN         = 1;
	WR0N        = 1;
	WR1N        = 1;
	DIN_BUS     = 16'hbbbb;
	DIN_ROM     = 16'h1111;
	DIN_RAM     = 16'haaaa;
	DIN_UART    = 16'hf0f0;
	DIN_INT     = 16'hcccc;
	
	`TICKTOCK;
	#5 RESET = 0;
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	// Writes to ROM space have no effect
	ADDR = 16'h0000;
	WR0N = 0;
	WR1N = 0;
	`TICKTOCK;
	$display("1 --");
	`assert("CPU_DIN", 16'h1111, CPU_DIN)
	`assert("BE0", 0, BE0)
	`assert("BE1", 0, BE1)
	`assert("WR_RAM", 0, WR_RAM)
	`assert("EN_RAM",  0, EN_RAM)
	`assert("WR_UART",0, WR_UART)
	`TICKTOCK;
	// Writes to RAM space affect BE lines
	ADDR = 16'h2000;
	`TICKTOCK;
	$display("2 --");
	`assert("CPU_DIN", 16'haaaa, CPU_DIN)
	`assert("BE0", 1, BE0)
	`assert("BE1", 1, BE1)
	`assert("WR_RAM", 1, WR_RAM)
	`assert("EN_RAM",  1, EN_RAM)
	`assert("WR_UART",0, WR_UART)
	`TICKTOCK;
	
	WR0N = 1;
	`TICKTOCK;
	$display("3 --");
	`assert("CPU_DIN", 16'haaaa, CPU_DIN)
	`assert("BE0", 1, BE0)
	`assert("BE1", 0, BE1)
	`assert("WR_RAM", 1, WR_RAM)
	`assert("EN_RAM",  1, EN_RAM)
	`assert("WR_UART",0, WR_UART)
	`TICKTOCK;
	
	WR1N = 1;
	`TICKTOCK;
	$display("4 --");
	`assert("CPU_DIN", 16'haaaa, CPU_DIN)
	`assert("BE0", 0, BE0)
	`assert("BE1", 0, BE1)
	`assert("WR_RAM", 0, WR_RAM)
	`assert("EN_RAM",  1, EN_RAM)
	`assert("WR_UART",0, WR_UART)
	`TICKTOCK;
	
	// UART READ
	ADDR = 16'hfff0;
	RDN = 0;
	`TICKTOCK;
	$display("5 --");
	`assert("CPU_DIN", 16'hf0f0, CPU_DIN)
	`assert("BE0", 0, BE0)
	`assert("BE1", 0, BE1)
	`assert("WR_RAM", 0, WR_RAM)
	`assert("EN_RAM",  0, EN_RAM)
	`assert("WR_UART",0, WR_UART)
	`TICKTOCK;
	
	
	// UART WRITE
	ADDR = 16'hfff0;
	RDN = 1;
	WR0N = 0;
	WR1N = 0;
	`TICKTOCK;
	$display("6 --");
	`assert("CPU_DIN", 16'hf0f0, CPU_DIN)
	`assert("BE0", 0, BE0)
	`assert("BE1", 0, BE1)
	`assert("WR_RAM", 0, WR_RAM)
	`assert("EN_RAM",  0, EN_RAM)
	`assert("WR_UART",1, WR_UART)
	`TICKTOCK;
	
	// INT Writes
	ADDR = 16'hfff4;
	`TICKTOCK;
	$display("7 --");
	`assert("CPU_DIN", 16'hcccc, CPU_DIN)
	`assert("BE0",     0, BE0)
	`assert("BE1",     0, BE1)
	`assert("WR_RAM",  0, WR_RAM)
	`assert("EN_RAM",  0, EN_RAM)
	`assert("WR_UART", 0, WR_UART)
	`assert("RD_UART", 0, RD_UART)
	`assert("WR_INT",  1, WR_INT)
	`assert("RD_INT",  0, RD_INT)
	`TICKTOCK;
	
	
end

endmodule