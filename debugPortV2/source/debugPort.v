`include "../../constants.v"

/*********************************************
* Debugging interface 
*
* Interface is over an 8-bit bus
*
* Registers - 
* 
* 0 - W MODE        - Set the debugging mode
* 1 - W OPARG       - Argument bits for the debugging instruction
* 2 - W OPINST      - The debugging instruction to run when DEBUG_MODE_DEBUG is set
* 3 - W MRAL        - Low byte of address for register and memory writes or reads
* 4 - W MRAH
* 5 - W MRDL
*     R MRDL
* 6 - W MRDH
*     R MRDH
* 7 - R DEBUGSTATUS - Bits set if a breakpoint or watch is hit, snooped processor status and CCs
* 8 - R SNOOPINSTAL - Low byte of instruction load address snoop
*     W BREAKAL     - Low byte of breakpoint address
* 9 - R SNOOPINSTAH
*     W BREAKAH
* A - R SNOOPINSTDL - Low byte of the actual instruction snooped
*     W WATCHSAL    - Low byte of watch start address
* B - R SNOOPINSTDH
*     W WATCHSAH
* C - R SNOOPARGAL  - Low byte of snooped argument address for e.g. LD and ST
*     W WATCHEAL    - Low byte of watch end address
* D - R SNOOPARGAH
*     W WATCHEAH
* E - R SNOOPARGDL
* D - R SNOOPARGDH
*
* DEBUG_MODE Register
* ===================
* N R W B Q DD  S
*               |-- DEBUG_MODE_STOP
*            |----- DEBUG_MODE_DEBUGX - The type of operation to run on the next request
*         |-------- DEBUG_MODE_REQ    - Request a cycle
*       |---------- DEBUG_MODE_BREAK  - Activate breakpoint
*     |------------ DEBUG_MODE_WATCH  - Activate watchpoint
*   |-------------- DEBUG_MODE_RESET  - Global reset
* |---------------- DEBUG_MODE_SNOOP   - Enable bus snooping
*
*            00     DEBUGX_STEP       - Run one normal instruction cycle
*            01     DEBUGX_DSTEP      - Run one debug instruction
*            10     DEBUGX_ISTEP      - Run one injected instruction
*
* DEBUG_OP Register (16-bits) 
* =============================
* FE  D  CBA 98 7654 3210
* GG INC DBG xx ARGA xxxx
*                      |-- Unused
*                 |------- Argument to REG, CC and PC ops
*             |----------- Unused
*         |--------------- The debug operation
*      |------------------ Enable address auto-increment
*  |---------------------- Instruction group
*
* 
*        000               DEBUG_OP_MEMRD  - Uses MRA registers as the memory address. Increment by 2 after access to MRDH if INC is set
*        001               DEBUG_OP_MEMWR
*        010               DEBUG_OP_REGRD  - Uses the argA portion of the instruction for the register address
*        011               DEBUG_OP_REGWR
*        100               DEBUG_OP_CCRD   - Read the CC register indexed by argA
*        101               DEBUG_OP_PCRD   - Read the PC register indexed by argA
*        110               DEBUG_OP_INSTRD - Read the instruction at the current PC
**/

module debugPort(
	
	/***************************************
	* Interface signals
	****************************************/
	input [7:0]      DEBUG_DIN,
	input [3:0]      DEBUG_REG_ADDR,
	input             DEBUG_RDN,
	input             DEBUG_WRN,
	output reg        DEBUG_INT,
	output reg [7:0] DEBUG_DOUT,
	
	/***************************************
	* Global signals
	****************************************/
	input             CLK,
	input             RESETN,
	input             RD,
	input             WR,
	input [15:0]     ADDR,
	/**
	* Combined with the DEBUG_MODE_RESET signal
	**/
	output            RESET,
	
	/***************************************************************
	* Outputs to instruction phase decoder and 
	****************************************************************/
	output            DEBUG_MODE_REQ,
	output            DEBUG_MODE_STOP,
	output            DEBUG_MODE_DEBUG,
	/***************************************************************
	* Inputs from the phase decoder
	****************************************************************/
    input             DEBUG_ACK,           
	
	/***************************************************************
	* Inputs from the debugSequencer
	***************************************************************/
	input             DEBUG_DATA_OUT_SELX,
	input             DEBUG_ADDR_INCX,
	input             DEBUG_SNOOP_LD_EN,
	
	/**************************************************************
	* Watch and breakpoint signals
	**************************************************************/
	output            DEBUG_BKP_ENX,
	output            DEBUG_WATCH_ENX,
	output            DEBUG_IN_WATCH,
	/**************************************************************
	* Watch and breakpoint inputs
	**************************************************************/
	input             DEBUG_AT_BKP,
	
	/**************************************************************
	* Input buses
	**************************************************************/
	input [15:0]      DEBUG_DATA_IN,
	input [15:0]      DEBUG_ADDR_IN,
	
	/**************************************************************
	* Output buses
	**************************************************************/
	output [15:0]     DEBUG_ADDR_OUT,
	output [15:0]     DEBUG_DATA_OUT

);

/**************************************************************
* Register write enables 
**************************************************************/
wire EN_MODE, EN_OP_INST, EN_OP_ARG, 
     EN_MRAL,           EN_MRAH, 
	 EN_MRDL,           EN_MRDH,
	 EN_BREAK_AL,       EN_BREAK_AH,
	 EN_WATCH_START_AH, EN_WATCH_START_AL,
	 EN_WATCH_END_AH,   EN_WATCH_END_AL;
	 
/**************************************************************
* Snoop register addresses
**************************************************************/
wire [1:0] SNOOP_REGX;
assign SNOOP_REGX = DEBUG_REG_ADDR[2:1];


// unused decoder outputs
wire S7, S14, S15;

/**************************************************************
* Register outputs 
**************************************************************/
wire [7:0]  DEBUG_MODE_R;
wire [15:0] DEBUG_OP_R;
wire [15:0] DEBUG_MR_DATA;

	
/**************************************************************
* read register connections to the read mux
**************************************************************/
wire [15:0] SNOOP_REG;
wire [7:0] DEBUG_STATUS;

/***************************************************
* Internal control signals
****************************************************/
wire DEBUG_RESET;
wire DEBUG_LOCAL_RESET;

assign DEBUG_LOCAL_RESET = ~RESETN;
assign RESET = DEBUG_LOCAL_RESET | DEBUG_RESET;

/***************************************************
* MODE signal mappings
****************************************************/
assign DEBUG_BKP_ENX   = (DEBUG_MODE_R & `DEBUG_MODE_EN_BKP)   === `DEBUG_MODE_EN_BKP;
assign DEBUG_WATCH_ENX = (DEBUG_MODE_R & `DEBUG_MODE_EN_WATCH) === `DEBUG_MODE_EN_WATCH;

/***************************************************
* Data output multiplexer (to drive CPU DIN)
****************************************************/
assign DEBUG_DATA_OUT = DEBUG_DATA_OUT_SELX ? DEBUG_MR_DATA : DEBUG_OP_R;

/***************************************************
* Address decoding
****************************************************/
oneOfSixteenDecoder wrAddrDecoder (
	.ADDR(DEBUG_REG_ADDR),
	.EN0(1'b1),
	.EN1(1'b1),
	.S0(EN_MODE),
	.S1(EN_OP_INST),
	.S2(EN_OP_ARG),
	.S3(EN_MRAL),
	.S4(EN_MRAH),
	.S5(EN_MRDL),
	.S6(EN_MRDH),
	.S7(S7),
	.S8(EN_BREAK_AL),
	.S9(EN_BREAK_AH),
	.S10(EN_WATCH_START_AL),
	.S11(EN_WATCH_START_AH),
	.S12(EN_WATCH_END_AL),
	.S13(EN_WATCH_END_AH),
	.S14(S14),
	.S15(S15)
);

/**************************************************************
* Debug registers. 
**************************************************************/
/**************************************************************
* Use synchronizers for control signals and instruction 
**************************************************************/
synchronizer #(.BUS_WIDTH(8)) modeReg (

	.SLOWCLK(DEBUG_WRN),
	.RESET(DEBUG_LOCAL_RESET),
	.FASTCLK(CLK),
	.EN(EN_MODE),
	.LD(1'b1),
	.CLR(1'b0),

	.D(DEBUG_DIN),
	.Q(DEBUG_MODE_R)
);

wordSynchronizer opReg (

	.SLOWCLK(DEBUG_WRN),
	.RESET(DEBUG_LOCAL_RESET),
	.FASTCLK(CLK),
	.EN0(EN_OP_ARG),
	.EN1(EN_OP_INST),
	.LD(1'b1),
	.CLR(1'b0),

	.D(DEBUG_DIN),
	.Q(DEBUG_OP_R)
);

/**************************************************************
* Normal registers for data and addresses DEBUG -> CPU
**************************************************************/
wordRegister mraReg (

	.CLK(DEBUG_WRN),
	.RESET(RESET),
	.EN0(EN_MRAL),
	.EN1(EN_MRAH),
	.LD(1'b1),
	.DIN(DEBUG_DIN),
	.DOUT(DEBUG_ADDR_OUT)

);

wordRegister mrdReg (

	.CLK(DEBUG_WRN),
	.RESET(RESET),
	.EN0(EN_MRDL),
	.EN1(EN_MRDH),
	.LD(1'b1),
	.DIN(DEBUG_DIN),
	.DOUT(DEBUG_MR_DATA)

);

/**************************************************************
* Address watcher
**************************************************************/
watcher watcherInst (

	.CLK(CLK),
	.RESET(RESET),
	.DECODE(DECODE),
	.COMMIT(COMMIT),
	.ADDR(ADDR),
	.DEBUG_WR(DEBUG_WR),
	.DEBUG_EN_WATCH_START_AL(DEBUG_EN_WATCH_START_AL),
	.DEBUG_EN_WATCH_START_AH(DEBUG_EN_WATCH_START_AH),
	.DEBUG_EN_WATCH_END_AL(DEBUG_EN_WATCH_END_AL),
	.DEBUG_EN_WATCH_END_AH(DEBUG_EN_WATCH_END_AH),
	.DEBUG_WATCH_ENX(DEBUG_WATCH_ENX),
	.DEBUG_DIN(DEBUG_DIN),
	.DEBUG_IN_WATCH(DEBUG_IN_WATCH)
	
);
/**************************************************************
* Bus snooper
**************************************************************/
snooper snooperInst(
	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH), 
	.DECODE(DECODE), 
	.EXECUTE(EXECUTE), 
	.COMMIT(COMMIT),
	.DIN(DEBUG_DATA_IN),
	.ADDR(DEBUG_ADDR_IN),
	.DEBUG_SNOOP_LD_EN(DEBUG_SNOOP_LD_EN),
	.SNOOP_REGX(SNOOP_REGX),
	.SNOOP_REG(SNOOP_REG)
);

/**************************************************************
* Read data mux
**************************************************************/
always @(*) begin
	if(DEBUG_ADDR_IN == `DEBUG_REG_STATUS) begin
		DEBUG_DOUT = DEBUG_STATUS;
	end else if(DEBUG_ADDR_IN[3] == 1'b1) begin
		// Read snoop registers
		DEBUG_DOUT = DEBUG_ADDR_IN[0] ? SNOOP_REG[15:8] : SNOOP_REG[7:0];
	end else begin
		DEBUG_DOUT = DEBUG_STATUS;
	end
end
		
		
endmodule