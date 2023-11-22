`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module debugPortTests;
	
	reg             CLK;
	reg             RESET;
	reg  [7:0]     DEBUG_DIN;
	wire [7:0]     DEBUG_DOUT;
	reg  [2:0]     DEBUG_ADDR;
	reg             DEBUG_RD;
	reg             DEBUG_WR;
	
	wire [15:0]    DEBUG_MEM_ADDR;
	wire [15:0]    DEBUG_MEM_DATA_OUT;

	reg             DEBUG_ADDR_INCX;
	reg             DEBUG_ADDR_LDX;
	wire            DEBUG_STOPX;
	wire            DEBUG_REQX;
	reg             DEBUG_ACKX;

	wire [2:0]     DEBUG_OPX;
	wire [3:0]     DEBUG_REGX;
	wire [1:0]     DEBUG_PC_NEXTX;
	wire [1:0]     DEBUG_CC_REGX;
	
	reg [15:0]     DEBUG_DIN_DIN;
	reg [15:0]     DEBUG_REGA_DATA;
	reg [15:0]     DEBUG_CC_DATA;
	reg [15:0]     DEBUG_PC_A_NEXT;
	reg             DEBUG_DOUT_LDX;
	
debugPort testInstance(
	.CLK(CLK),
	.RESET(RESET),
	.DEBUG_DIN(DEBUG_DIN),
	.DEBUG_DOUT(DEBUG_DOUT),
	.DEBUG_ADDR(DEBUG_ADDR),
	.DEBUG_RD(DEBUG_RD),
	.DEBUG_WR(DEBUG_WR),
	.DEBUG_MEM_ADDR(DEBUG_MEM_ADDR),
	.DEBUG_MEM_DATA_OUT(DEBUG_MEM_DATA_OUT),
	.DEBUG_ADDR_INCX(DEBUG_ADDR_INCX),
	.DEBUG_ADDR_LDX(DEBUG_ADDR_LDX),
	.DEBUG_STOPX(DEBUG_STOPX),
	.DEBUG_REQX(DEBUG_REQX),
	.DEBUG_ACKX(DEBUG_ACKX),
	.DEBUG_OPX(DEBUG_OPX),
	.DEBUG_REGX(DEBUG_REGX),
	.DEBUG_PC_NEXTX(DEBUG_PC_NEXTX),
	.DEBUG_CC_REGX(DEBUG_CC_REGX),
	.DEBUG_DIN_DIN(DEBUG_DIN_DIN),
	.DEBUG_REGA_DATA(DEBUG_REGA_DATA),
	.DEBUG_CC_DATA(DEBUG_CC_DATA),
	.DEBUG_PC_A_NEXT(DEBUG_PC_A_NEXT),
	.DEBUG_DOUT_LDX(DEBUG_DOUT_LDX)
);

`define debugWrite(data, addr) \
	$display("[T=%0t] DEBUG WRITE %02x -> %1x", $realtime, data, addr); \
	DEBUG_ADDR = addr; \
	DEBUG_DIN  = data; \
	DEBUG_WR   = 0; \
	#400;  \
	DEBUG_WR   = 1;	\
	#400; \
	DEBUG_WR   = 0; \
	#400;

