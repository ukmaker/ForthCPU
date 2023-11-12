`include "../../constants.v"

module mcuResources(
	input CLK,
	input RESET,
	
	// Interface to the CPU
	input       [15:0] ADDR,
	output      [15:0] CPU_DIN,
	input       [15:0] CPU_DOUT,
	input RDN,
	input WR0N,
	input WR1N,

	// Bus interface
	input  [15:0] DIN_BUS,
	
	// GPIO
	input [15:0] DIN_GPIO,
	output        RD_GPIO,
	output        WR_GPIO,
	output        ADDR_GPIO,
	
	// UART signals
	input  UART_RXD,
	output UART_TXD,
	
	// Interrupt signals
	input INTS0,
	input INTS1,
	input INTS2,
	input INTS3,
	input INTS4,
	input INTS5,
	input INTS6,
	
	output INT0,
	output INT1
);

// Internal connections
wire [15:0] DIN_ROM;
wire [15:0] DIN_RAM;
wire [15:0] DIN_UART;
wire [15:0] DIN_INT;
wire [1:0]  ADDR_UART;
wire [1:0]  ADDR_INT;
wire UART_INT7;

memoryMapper memoryMapperInst(
	
	.RESET(RESET),
	
	// Interface to the CPU
	.ADDR(ADDR),
	.CPU_DIN(CPU_DIN),
	.RDN(RDN),
	.WR0N(WR0N),
	.WR1N(WR1N),
	
	// Bus interface
	.DIN_BUS(DIN_BUS),

	// ROM
	.DIN_ROM(DIN_ROM),
	
	// RAM
	.DIN_RAM(DIN_RAM),
	.BE0(BE0),
	.BE1(BE1),
	.WR_RAM(WR_RAM),
	.EN_RAM(EN_RAM),
	
	// UART
	.DIN_UART(DIN_UART),
	.WR_UART(WR_UART),
	.RD_UART(RD_UART),
	.ADDR_UART(ADDR_UART),
	
	// Interrupt
	.DIN_INT(DIN_INT),
	.WR_INT(WR_INT),
	.RD_INT(RD_INT),
	.ADDR_INT(ADDR_INT),
	
	// GPIO
	.DIN_GPIO(DIN_GPIO),
	.RD_GPIO(RD_GPIO),
	.WR_GPIO(WR_GPIO),
	.ADDR_GPIO(ADDR_GPIO)
);

rom ROMInst(
	.Address({ADDR[10:1], 1'b0}),
	.Q(DIN_ROM)
);

RAM RAMInst(
	.Clock(CLK),
	.ClockEn(EN_RAM),
	.Reset(RESET),
	.ByteEn({BE1,BE0}),
	.WE(WR_RAM),
	.Address({ADDR[12:1], 1'b0}),
	.Data(CPU_DOUT),
	.Q(DIN_RAM)
);

UART UARTInst(
	.CLK(CLK),
	.RESET(RESET),
	.RD(RD_UART),
	.WR(WR_UART),
	.UART_INT(UART_INT7),
	.ADDR(ADDR_UART),
	.DIN(CPU_DOUT),
	.DOUT(DIN_UART),
	.RXD(UART_RXD),
	.TXD(UART_TXD)
);

interruptMaskRegister interruptMaskRegisterInst(
	.CLK(CLK),
	.RESET(RESET),
	.DIN(CPU_DOUT[7:0]),
	.RD(RD_INT),
	.WR(WR_INT),
	.ADDR(ADDR_INT),
	.INTS1(INTS1),
	.INTS2(INTS2),
	.INTS3(INTS3),
	.INTS4(INTS4),
	.INTS5(INTS5),
	.INTS6(INTS6),
	.INTS7(UART_INT7),
	.DOUT(DIN_INT),
	.INT1(INT1)
);

assign INT0 = INTS0;

endmodule