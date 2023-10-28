/**
* CPU, RAM and ROM
* UART
* Pin bindings
**/
`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module mcu(
	
	input CLK,
	input RESET,
	
	output wire FETCH, DECODE, EXECUTE, COMMIT,
	
	output reg [15:0] ADDR_BUS,
	inout  wire [15:0] DATA_BUS,

	input INTS0,
	input INTS1,
	input INTS2,
	input INTS3,
	input INTS4,
	input INTS5,
	input INTS6,
	input INTS7,
	
	output reg RDN, 
	output reg WRN0, 
	output reg WRN1,
	
	input RXD,
	output TXD
	
);

wire [15:0] ADDR_BUF;
wire [15:0] DOUT_BUF;
wire [15:0] DIN;


core coreInst(
	
	.CLK(CLK),
	.RESET(RESET),
	
	.FETCH(FETCH), .DECODE(DECODE), .EXECUTE(EXECUTE), .COMMIT(COMMIT),
	
	.ADDR_BUF(ADDR_BUF),
	.DOUT_BUF(DOUT_BUF),
	.DIN(DIN),
	.INT0(INT0),
	.INT1(INT1),
	
	.RDN_BUF(RDN_BUF), 
	.ABUS_OEN(ABUS_OEN),
	.DBUS_OEN(DBUS_OEN),
	.WRN0_BUF(WRN0_BUF), 
	.WRN1_BUF(WRN1_BUF)
);

mcuResources mcuResourcesInst(

	.CLK(CLK),
	.RESET(RESET),
	.ADDR(ADDR_BUF),
	.CPU_DIN(DIN),
	.CPU_DOUT(DOUT_BUF),
	.RDN(RDN_BUF),
	.WR0N(WR0N_BUF),
	.WR1N(WR1N_BUF),
	.DIN_BUS(DATA_BUS),
	
	.UART_RXD(RXD),
	.UART_TXD(TXD),
	
	.INTS0(INTS0),
	.INTS1(INTS1),
	.INTS2(INTS2),
	.INTS3(INTS3),
	.INTS4(INTS4),
	.INTS5(INTS5),
	.INTS6(INTS6),
	.INTS7(INTS7),
	
	.INT0(INT0),
	.INT1(INT1)
	

);


reg [15:0] DBUS;

assign DIN = DATA_BUS;
assign DATA_BUS = DBUS;

always @(*) begin
	if(RESET) begin
		RDN = 1;
		WRN0 = 1;
		WRN1 = 1;
		ADDR_BUS = 16'hZZZZ;
		DBUS = 16'hZZZZ;
	end else begin
		RDN = RDN_BUF;
		WRN0 = WRN0_BUF;
		WRN1 = WRN1_BUF;
		ADDR_BUS = ADDR_BUF;
		DBUS = (WRN0 == 0 | WRN1 == 0) ? 16'hZZZZ : DOUT_BUF;
	end
end

endmodule
