`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module busInterfaceTests;
	
	/****************************************
	* Control signals
	*****************************************/
	reg  CLK;
	reg  RESET;
	reg  STOPPED;
	reg  FETCH; 
	reg  DECODE; 
	reg  EXECUTE;
    reg  COMMIT;
	reg  [2:0] BUS_SEQX;
	
	/****************************************
	* Signals to/from the CPU
	*****************************************/
	wire [15:0] CPU_DIN;
	reg  [15:0] CPU_ADDR;
	reg  [15:0] CPU_DOUT;
	reg          CPU_BYTEX;
	
	/****************************************
	* Signals to/from the pin buffers
	*****************************************/
	wire RD_BUF;
	wire WR0_BUF;
	wire WR1_BUF;
	
	wire [15:0] ADDR_BUF;
	wire [15:0] DOUT_BUF;
	reg  [15:0] DIN_BUF;
	
	/****************************************
	* Signals to/from the debugPort
	*****************************************/
	reg DEBUG_DEBUG;
	reg DEBUG_STOP;
	wire DEBUG_RD;
	wire DEBUG_WR;
	wire DEBUG_DATA_SELX;
	wire [15:0] DEBUG_DIN;
	reg  [15:0] DEBUG_DOUT;
	reg  [15:0] DEBUG_ADDR;
	
busInterface testArticle(
	/****************************************
	* Control signals
	*****************************************/
    .CLK(CLK),
    .RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
    .COMMIT(COMMIT),
    .BUS_SEQX(BUS_SEQX),
	
	/****************************************
	* Signals to/from the CPU
	*****************************************/
    .CPU_DIN(CPU_DIN),
    .CPU_ADDR(CPU_ADDR),
    .CPU_DOUT(CPU_DOUT),
    .CPU_BYTEX(CPU_BYTEX),
	
	/****************************************
	* Signals to/from the pin buffers
	*****************************************/
    .RD_BUF(RD_BUF),
    .WR0_BUF(WR0_BUF),
    .WR1_BUF(WR1_BUF),
	
    .ADDR_BUF(ADDR_BUF),
    .DOUT_BUF(DOUT_BUF),
    .DIN_BUF(DIN_BUF),
	
	/****************************************
	* Signals to/from the debugPort
	*****************************************/
	.DEBUG_DEBUG(DEBUG_DEBUG),
	.DEBUG_STOP(DEBUG_STOP),
    .DEBUG_RD(DEBUG_RD),
    .DEBUG_WR(DEBUG_WR),
    .DEBUG_DATA_SELX(DEBUG_DATA_SELX),
    .DEBUG_DIN(DEBUG_DIN),
    .DEBUG_DOUT(DEBUG_DOUT),
    .DEBUG_ADDR(DEBUG_ADDR)
);


always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 1;
	RESET = 1;
	BUS_SEQX = `BUS_SEQX_IDLE;
	CPU_ADDR    = 16'h1111;
	CPU_DOUT    = 16'h2222;
	CPU_BYTEX   = 1'b0;
	DIN_BUF     = 16'h3333;
	DEBUG_DEBUG = 1'b0;
	DEBUG_STOP  = 1'b0;
	DEBUG_DOUT  = 16'h4444;
	DEBUG_ADDR  = 16'h5555;
	FETCH       = 1'b0;
	DECODE      = 1'b0;
	EXECUTE     = 1'b0;
	COMMIT      = 1'b0;
	#10;
	`TICKTOCK;
	RESET       = 1'b0;
	COMMIT      = 1'b0;
	FETCH       = 1'b1;
	`TICKTOCK;
	FETCH      = 1'b0;
	DECODE       = 1'b1;
	`TICKTOCK;
	DECODE      = 1'b0;
	EXECUTE       = 1'b1;
	`TICKTOCK;
	EXECUTE      = 1'b0;
	COMMIT       = 1'b1;
	`TICKTOCK;
	COMMIT      = 1'b0;
	FETCH       = 1'b1;
	`TICKTOCK;
	FETCH      = 1'b0;
	DECODE       = 1'b1;
	`TICKTOCK;
	DECODE      = 1'b0;
	EXECUTE       = 1'b1;
	`TICKTOCK;
	EXECUTE      = 1'b0;
	COMMIT       = 1'b1;
	BUS_SEQX    = `BUS_SEQX_IDLE;
	`TICKTOCK;
	COMMIT      = 1'b0;
	FETCH       = 1'b1;
	`TICKTOCK;
	FETCH      = 1'b0;
	DECODE       = 1'b1;
	`TICKTOCK;
	DECODE      = 1'b0;
	EXECUTE       = 1'b1;
	`TICKTOCK;
	EXECUTE      = 1'b0;
	COMMIT       = 1'b1;
	BUS_SEQX    = `BUS_SEQX_ARGRD;
	`TICKTOCK;
	COMMIT      = 1'b0;
	FETCH       = 1'b1;
	`TICKTOCK;
	FETCH      = 1'b0;
	DECODE       = 1'b1;
	`TICKTOCK;
	DECODE      = 1'b0;
	EXECUTE       = 1'b1;
	`TICKTOCK;
	EXECUTE      = 1'b0;
	COMMIT       = 1'b1;
	BUS_SEQX    = `BUS_SEQX_ARGWR;
	`TICKTOCK;

    // Now run debug cycles
	`TICKTOCK;
	COMMIT      = 1'b0;
	FETCH       = 1'b1;
	`TICKTOCK;
	FETCH       = 1'b0;
	DECODE      = 1'b1;
	DEBUG_DEBUG = 1'b1;
	DEBUG_STOP  = 1'b1;
	`TICKTOCK;
	DECODE      = 1'b0;
	EXECUTE       = 1'b1;
	`TICKTOCK;
	EXECUTE      = 1'b0;
	COMMIT       = 1'b1;
	BUS_SEQX    = `BUS_SEQX_IDLE;
	`TICKTOCK;
	COMMIT      = 1'b0;
	FETCH       = 1'b1;
	`TICKTOCK;
	FETCH      = 1'b0;
	DECODE       = 1'b1;
	`TICKTOCK;
	DECODE      = 1'b0;
	EXECUTE       = 1'b1;
	`TICKTOCK;
	EXECUTE      = 1'b0;
	COMMIT       = 1'b1;
	BUS_SEQX    = `BUS_SEQX_ARGRD;
	`TICKTOCK;
	COMMIT      = 1'b0;
	FETCH       = 1'b1;
	`TICKTOCK;
	FETCH      = 1'b0;
	DECODE       = 1'b1;
	`TICKTOCK;
	DECODE      = 1'b0;
	EXECUTE       = 1'b1;
	`TICKTOCK;
	EXECUTE      = 1'b0;
	COMMIT       = 1'b1;
	BUS_SEQX    = `BUS_SEQX_ARGWR;
	`TICKTOCK;
	COMMIT      = 1'b0;
	FETCH       = 1'b1;
	`TICKTOCK;	
	`TICKTOCK;
	FETCH      = 1'b0;
	DECODE       = 1'b1;
	`TICKTOCK;
	DECODE      = 1'b0;
	EXECUTE       = 1'b1;
	`TICKTOCK;
	EXECUTE      = 1'b0;
	COMMIT       = 1'b1;
	`TICKTOCK;
	COMMIT      = 1'b0;
	FETCH       = 1'b1;
	`TICKTOCK;


end
	
endmodule