always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK              = 0;
	RESET            = 0;
	DEBUG_DIN        = 8'h00;
	DEBUG_ADDR       = 3'b000;
	DEBUG_RD         = 0;
	DEBUG_WR         = 0;
	DEBUG_DIN_DIN    = 16'haabb;
	DEBUG_REGA_DATA  = 16'hbbcc;
	DEBUG_CC_DATA    = 16'hccdd;
	DEBUG_PC_A_NEXT  = 16'hddee;
	DEBUG_DOUT_LDX   = 1'b0;
	DEBUG_ACKX       = 1'b0;
	DEBUG_ADDR_INCX  = 1'b0;
	DEBUG_ADDR_LDX   = 1'b0;

	
	`TICKTOCK;
	RESET = 1;
	`TICKTOCK;
	RESET = 0;
	`TICKTOCK;
	`assert("DEBUG_DOUT",         8'h00,           DEBUG_DOUT)
	`assert("DEBUG_MEM_ADDR",     16'h0000,        DEBUG_MEM_ADDR )
	`assert("DEBUG_MEM_DATA_OUT", 16'h0000,        DEBUG_MEM_DATA_OUT)
	`assert("DEBUG_OPX",          `DEBUG_OPX_NONE, DEBUG_OPX)
	`assert("DEBUG_REGX",         `R0,             DEBUG_REGX)
	`assert("DEBUG_PC_NEXTX",     `PC_NEXTX_NEXT,  DEBUG_PC_NEXTX)
	`assert("DEBUG_CC_REGX",      `CC_REGX_RUN,    DEBUG_CC_REGX)
	`assert("DEBUG_STOPX",        `DEBUG_STOPX_RUN,DEBUG_STOPX)
	`TICKTOCK;
	// Stop the CPU
	`debugWrite(`DEBUG_STOPX_STOP,`DEBUG_ADDRX_STOP)
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	`assert("DEBUG_STOPX",        `DEBUG_STOPX_STOP,DEBUG_STOPX)
	
	// Set up a memory write
	// Write data 0x1234 to address 0x5678
	`debugWrite(8'h56,              `DEBUG_ADDRX_MAH)
	`debugWrite(8'h78,              `DEBUG_ADDRX_MAL)
	`debugWrite(8'h12,              `DEBUG_ADDRX_MDH)
	`debugWrite(8'h34,              `DEBUG_ADDRX_MDL)
	`debugWrite(`DEBUG_OPX_WR_MEM,  `DEBUG_ADDRX_OPX)
	
	// Load the memory address counters
	DEBUG_ADDR_LDX = 1;
	`TICKTOCK;
	DEBUG_ADDR_LDX = 0;
	`TICKTOCK;
	`assert("DEBUG_MEM_ADDR",     16'h5678,        DEBUG_MEM_ADDR )
	`assert("DEBUG_MEM_DATA_OUT", 16'h1234,        DEBUG_MEM_DATA_OUT )
	`TICKTOCK;
	// Increment the address
	DEBUG_ADDR_INCX = 1;
	`TICKTOCK;
	DEBUG_ADDR_INCX = 0;
	`TICKTOCK;
	`assert("DEBUG_MEM_ADDR",     16'h567a,        DEBUG_MEM_ADDR )
	`assert("DEBUG_MEM_DATA_OUT", 16'h1234,        DEBUG_MEM_DATA_OUT )


	// Test the data type register
	$display("TEST DTYPE");
	`debugWrite(8'b10100111,   `DEBUG_ADDRX_SOURCEX)
	`assert("DEBUG_REGX",     4'b1010, DEBUG_REGX)
	`assert("DEBUG_PC_NEXTX", 2'b01,   DEBUG_PC_NEXTX)
	`assert("DEBUG_CC_REGX",  2'b11,   DEBUG_CC_REGX)



	// Test the data sources
	$display("TEST DIN");
	`debugWrite(`DEBUG_DATAX_DIN,   `DEBUG_ADDRX_DATAX)
	`debugWrite(`DEBUG_OPX_RD_REG,  `DEBUG_ADDRX_OPX)
	$display("ACK DIN");
	// simulate an ACK cycle
	DEBUG_ACKX = 1;
	DEBUG_DOUT_LDX = 1;
	`TICKTOCK;
	DEBUG_ACKX = 0;
	DEBUG_DOUT_LDX = 0;
	`TICKTOCK;	
	$display("READ DIN");
	// Now do a debug read
	DEBUG_ADDR = `DEBUG_ADDRX_MDL;
	DEBUG_RD = 1;
	#400;
	`assert("DEBUG_DOUT",         8'hbb,           DEBUG_DOUT)
	DEBUG_RD = 0;
	#400;
	DEBUG_ADDR = `DEBUG_ADDRX_MDH;
	`TICKTOCK;
	DEBUG_RD = 1;
	`TICKTOCK;
	`assert("DEBUG_DOUT",         8'haa,           DEBUG_DOUT)
	`TICKTOCK;
	DEBUG_RD = 0;
	`TICKTOCK;
	`assert("DEBUG_REQX",         0,               DEBUG_REQX )
	`TICKTOCK;
	`TICKTOCK;
	`assert("DEBUG_REQX",         1,               DEBUG_REQX )
	// simulate an ACK cycle
	DEBUG_ACKX = 1;
	DEBUG_DOUT_LDX = 1;
	`TICKTOCK;
	DEBUG_ACKX = 0;
	DEBUG_DOUT_LDX = 0;
	`TICKTOCK;
	
	
	// Test the data sources
	$display("TEST DIN");
	`debugWrite(`DEBUG_DATAX_REGA_DATA,   `DEBUG_ADDRX_DATAX)
	`debugWrite(`DEBUG_OPX_RD_REG,        `DEBUG_ADDRX_OPX)
	$display("ACK DIN");
	// simulate an ACK cycle
	DEBUG_ACKX = 1;
	DEBUG_DOUT_LDX = 1;
	`TICKTOCK;
	DEBUG_ACKX = 0;
	DEBUG_DOUT_LDX = 0;
	`TICKTOCK;	
	$display("READ DIN");
	// Now do a debug read
	DEBUG_ADDR = `DEBUG_ADDRX_MDL;
	DEBUG_RD = 1;
	#400;
	`assert("DEBUG_DOUT",         8'hcc,           DEBUG_DOUT)
	DEBUG_RD = 0;
	#400;
	DEBUG_ADDR = `DEBUG_ADDRX_MDH;
	`TICKTOCK;
	DEBUG_RD = 1;
	`TICKTOCK;
	`assert("DEBUG_DOUT",         8'hbb,           DEBUG_DOUT)
	`TICKTOCK;
	DEBUG_RD = 0;
	`TICKTOCK;
	`assert("DEBUG_REQX",         0,               DEBUG_REQX )
	`TICKTOCK;
	`TICKTOCK;
	`assert("DEBUG_REQX",         1,               DEBUG_REQX )
	// simulate an ACK cycle
	DEBUG_ACKX = 1;
	DEBUG_DOUT_LDX = 1;
	`TICKTOCK;
	DEBUG_ACKX = 0;
	DEBUG_DOUT_LDX = 0;
	`TICKTOCK;
	

	
	
	// Test the data sources
	$display("TEST DIN");
	`debugWrite(`DEBUG_DATAX_CC_DATA,   `DEBUG_ADDRX_DATAX)
	`debugWrite(`DEBUG_OPX_RD_REG,        `DEBUG_ADDRX_OPX)
	$display("ACK DIN");
	// simulate an ACK cycle
	DEBUG_ACKX = 1;
	DEBUG_DOUT_LDX = 1;
	`TICKTOCK;
	DEBUG_ACKX = 0;
	DEBUG_DOUT_LDX = 0;
	`TICKTOCK;	
	$display("READ DIN");
	// Now do a debug read
	DEBUG_ADDR = `DEBUG_ADDRX_MDL;
	DEBUG_RD = 1;
	#400;
	`assert("DEBUG_DOUT",         8'hdd,           DEBUG_DOUT)
	DEBUG_RD = 0;
	#400;
	DEBUG_ADDR = `DEBUG_ADDRX_MDH;
	`TICKTOCK;
	DEBUG_RD = 1;
	`TICKTOCK;
	`assert("DEBUG_DOUT",         8'hcc,           DEBUG_DOUT)
	`TICKTOCK;
	DEBUG_RD = 0;
	`TICKTOCK;
	`assert("DEBUG_REQX",         0,               DEBUG_REQX )
	`TICKTOCK;
	`TICKTOCK;
	`assert("DEBUG_REQX",         1,               DEBUG_REQX )
	// simulate an ACK cycle
	DEBUG_ACKX = 1;
	DEBUG_DOUT_LDX = 1;
	`TICKTOCK;
	DEBUG_ACKX = 0;
	DEBUG_DOUT_LDX = 0;
	`TICKTOCK;
	


	
	
	// Test the data sources
	$display("TEST DIN");
	`debugWrite(`DEBUG_DATAX_PC_A_NEXT,   `DEBUG_ADDRX_DATAX)
	`debugWrite(`DEBUG_OPX_RD_REG,        `DEBUG_ADDRX_OPX)
	$display("ACK DIN");
	// simulate an ACK cycle
	DEBUG_ACKX = 1;
	DEBUG_DOUT_LDX = 1;
	`TICKTOCK;
	DEBUG_ACKX = 0;
	DEBUG_DOUT_LDX = 0;
	`TICKTOCK;	
	$display("READ DIN");
	// Now do a debug read
	DEBUG_ADDR = `DEBUG_ADDRX_MDL;
	DEBUG_RD = 1;
	#400;
	`assert("DEBUG_DOUT",         8'hee,           DEBUG_DOUT)
	DEBUG_RD = 0;
	#400;
	DEBUG_ADDR = `DEBUG_ADDRX_MDH;
	`TICKTOCK;
	DEBUG_RD = 1;
	`TICKTOCK;
	`assert("DEBUG_DOUT",         8'hdd,           DEBUG_DOUT)
	`TICKTOCK;
	DEBUG_RD = 0;
	`TICKTOCK;
	`assert("DEBUG_REQX",         0,               DEBUG_REQX )
	`TICKTOCK;
	`TICKTOCK;
	`assert("DEBUG_REQX",         1,               DEBUG_REQX )
	// simulate an ACK cycle
	DEBUG_ACKX = 1;
	DEBUG_DOUT_LDX = 1;
	`TICKTOCK;
	DEBUG_ACKX = 0;
	DEBUG_DOUT_LDX = 0;
	`TICKTOCK;
	

	

end

endmodule