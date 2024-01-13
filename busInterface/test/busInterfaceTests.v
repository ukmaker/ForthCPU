`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module busInterfaceTests;

	
	/****************************************
	* Control signals
	*****************************************/
	reg CLK;
	reg RESET;
	reg FETCH; 
	reg DECODE; 
	reg EXECUTE; 
	reg COMMIT;
	reg [2:0] BUS_SEQX;
	
	/****************************************
	* Signals to/from the CPU
	*****************************************/
	// Data
	reg  [1:0]   DATA_BUSX;
	reg  [15:0]  ALU_R;
	reg  [15:0]  REGA_DOUT;
	reg  [3:0]   CCREGS_DOUT;
	wire [15:0]  CPU_DIN;
	
	// Addresses
	reg          BYTEX;
	reg [2:0]   ADDR_BUSX;
	
	reg [15:0]  PC_A;
	//reg [15:0]  ALU_R;
	reg [15:0]  REGB_DOUT;
	reg [15:0]  HERE;
	
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
	reg          DEBUG_MODE_STOP;
	reg          DEBUG_MODE_DEBUGX;
	wire         DEBUG_RD;
	wire         DEBUG_WR;
	wire         DEBUG_DATA_OUT_SELX;
	wire [15:0] DEBUG_DIN;
	reg  [15:0] DEBUG_DOUT;
	reg  [15:0] DEBUG_ADDR;
	
busInterface testInstance(

	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH), 
	.DECODE(DECODE), 
	.EXECUTE(EXECUTE), 
	.COMMIT(COMMIT),
	.BUS_SEQX(BUS_SEQX),
	
	.DATA_BUSX(DATA_BUSX),
	
	.ALU_R(ALU_R),
	.REGA_DOUT(REGA_DOUT),
	.CCREGS_DOUT(CCREGS_DOUT),
	.CPU_DIN(CPU_DIN),
	
	.BYTEX(BYTEX),
	.ADDR_BUSX(ADDR_BUSX),
	.PC_A(PC_A),
	.REGB_DOUT(REGB_DOUT),
	.HERE(HERE),
	
	.RD_BUF(RD_BUF),
	.WR0_BUF(WR0_BUF),
	.WR1_BUF(WR1_BUF),
	
	.ADDR_BUF(ADDR_BUF),
	.DOUT_BUF(DOUT_BUF),
	.DIN_BUF(DIN_BUF),
	
	.DEBUG_MODE_STOP(DEBUG_MODE_STOP),
	.DEBUG_MODE_DEBUGX(DEBUG_MODE_DEBUGX),
	.DEBUG_RD(DEBUG_RD),
	.DEBUG_WR(DEBUG_WR),
	.DEBUG_DATA_OUT_SELX(DEBUG_DATA_OUT_SELX),
	.DEBUG_DIN(DEBUG_DIN),
	.DEBUG_DOUT(DEBUG_DOUT),
	.DEBUG_ADDR(DEBUG_ADDR)
	);
	
always begin
	#50 CLK = ~CLK;
end

initial begin
	FETCH = 0;
	DECODE = 0;
	EXECUTE = 0;
	COMMIT = 0;
	DATA_BUSX = `DATA_BUSX_REGA_DOUT;
	ALU_R = 16'haaaa;
	REGA_DOUT = 16'h1234;
	CCREGS_DOUT = 4'hc;
	BYTEX = 1'b0;
	ADDR_BUSX = `ADDR_BUSX_PC_A;
	DIN_BUF = 16'h8989;
	
	PC_A = 16'heeee;
	REGB_DOUT = 16'hbbbb;
	HERE = 16'heef0;
	
	DEBUG_MODE_STOP   = 1'b0;
	DEBUG_MODE_DEBUGX = 1'b0;
	DEBUG_DOUT        = 16'h5678;
	DEBUG_ADDR        = 16'h8765;
	
	CLK = 1;
	RESET = 1;
	
	// IDLE
	`mark(0)
	BUS_SEQX = `BUS_SEQX_IDLE;	
	`TICKTOCK;
	#10;
	RESET = 0;
	FETCH = 1;
	`TICKTOCK;
	`step(1,"FETCH")
	`asserth("ADDR_BUF", 16'heeee, ADDR_BUF)
	`asserth("DOUT_BUF", 16'h1234, DOUT_BUF)
	`asserth("CPU_DIN",  16'h8989, CPU_DIN)
	`assert( "RD_BUF",   1'b0,     RD_BUF)
	`assert( "WR0_BUF",  1'b0,     WR0_BUF)
	`assert( "WR1_BUF",  1'b0,     WR1_BUF)
	
	FETCH = 0; DECODE = 1;
	`TICK;       
	REGA_DOUT = 16'hdddd; 
	`TOCK;       
	`step(1,"DECODE")
	`asserth("ADDR_BUF", 16'heeee, ADDR_BUF)
	`asserth("DOUT_BUF", 16'hdddd, DOUT_BUF)
	
	DECODE = 0;  EXECUTE = 1; 
	`TICK;
	`assert( "RD_BUF",   1'b0,     RD_BUF) 
	`TOCK;
	`step(1,"EXECUTE")
		
	EXECUTE = 0; COMMIT = 1;  
	`TICKTOCK;   
	`step(1,"COMMIT")
	`asserth("ADDR_BUF", 16'heeee, ADDR_BUF)
	`asserth("DOUT_BUF", 16'hdddd, DOUT_BUF)
	`asserth("CPU_DIN",  16'h8989, CPU_DIN)
	`assert( "RD_BUF",   1'b0,     RD_BUF)
	`assert( "WR0_BUF",  1'b0,     WR0_BUF)
	`assert( "WR1_BUF",  1'b0,     WR1_BUF)

	
	COMMIT = 0; FETCH = 1;	
	`TICKTOCK;   
	`step(2,"FETCH")
	`asserth("ADDR_BUF", 16'heeee, ADDR_BUF)
	`asserth("DOUT_BUF", 16'hdddd, DOUT_BUF)
	`asserth("CPU_DIN",  16'h8989, CPU_DIN)
	`assert( "RD_BUF",   1'b0,     RD_BUF)
	`assert( "WR0_BUF",  1'b0,     WR0_BUF)
	`assert( "WR1_BUF",  1'b0,     WR1_BUF)
	FETCH = 0; DECODE = 1;
	`TICKTOCK;   
	`step(2,"DECODE")
	BUS_SEQX = `BUS_SEQX_ARGRD;	
	DECODE = 0;  EXECUTE = 1; 
	`TICKTOCK;   
	`step(2,"EXECUTE")
	EXECUTE = 0; COMMIT = 1;  
	`TICK;
	`step(2,"COMMIT")
	`asserth("ADDR_BUF", 16'heeee, ADDR_BUF)
	`asserth("DOUT_BUF", 16'hdddd, DOUT_BUF)
	`asserth("CPU_DIN",  16'h8989, CPU_DIN)
	`assert( "RD_BUF",   1'b1,     RD_BUF)
	`assert( "WR0_BUF",  1'b0,     WR0_BUF)
	`assert( "WR1_BUF",  1'b0,     WR1_BUF)
	`TOCK;
	
	COMMIT = 0; FETCH = 1;	
	`TICKTOCK;   
	`step(3,"FETCH")
	`asserth("ADDR_BUF", 16'heeee, ADDR_BUF)
	`asserth("DOUT_BUF", 16'hdddd, DOUT_BUF)
	`asserth("CPU_DIN",  16'h8989, CPU_DIN)
	`assert( "RD_BUF",   1'b0,     RD_BUF)
	`assert( "WR0_BUF",  1'b0,     WR0_BUF)
	`assert( "WR1_BUF",  1'b0,     WR1_BUF)
	FETCH = 0; DECODE = 1;
	`TICKTOCK;   
	`step(3,"DECODE")
	BUS_SEQX = `BUS_SEQX_ARGWR;	
	DECODE = 0;  EXECUTE = 1; 
	`TICKTOCK;   
	`step(3,"EXECUTE")
	EXECUTE = 0; COMMIT = 1;  
	`TICK;
	`step(3,"COMMIT")
	`asserth("ADDR_BUF", 16'heeee, ADDR_BUF)
	`asserth("DOUT_BUF", 16'hdddd, DOUT_BUF)
	`asserth("CPU_DIN",  16'h8989, CPU_DIN)
	`assert( "RD_BUF",   1'b0,     RD_BUF)
	`assert( "WR0_BUF",  1'b1,     WR0_BUF)
	`assert( "WR1_BUF",  1'b1,     WR1_BUF)
	`TOCK;

	COMMIT = 0; FETCH = 1;	
	`TICK;
	`assert( "WR0_BUF",  1'b0,     WR0_BUF)
	`assert( "WR1_BUF",  1'b0,     WR1_BUF)	
	`TOCK;   
	`step(4,"FETCH")
	`asserth("ADDR_BUF", 16'heeee, ADDR_BUF)
	`asserth("DOUT_BUF", 16'hdddd, DOUT_BUF)
	`asserth("CPU_DIN",  16'h8989, CPU_DIN)
	`assert( "RD_BUF",   1'b0,     RD_BUF)
	`assert( "WR0_BUF",  1'b0,     WR0_BUF)
	`assert( "WR1_BUF",  1'b0,     WR1_BUF)
	FETCH = 0; DECODE = 1;
	`TICKTOCK;   
	`step(4,"DECODE")
	BUS_SEQX = `BUS_SEQX_ARGWR;	
	DECODE = 0;  EXECUTE = 1; 
	`TICKTOCK;   
	`step(4,"EXECUTE")
	EXECUTE = 0; COMMIT = 1;  
	`TICK;
	`step(4,"COMMIT")
	`asserth("ADDR_BUF", 16'heeee, ADDR_BUF)
	`asserth("DOUT_BUF", 16'hdddd, DOUT_BUF)
	`asserth("CPU_DIN",  16'h8989, CPU_DIN)
	`assert( "RD_BUF",   1'b0,     RD_BUF)
	`assert( "WR0_BUF",  1'b1,     WR0_BUF)
	`assert( "WR1_BUF",  1'b1,     WR1_BUF)
	`TOCK;


	COMMIT = 0; FETCH = 1;	
	PC_A = 16'heeee;
	BYTEX = 1;
	`TICK;
	`assert( "WR0_BUF",  1'b0,     WR0_BUF)
	`assert( "WR1_BUF",  1'b0,     WR1_BUF)	
	`TOCK;   
	`step(5,"FETCH")
	`asserth("ADDR_BUF", 16'heeee, ADDR_BUF)
	`asserth("DOUT_BUF", 16'hdddd, DOUT_BUF)
	`asserth("CPU_DIN",  16'h8989, CPU_DIN)
	`assert( "RD_BUF",   1'b0,     RD_BUF)
	`assert( "WR0_BUF",  1'b0,     WR0_BUF)
	`assert( "WR1_BUF",  1'b0,     WR1_BUF)
	FETCH = 0; DECODE = 1;
	`TICKTOCK;   
	`step(5,"DECODE")
	BUS_SEQX = `BUS_SEQX_ARGWR;	
	DECODE = 0;  EXECUTE = 1; 
	`TICKTOCK;   
	`step(5,"EXECUTE")
	EXECUTE = 0; COMMIT = 1;  
	`TICK;
	`step(5,"COMMIT")
	`asserth("ADDR_BUF", 16'heeee, ADDR_BUF)
	`asserth("DOUT_BUF", 16'hdddd, DOUT_BUF)
	`asserth("CPU_DIN",  16'h8989, CPU_DIN)
	`assert( "RD_BUF",   1'b0,     RD_BUF)
	`assert( "WR0_BUF",  1'b1,     WR0_BUF)
	`assert( "WR1_BUF",  1'b0,     WR1_BUF)
	`TOCK;


	COMMIT = 0; FETCH = 1;	
	BYTEX = 1;
	ADDR_BUSX = `ADDR_BUSX_REGB_DOUT;
	REGB_DOUT = 16'hbbbb;
	DATA_BUSX = `DATA_BUSX_REGA_DOUT;
	REGA_DOUT = 16'h1234;

	`TICK;
	`assert( "WR0_BUF",  1'b0,     WR0_BUF)
	`assert( "WR1_BUF",  1'b0,     WR1_BUF)	
	`TOCK;   
	`step(6,"FETCH")
	`asserth("ADDR_BUF", 16'heeee, ADDR_BUF)
	`asserth("DOUT_BUF", 16'h1234, DOUT_BUF)
	`asserth("CPU_DIN",  16'h8989, CPU_DIN)
	`assert( "RD_BUF",   1'b0,     RD_BUF)
	`assert( "WR0_BUF",  1'b0,     WR0_BUF)
	`assert( "WR1_BUF",  1'b0,     WR1_BUF)
	FETCH = 0; DECODE = 1;
	`TICKTOCK;   
	`step(6,"DECODE")
	BUS_SEQX = `BUS_SEQX_ARGWR;	
	DECODE = 0;  EXECUTE = 1; 
	`TICKTOCK;   
	`step(6,"EXECUTE")
	EXECUTE = 0; COMMIT = 1;  
	`TICK;
	`step(6,"COMMIT")
	`asserth("ADDR_BUF", 16'hbbbb, ADDR_BUF)
	`asserth("DOUT_BUF", 16'h3400, DOUT_BUF)
	`asserth("CPU_DIN",  16'h8989, CPU_DIN)
	`assert( "RD_BUF",   1'b0,     RD_BUF)
	`assert( "WR0_BUF",  1'b0,     WR0_BUF)
	`assert( "WR1_BUF",  1'b1,     WR1_BUF)
	`TOCK;



end
	
endmodule
