`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module debugPortTests;
	
	/***************************************
	* Interface signals
	****************************************/
	reg [7:0]      DEBUG_DIN;
	reg [3:0]      DEBUG_REG_ADDR;
	reg             DEBUG_RD;
	reg             DEBUG_WR;
	wire [7:0]     DEBUG_DOUT;
	
	/***************************************
	* Global signals
	****************************************/
	reg             CLK;
	reg             RESETN;
	reg             RD;
	reg             WR;
	reg [15:0]     ADDR;
	/**
	* Combined with the DEBUG_MODE_RESET signal
	**/
	wire            RESET;
	
	/***************************************************************
	* Outputs to instruction phase decoder and 
	****************************************************************/
	wire            DEBUG_REQ;
	wire            DEBUG_MODE_STOP;
	wire [1:0]     DEBUG_MODE_DEBUGX;
	/***************************************************************
	* Inputs from the phase decoder
	****************************************************************/
    reg             DEBUG_ACK;           
	
	/***************************************************************
	* Inputs from the debugSequencer
	***************************************************************/
	reg             DEBUG_DATA_OUT_SELX;
	reg             DEBUG_ADDR_INCX;
	reg             DEBUG_SNOOP_LD_EN;
	
	/**************************************************************
	* Watch and breakpoint signals
	**************************************************************/
	wire            DEBUG_BKP_ENX;
	wire            DEBUG_WATCH_ENX;
	wire            DEBUG_IN_WATCH;
	/**************************************************************
	* Watch and breakpoint inputs
	**************************************************************/
	reg             DEBUG_AT_BKP;
	
	/**************************************************************
	* Input buses
	**************************************************************/
	reg [15:0]      DEBUG_DATA_IN;
	reg [15:0]      DEBUG_ADDR_IN;
	
	/**************************************************************
	* Output buses
	**************************************************************/
	wire [15:0]     DEBUG_ADDR_OUT;
	wire [15:0]     DEBUG_DATA_OUT;

debugPort testArticle(

	.DEBUG_DIN(DEBUG_DIN),
	.DEBUG_REG_ADDR(DEBUG_REG_ADDR),
	.DEBUG_WR(DEBUG_WR),
	.DEBUG_RD(DEBUG_RD),
	.DEBUG_DOUT(DEBUG_DOUT),

	.CLK(CLK),
	.RESETN(RESETN),
	.RD(RD),
	.WR(WR),
	.ADDR(ADDR),
	.RESET(RESET),
	
	.DEBUG_REQ(DEBUG_REQ),
	.DEBUG_MODE_STOP(DEBUG_MODE_STOP),
	.DEBUG_MODE_DEBUGX(DEBUG_MODE_DEBUGX),

    .DEBUG_ACK(DEBUG_ACK),           
	
	.DEBUG_DATA_OUT_SELX(DEBUG_DATA_OUT_SELX),
	.DEBUG_ADDR_INCX(DEBUG_ADDR_INCX),
	.DEBUG_SNOOP_LD_EN(DEBUG_SNOOP_LD_EN),

	.DEBUG_BKP_ENX(DEBUG_BKP_ENX),
	.DEBUG_WATCH_ENX(DEBUG_WATCH_ENX),
	.DEBUG_IN_WATCH(DEBUG_IN_WATCH),

	.DEBUG_AT_BKP(DEBUG_AT_BKP),
	
	.DEBUG_DATA_IN(DEBUG_DATA_IN),
	.DEBUG_ADDR_IN(DEBUG_ADDR_IN),

	.DEBUG_ADDR_OUT(DEBUG_ADDR_OUT),
	.DEBUG_DATA_OUT(DEBUG_DATA_OUT)

);

always begin
	#50 CLK = ~CLK;
end

initial begin
	DEBUG_DIN = 8'h00;
	DEBUG_REG_ADDR = 4'h0;
	DEBUG_RD = 1;
	DEBUG_WR = 1;
	CLK = 1;
	RESETN = 1;
	RD = 0;
	WR = 0;
	ADDR = 16'h0000;
	DEBUG_ACK = 0;
	DEBUG_DATA_OUT_SELX = 0;
	DEBUG_ADDR_INCX = 0;
	DEBUG_SNOOP_LD_EN = 0;
	DEBUG_AT_BKP = 0;
	DEBUG_DATA_IN = 16'h0000;
	DEBUG_ADDR_IN = 16'h0000;
	
	`TICKTOCK;
	RESETN = 0;
	`TICKTOCK;
	RESETN = 1;
	`TICKTOCK;
	
	// Write the stop bit
	DEBUG_DIN      = `DEBUG_MODE_STOP;
	DEBUG_REG_ADDR = `DEBUG_REG_MODE;
	`TICKTOCK;
	DEBUG_WR      = 1;
	`TICKTOCK;
	DEBUG_WR      = 0;
	`TICKTOCK;
	`TICKTOCK;
	`sassert(1, "MODE_STOP", 1'b1, DEBUG_MODE_STOP)
	`sassert(2, "DEBUG_REQ", 1'b0, DEBUG_REQ)
	`TICKTOCK;
	
	// Request a normal step
	DEBUG_DIN      = `DEBUG_MODE_STOP | `DEBUG_MODE_REQ | (`DEBUGX_STEP << `DEBUG_MODE_DEBUGX_BIT_POS);
	DEBUG_REG_ADDR = `DEBUG_REG_MODE;
	`TICKTOCK;
	DEBUG_WR      = 1;
	`TICKTOCK;
	DEBUG_WR      = 0;
	`TICKTOCK;
	`TICKTOCK;
	`sassert(3, "MODE_STOP", 1'b1, DEBUG_MODE_STOP)
	`sassert(4, "DEBUG_REQ", 1'b1, DEBUG_REQ)
	`TICKTOCK;
	`sassert(5, "MODE_STOP", 1'b1, DEBUG_MODE_STOP)
	`sassert(6, "DEBUG_REQ", 1'b1, DEBUG_REQ)
	`TICKTOCK;
	`sassert(7, "MODE_STOP", 1'b1, DEBUG_MODE_STOP)
	`sassert(8, "DEBUG_REQ", 1'b1, DEBUG_REQ)
	`TICKTOCK;
	// ACK the REQ
	DEBUG_ACK = 1;
	`TICKTOCK;
	`sassert(9, "MODE_STOP", 1'b1, DEBUG_MODE_STOP)
	`sassert(10, "DEBUG_REQ", 1'b0, DEBUG_REQ)
	DEBUG_ACK = 0;
	`TICKTOCK;
	`sassert(11, "MODE_STOP", 1'b1, DEBUG_MODE_STOP)
	`sassert(12, "DEBUG_REQ", 1'b0, DEBUG_REQ)
	`TICKTOCK;
	
	// Write a CPU instruction with argument
	DEBUG_DIN      = 8'h37;
	DEBUG_REG_ADDR = `DEBUG_REG_OP_ARG;
	`TICKTOCK;
	DEBUG_WR      = 1;
	`TICKTOCK;
	DEBUG_WR      = 0;
	`TICKTOCK;	
	
	DEBUG_DIN      = 8'h59;
	DEBUG_REG_ADDR = `DEBUG_REG_OP_INST;
	`TICKTOCK;
	DEBUG_WR      = 1;
	`TICKTOCK;
	DEBUG_WR      = 0;
	`TICKTOCK;	
	
	// Write some data
	DEBUG_DIN      = 8'h34;
	DEBUG_REG_ADDR = `DEBUG_REG_DL;
	`TICKTOCK;
	DEBUG_WR      = 1;
	`TICKTOCK;
	DEBUG_WR      = 0;
	`TICKTOCK;	
	
	DEBUG_DIN      = 8'h12;
	DEBUG_REG_ADDR = `DEBUG_REG_DH;
	`TICKTOCK;
	DEBUG_WR      = 1;
	`TICKTOCK;
	DEBUG_WR      = 0;
	`TICKTOCK;	
	// Now check the output
	DEBUG_DATA_OUT_SELX = `DEBUG_DATA_OUT_SELX_INST;
	`sassert(13, "INST", 16'h5937, DEBUG_DATA_OUT)
	`TICKTOCK;
	DEBUG_DATA_OUT_SELX = `DEBUG_DATA_OUT_SELX_DATA;
	`TICKTOCK;
	`sassert(14, "DATA", 16'h1234, DEBUG_DATA_OUT)
	`TICKTOCK;
	
	// Check the address
	`sassert(15, "ADDR", 16'h0000, DEBUG_ADDR_OUT)
	// Increment it
	`TICKTOCK;
	DEBUG_ADDR_INCX = 1;
	`TICKTOCK;
	DEBUG_ADDR_INCX = 0;
	`TICKTOCK;
	`sassert(16, "ADDR", 16'h0002, DEBUG_ADDR_OUT)
	`TICKTOCK;
	
	// Set the start watch address
	DEBUG_DIN      = 8'h32;
	DEBUG_REG_ADDR = `DEBUG_REG_WATCH_STARTL;
	`TICKTOCK;
	DEBUG_WR      = 1;
	`TICKTOCK;
	DEBUG_WR      = 0;
	`TICKTOCK;	

	DEBUG_DIN      = 8'h54;
	DEBUG_REG_ADDR = `DEBUG_REG_WATCH_STARTH;
	`TICKTOCK;
	DEBUG_WR      = 1;
	`TICKTOCK;
	DEBUG_WR      = 0;
	`TICKTOCK;	

	// Set the end watch address
	DEBUG_DIN      = 8'h55;
	DEBUG_REG_ADDR = `DEBUG_REG_WATCH_ENDL;
	`TICKTOCK;
	DEBUG_WR      = 1;
	`TICKTOCK;
	DEBUG_WR      = 0;
	`TICKTOCK;	

	DEBUG_DIN      = 8'h54;
	DEBUG_REG_ADDR = `DEBUG_REG_WATCH_ENDH;
	`TICKTOCK;
	DEBUG_WR      = 1;
	`TICKTOCK;
	DEBUG_WR      = 0;
	`TICKTOCK;	
	
	// And the breakpoint address
	DEBUG_DIN      = 8'h77;
	DEBUG_REG_ADDR = `DEBUG_REG_BKP_AL;
	`TICKTOCK;
	DEBUG_WR      = 1;
	`TICKTOCK;
	DEBUG_WR      = 0;
	`TICKTOCK;	

	DEBUG_DIN      = 8'h66;
	DEBUG_REG_ADDR = `DEBUG_REG_BKP_AH;
	`TICKTOCK;
	DEBUG_WR      = 1;
	`TICKTOCK;
	DEBUG_WR      = 0;
	`TICKTOCK;	
	
	// Run some address cycles
	`sassert(17, "DEBUG_IN_WATCH", 0, DEBUG_IN_WATCH)
	`sassert(18, "DEBUG_AT_BKP",   0, DEBUG_AT_BKP)
	`TICKTOCK;
	DEBUG_ADDR_IN = 16'h5432;
	`TICKTOCK;
	`sassert(19, "DEBUG_IN_WATCH", 0, DEBUG_IN_WATCH)
	`sassert(20, "DEBUG_AT_BKP",   0, DEBUG_AT_BKP)
	DEBUG_ADDR_IN = 16'h6677;
	`TICKTOCK;
	`sassert(19, "DEBUG_IN_WATCH", 0, DEBUG_IN_WATCH)
	`sassert(20, "DEBUG_AT_BKP",   0, DEBUG_AT_BKP)

	// Now enable watches and BKP
	DEBUG_ADDR_IN = 16'h0000;
	`TICKTOCK;
	`sassert(21, "DEBUG_IN_WATCH", 0, DEBUG_IN_WATCH)
	`sassert(22, "DEBUG_AT_BKP",   0, DEBUG_AT_BKP)
	DEBUG_DIN      = `DEBUG_MODE_STOP 
						| `DEBUG_MODE_REQ 
						| (`DEBUGX_STEP << `DEBUG_MODE_DEBUGX_BIT_POS) 
						| `DEBUG_MODE_EN_BKP 
						| `DEBUG_MODE_EN_WATCH;
						
	DEBUG_REG_ADDR = `DEBUG_REG_MODE;
	`TICKTOCK;
	DEBUG_WR      = 1;
	`TICKTOCK;
	DEBUG_WR      = 0;
	`TICKTOCK;
	
	// Run some address cycles
	`sassert(23, "DEBUG_IN_WATCH", 0, DEBUG_IN_WATCH)
	`sassert(24, "DEBUG_AT_BKP",   0, DEBUG_AT_BKP)
	`TICKTOCK;
	DEBUG_ADDR_IN = 16'h5432;
	`TICKTOCK;
	`sassert(25, "DEBUG_IN_WATCH", 1, DEBUG_IN_WATCH)
	`sassert(26, "DEBUG_AT_BKP",   0, DEBUG_AT_BKP)
	DEBUG_ADDR_IN = 16'h5436;
	`TICKTOCK;
	`sassert(25, "DEBUG_IN_WATCH", 1, DEBUG_IN_WATCH)
	`sassert(26, "DEBUG_AT_BKP",   0, DEBUG_AT_BKP)
	DEBUG_ADDR_IN = 16'h5455;
	`TICKTOCK;
	`sassert(25, "DEBUG_IN_WATCH", 1, DEBUG_IN_WATCH)
	`sassert(26, "DEBUG_AT_BKP",   0, DEBUG_AT_BKP)
	DEBUG_ADDR_IN = 16'h5456;
	`TICKTOCK;
	`sassert(25, "DEBUG_IN_WATCH", 0, DEBUG_IN_WATCH)
	`sassert(26, "DEBUG_AT_BKP",   0, DEBUG_AT_BKP)

	DEBUG_ADDR_IN = 16'h6677;
	`TICKTOCK;
	`sassert(27, "DEBUG_IN_WATCH", 0, DEBUG_IN_WATCH)
	`sassert(28, "DEBUG_AT_BKP",   1, DEBUG_AT_BKP)

	
	
end

endmodule
	