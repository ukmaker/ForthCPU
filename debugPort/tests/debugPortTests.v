`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module debugPortTests;
	
	reg             CLK;
	reg             RESETN;
	wire            RESET;
	reg  [7:0]     DEBUG_DIN;
	wire [7:0]     DEBUG_DOUT;
	reg  [2:0]     DEBUG_ADDR;
	reg             DEBUG_RDN;
	reg             DEBUG_WRN;
	
	wire [3:0]     DEBUG_OP;
	wire [15:0]    DEBUG_ADDR_OUT;
	wire [3:0]     DEBUG_ARGX_OUT;
	wire [15:0]    DEBUG_DATA_OUT;

	reg             DEBUG_ADDR_INC_EN;
	
	reg             DEBUG_LD_DATA_EN;
	reg [1:0]      DEBUG_DATAX;
	reg [15:0]     DEBUG_DIN_DIN;
	reg [15:0]     DEBUG_REGB_DATA;
	reg [15:0]     DEBUG_CC_DATA;
	reg [15:0]     DEBUG_PC_A_NEXT;

	wire            DEBUG_STOP;
	wire            DEBUG_MODE;
	wire            DEBUG_REQ;
	reg             DEBUG_ACK;

	
debugPort testInstance(
	.CLK(CLK),
	.RESET(RESET),
	.RESETN(RESETN),
	.DEBUG_DIN(DEBUG_DIN),
	.DEBUG_DOUT(DEBUG_DOUT),
	.DEBUG_ADDR(DEBUG_ADDR),
	.DEBUG_RDN(DEBUG_RDN),
	.DEBUG_WRN(DEBUG_WRN),
	.DEBUG_OP(DEBUG_OP),
	.DEBUG_ADDR_OUT(DEBUG_ADDR_OUT),
	.DEBUG_ARGX_OUT(DEBUG_ARGX_OUT),
	.DEBUG_DATA_OUT(DEBUG_DATA_OUT),
	.DEBUG_ADDR_INC_EN(DEBUG_ADDR_INC_EN),
	.DEBUG_LD_DATA_EN(DEBUG_LD_DATA_EN),
	.DEBUG_DATAX(DEBUG_DATAX),
	.DEBUG_DIN_DIN(DEBUG_DIN_DIN),
	.DEBUG_REGB_DATA(DEBUG_REGB_DATA),
	.DEBUG_CC_DATA(DEBUG_CC_DATA),
	.DEBUG_PC_A_NEXT(DEBUG_PC_A_NEXT),
	.DEBUG_STOP(DEBUG_STOP),
	.DEBUG_MODE(DEBUG_MODE),
	.DEBUG_REQ(DEBUG_REQ),
	.DEBUG_ACK(DEBUG_ACK)
	
);

`define debugWrite(data, addr) \
	$display("[T=%0t] DEBUG WRITE %02x -> %1x", $realtime, data, addr); \
	DEBUG_ADDR = addr; \
	DEBUG_DIN  = data; \
	DEBUG_WRN   = 1; \
	#400;  \
	DEBUG_WRN   = 0;	\
	#400; \
	DEBUG_WRN   = 1; \
	#400;
	
`define debugReadData(source, expectedH, expectedL, addr) \
	$display("debugReadData(%s, %x %x", source, expectedH, expectedL); \
	DEBUG_DATAX = addr; \
	`debugWrite(`DEBUG_OPX_RD_REG,  `DEBUG_ADDRX_OP) \
	$display("ACK DIN"); \
	DEBUG_ACK = 1; \
	DEBUG_LD_DATA_EN = 1; \
	`TICKTOCK; \
	DEBUG_ACK = 0; \
	DEBUG_LD_DATA_EN = 0; \
	`TICKTOCK;	\
	$display(" - READ DIN"); \
	DEBUG_ADDR = `DEBUG_ADDRX_DL; \
	DEBUG_RDN = 0; \
	#400; \
	`assert("DEBUG_DOUT",         expectedL,           DEBUG_DOUT) \
	DEBUG_RDN = 1; \
	#400; \
	DEBUG_ADDR = `DEBUG_ADDRX_DH; \
	`TICKTOCK; \
	DEBUG_RDN = 0; \
	`TICKTOCK; \
	`assert("DEBUG_DOUT",         expectedH,           DEBUG_DOUT) \
	`TICKTOCK; \
	DEBUG_RDN = 1; \
	`TICKTOCK; \
	`assert("DEBUG_REQ",         0,               DEBUG_REQ ) \
	`TICKTOCK; \
	`TICKTOCK; \
	`assert("DEBUG_REQ",         1,               DEBUG_REQ ) \
	DEBUG_ACK = 1; \
	DEBUG_LD_DATA_EN = 1; \
	`TICKTOCK; \
	DEBUG_ACK = 0; \
	DEBUG_LD_DATA_EN = 0; \
	`TICKTOCK;

