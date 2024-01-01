`include "C:/Users/Duncan/git/ForthCPU/constants.v"
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
* 7 - R SNOOPINSTAL - Low byte of instruction load address snoop
*     W BREAKAL     - Low byte of breakpoint address
* 8 - R SNOOPINSTAH
*     W BREAKAH
* 9 - R SNOOPINSTDL - Low byte of the actual instruction snooped
*     W WATCHSAL    - Low byte of watch start address
* A - R SNOOPINSTDH
*     W WATCHSAH
* B - R SNOOPARGAL  - Low byte of snooped argument address for e.g. LD and ST
*     W WATCHEAL    - Low byte of watch end address
* C - R SNOOPARGAH
*     W WATCHEAH
* D - R SNOOPARGDL
* E - R SNOOPARGDH
* F - R DEBUGSTATUS - Bits set if a breakpoint or watch is hit, snooped processor status and CCs
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
*
* 
*                   Debug Port                                                    Instruction   Decoders  OpxMux  Sequencers
*                                                                                    Latch       /-------           /-------    
*                  ------------                                        DEBUG_OP    ---\/---     --------/    |\    --------/
* DEBUG_DATA <---->|          |--------------------------------------------------->|      |     |      |--->|  \   |      |---> PC_SEQ_EN
* DEBUG_ADDR ----->|          |                                            DIN --->|      |     |      |  . |  |   |      |  .
* DEBUG_RD   ----->|          |---> MR_ADDR                                PHI --->|      |---->|      |  . |  |-->|      |  .  xx_SEQ_YY
* DEBUG_WR   ----->|          |---> MR_DATA                                        |      |     |      |  . |  | | |      |  .
* DEBUG_INT  <-----|          |                                                --->|      |     |      |--->| /  | |      |---> DBG_SEQ_LD_MRD, DEBUG_SEQ_LD_SNOOPINST,...
*                  |          |                                               |    --------     --------    |/   | --------
*                  |          |<--- CLK         w                              |                                  |
*                  |          |<--- RESETN                              DEBUG_OP_EN                               ------------> xx_OPX
*                  |          |---> RESET                                     |
*                  |          |                                               |   Instruction
*                  |          |<--- DEBUG_SEQ_xxx                             |  Phase Decoder   
*                  |          |                                               |    ---\/---   
*                  |          |                                               -----|      |---> FETCH     |
*                  |          |<--- PHI -------------------------------------------|      |---> DECODE    |
*                  |          |---> DEBUG_MODE_REQ ------------------------------->|      |---> EXECUTE   |--> PHI
*                  |          |<--- DEBUG_ACK -------------------------------------|      |---> COMMIT    |
*                  |          |---- DEBUG_MODE_STOP ------------------------------>|      |---> STOPPED   |
*                  |          |---- DEBUG_MODE_DEBUG------------------------------>|      |
*                  |          |                                                    |      |<--- AT_DEBUG_BKP
*                  |          |<--- DIN, PC_A, CC_D, REGB_DATA, INSTRUCTION        |      |<--- IN_DEBUG_WATCH
*                  |          |                                                    |      |
*                  |          |<--- ADDR                                           --------
*                  |          |                                                   
*                  |          |                                                     Snooper
*                  |          |                                                    --------
*                  |          |---> DEBUG_BKP_ADDR ------------------------------->|      |<--- CLK 
*                  |          |---> DEBUG_BKP_ENX -------------------------------->|      |<--- RESET 
*                  |          |<--- AT_DEBUG_BKP ----------------------------------|      |<--- PHI
*                  |          |                                                    |      |
*                  |          |---> DEBUG_WATCH_START_ADDR ----------------------->|      |<--- DIN
*                  |          |---> DEBUG_WATCH_END_ADDR ------------------------->|      |<--- ADDR 
*                  |          |---> DEBUG_WATCH_ENX ------------------------------>|      |
*                  |          |<--- IN_DEBUG_WATCH --------------------------------|      |
*                  |          |                                                    --------
*                  |          |
*                  ------------
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
	* Outputs to instruction latch
	****************************************************************/
	output [15:0] DEBUG_OP,
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
	input             DEBUG_SEQ_DATA_SELX,
	input             DEBUG_SEQ_ADDR_INCX,
	input             DEBUG_SEQ_SNOOP_LD_INST_ADDRX,
	input             DEBUG_SEQ_SNOOP_LD_INST_DATAX,
	input             DEBUG_SEQ_SNOOP_LD_ARG_ADDRX,
	input             DEBUG_SEQ_SNOOP_LD_ARG_DATAX,
	
	/**************************************************************
	* Watch and breakpoint enables
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
* Register enables 
**************************************************************/
wire EN_MODE, EN_OP_INST, EN_OP_ARG, EN_MRAL, EN_MRAH, EN_MRDL, EN_MRDH,
	
	 EN_SNOOP_INST_AL,  EN_SNOOP_INST_AH,
	 EN_BREAK_AL,       EN_BREAK_AH,
	 
     EN_SNOOP_INST_DL,  EN_SNOOP_INST_DH,
	 
	 EN_SNOOP_ARG_AL,   EN_SNOOP_ARG_AH,
	 EN_WATCH_START_AH, EN_WATCH_START_AL,
	 
	 EN_SNOOP_ARG_DL,   EN_SNOOP_ARG_DH,
	 EN_WATCH_END_AH,   EN_WATCH_END_AL,
	 
	 EN_DEBUG_STATUS;

// unused decoder outputs
wire S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15;

/**************************************************************
* Register outputs 
**************************************************************/
wire [7:0] DEBUG_MODE_R;
wire [15:0] DEBUG_OP_R;

	
/**************************************************************
* read register connections to the read mux
**************************************************************/
wire [7:0] SNOOP_INST_ADDR;
wire [7:0] SNOOP_INST_DATA;
wire [7:0] SNOOP_ARG_ADDR;
wire [7:0] SNOOP_ARG_DATA;
wire [7:0] SNOOP_STATUS;
wire [7:0] DEBUG_STATUS;
wire [7:0] READ_DATA;

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
assign DEBUG_BKP_ENX   = (DEBUG_MODE_R & `DEBUG_MODEX_EN_BKP)   === `DEBUG_MODEX_EN_BKP;
assign DEBUG_WATCH_ENX = (DEBUG_MODE_R & `DEBUG_MODEX_EN_WATCH) === `DEBUG_MODEX_EN_WATCH;

/***************************************************
* Data output multiplexer (to drive CPU DIN)
****************************************************/
assign DEBUG_DATA_OUT = DEBUG_DATA_SELX ? DEBUG_MR_DATA : DEBUG_OP_R;

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
	.S7(EN_BREAK_AL),
	.S8(EN_BREAK_AH),
	.S9(EN_WATCH_START_AL),
	.S10(EN_WATCH_START_AH),
	.S11(EN_WATCH_END_AL),
	.S12(EN_WATCH_END_AH),
	.S13(S13),
	.S14(S14),
	.S15(S15)
);

oneOfSixteenDecoder rdAddrDecoder (
	.ADDR(DEBUG_REG_ADDR),
	.EN0(1'b1),
	.EN1(1'b1),
	.S0(S0),
	.S1(S1),
	.S2(S2),
	.S3(S3),
	.S4(S4),
	.S5(S5),
	.S6(S6),
	.S7(EN_SNOOP_INST_AL),
	.S8(EN_SNOOP_INST_AH),
	.S9(EN_SNOOP_INST_DL),
	.S10(EN_SNOOP_INST_DH),
	.S11(EN_SNOOP_ARG_AL),
	.S12(EN_SNOOP_ARG_AH),
	.S13(EN_SNOOP_ARG_DL),
	.S14(EN_SNOOP_ARG_DH),
	.S15(EN_DEBUG_STATUS)
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
	.DOUT(DEBUG_MR_ADDR)

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
* Mem/reg read data CPU -> DEBUGGER
**************************************************************/
wordToByteRegister mrData (

	.CLK(CLK),
	.RESET(RESET),
	.LD(DEBUG_SEQ_LD_MRD_EN),
	.SEL(EN_MRDH),
	.D(DEBUG_DIN_DIN),
	.Q(READ_DATA)
	
);
/**************************************************************
* Word to byte registers for CPU -> DEBUGGER
**************************************************************/
wordToByteRegister snoopIA (

	.CLK(CLK),
	.RESET(RESET),
	.LD(DEBUG_SEQ_LD_SNOOP_INST_EN),
	.SEL(EN_SNOOP_INST_AH),
	.D(DEBUG_DIN_DIN),
	.Q(SNOOP_INST_ADDR)

);

wordToByteRegister snoopID (

	.CLK(CLK),
	.RESET(RESET),
	.LD(DEBUG_SEQ_LD_SNOOP_DATA_EN),
	.SEL(EN_SNOOP_INST_DH),
	.D(DEBUG_DIN_DIN),
	.Q(SNOOP_INST_DATA)

);

wordToByteRegister snoopArgA (

	.CLK(CLK),
	.RESET(RESET),
	.LD(DEBUG_SEQ_LD_SNOOP_ARGA_EN),
	.SEL(EN_SNOOP_ARG_AH),
	.D(DEBUG_DIN_DIN),
	.Q(SNOOP_ARG_ADDR)

);

wordToByteRegister snoopArgD (

	.CLK(CLK),
	.RESET(RESET),
	.LD(DEBUG_SEQ_LD_SNOOP_ARGD_EN),
	.SEL(EN_SNOOP_ARG_DH),
	.D(DEBUG_DIN_DIN),
	.Q(SNOOP_ARG_DATA)

);

/**************************************************************
* Address watcher
**************************************************************/
watcherBlock watcherBlockInst (

	.CLK(CLK),
	.RESET(RESET),
	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.RD(RD),
	.ADDR(ADDR),
	.DEBUG_WR(DEBUG_WR),
	.DEBUG_EN_BREAK_AL(DEBUG_EN_BREAK_AL),
	.DEBUG_EN_BREAK_AH(DEBUG_EN_BREAK_AH),
	.DEBUG_EN_WATCH_START_AL(DEBUG_EN_WATCH_START_AL),
	.DEBUG_EN_WATCH_START_AH(DEBUG_EN_WATCH_START_AH),
	.DEBUG_EN_WATCH_END_AL(DEBUG_EN_WATCH_END_AL),
	.DEBUG_EN_WATCH_END_AH(DEBUG_EN_WATCH_END_AH),
	.DEBUG_BKP_ENX(DEBUG_BKP_ENX),
	.DEBUG_WATCH_ENX(DEBUG_WATCH_ENX),
	.DEBUG_DIN(DEBUG_DIN),
	.DEBUG_AT_BKP(DEBUG_AT_BKP),
	.DEBUG_IN_WATCH(DEBUG_IN_WATCH)
	
);
/**
* 0 - W MODE        - Set the debugging mode
* 1 - W OP          - The debugging operation to run when DEBUG_MODE_DEBUG is set
* 2 - W MRAL        - Low byte of address for register and memory writes or reads
* 3 - W MRAH
* 4 - W MRDL
* 5 - W MRDH
* 6 - R SNOOPINSTAL - Low byte of instruction load address snoop
*     W BREAKAL     - Low byte of breakpoint address
* 7 - R SNOOPINSTAH
*     W BREAKAH
* 8 - R SNOOPINSTDL - Low byte of the actual instruction snooped
* 9 - R SNOOPINSTDH
* A - R SNOOPARGAL  - Low byte of snooped argument address for e.g. LD and ST
*     W WATCHSAL    - Low byte of watch start address
* B - R SNOOPARGAH
*     W WATCHSAH
* C - SNOOPARGDL
*     W WATCHEAL    - Low byte of watch end address
* D - SNOOPARGDH
*     W WATCHEAH
* E - SNOOPSTATUS - Snooped processor status bits, CCs
* F - DEBUGSTATUS - Bits set if a breakpoint or watch is hit
**/
endmodule