always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK              = 0;
	RESETN           = 1;
	DEBUG_DIN        = 8'h00;
	DEBUG_ADDR       = 3'b000;
	DEBUG_RDN        = 1;
	DEBUG_WRN        = 1;
	DEBUG_DIN_DIN    = 16'haabb;
	DEBUG_REGB_DATA  = 16'hbbcc;
	DEBUG_CC_DATA    = 16'hccdd;
	DEBUG_PC_A_NEXT  = 16'hddee;
	DEBUG_LD_DATA_EN   = 1'b0;
	DEBUG_ACK       = 1'b0;
	DEBUG_ADDR_INC_EN  = 1'b0;
	DEBUG_DATAX      = `DEBUG_DATAX_DIN;
	
	`TICKTOCK;
	RESETN = 0;
	`TICKTOCK;
	RESETN = 1;
	`TICKTOCK;
	`assert("DEBUG_DOUT",         8'h00,           DEBUG_DOUT)
	`assert("DEBUG_ADDR_OUT",     16'h0000,        DEBUG_ADDR_OUT )
	`assert("DEBUG_DATA_OUT",     16'h0000,        DEBUG_DATA_OUT)
	`assert("DEBUG_OP",           `DEBUG_OPX_NONE, DEBUG_OP)
	`assert("DEBUG_ARGX_OUT",     4'b0000,         DEBUG_ARGX_OUT)
	`assert("DEBUG_REQ",         0,               DEBUG_REQ)
	`TICKTOCK;
	// Stop the CPU
	`debugWrite(`DEBUG_MODEX_STOP,  `DEBUG_ADDRX_MODE)
	`debugWrite(`DEBUG_OPX_NONE,    `DEBUG_ADDRX_OP)
	`TICKTOCK;
	`TICKTOCK;
	`TICKTOCK;
	
	// Set up a memory write
	// Write data 0x1234 to address 0x5678
	`debugWrite(8'h56,              `DEBUG_ADDRX_AH)
	`debugWrite(8'h78,              `DEBUG_ADDRX_AL)
	`debugWrite(8'h12,              `DEBUG_ADDRX_DH)
	`debugWrite(8'h34,              `DEBUG_ADDRX_DL)
	`debugWrite(`DEBUG_OPX_WR_MEM,  `DEBUG_ADDRX_OP)
	
	`assert("DEBUG_ADDR_OUT", 16'h5678,        DEBUG_ADDR_OUT )
	`assert("DEBUG_DATA_OUT", 16'h1234,        DEBUG_DATA_OUT )
	`TICKTOCK;
	// Increment the address
	DEBUG_ADDR_INC_EN = 1;
	`TICKTOCK;
	DEBUG_ADDR_INC_EN = 0;
	`TICKTOCK;
	`assert("DEBUG_ADDR_OUT", 16'h567a,        DEBUG_ADDR_OUT )
	`assert("DEBUG_DATA_OUT", 16'h1234,        DEBUG_DATA_OUT )

	// Test the data sources
	`debugReadData("DIN",       8'haa, 8'hbb, `DEBUG_DATAX_DIN)
	`debugReadData("REGB_DATA", 8'hbb, 8'hcc, `DEBUG_DATAX_REGB_DATA)
	`debugReadData("CC_DATA",   8'hcc, 8'hdd, `DEBUG_DATAX_CC_DATA)
	`debugReadData("PC_A_NEXT", 8'hdd, 8'hee, `DEBUG_DATAX_PC_A_NEXT)



end

endmodule