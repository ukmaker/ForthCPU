`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/*********************************************
* Debugging interface 
*
* Interface is over an 8-bit bus
*
* Registers - 
* 
* 0 - W MODE        - Set the debugging mode
* 1 - W OP          - The debugging operation to run when DEBUG_MODE_DEBUG is set
* 2 - W MRAL        - Low byte of address for register and memory writes or reads
* 3 - W MRAH
* 4 - W MRDL
*     R MRDL
* 5 - W MRDH
*     R MRDH
* 6 - R SNOOPINSTAL - Low byte of instruction load address snoop
*     W BREAKAL     - Low byte of breakpoint address
* 7 - R SNOOPINSTAH
*     W BREAKAH
* 8 - R SNOOPINSTDL - Low byte of the actual instruction snooped
*     W WATCHSAL    - Low byte of watch start address
* 9 - R SNOOPINSTDH
*     W WATCHSAH
* A - R SNOOPARGAL  - Low byte of snooped argument address for e.g. LD and ST
*     W WATCHEAL    - Low byte of watch end address
* B - R SNOOPARGAH
*     W WATCHEAH
* C - SNOOPARGDL
* D - SNOOPARGDH
* E - SNOOPSTATUS - Snooped processor status bits, CCs
* F - DEBUGSTATUS - Bits set if a breakpoint or watch is hit
*
* DEBUG_MODE Register
* ===================
* x I R W B Q D S
*               |-- DEBUG_MODE_STOP
*             |---- DEBUG_MODE_DEBUG Run a DEBUG or INSTRUCTION operation on the next request
*           |------ DEBUG_MODE_REQ   Request a cycle
*         |-------- DEBUG_MODE_BREAK Activate breakpoint
*       |---------- DEBUG_MODE_WATCH Activate watchpoint
*     |------------ DEBUG_MODE_RESET Global reset
*   |-------------- DEBUG_MODE_INC   Run the requested operation and increment the WRA registers after the next write to WRDH
*
* DEBUG_OP Register
* ==================
* 0 - DEBUG_OP_MEMRD   - Uses MRA registers as the memory address. Increment by 2 after access to MRDH
* 1 - DEBUG_OP_MEMWR
* 2 - DEBUG_OP_REGRD   - Uses MRAL register >> 1 as the register index. Increment by 1 after access to MRDH
* 3 - DEBUG_OP_REGWR
* 4 - DEBUG_OP_CCRD   - Uses MRAL register as the CC register index. Increment by 1 after access to MRDH
* 5 - DEBUG_OP_PCRD   - Uses MRAL register as the PC register index. Increment by 1 after access to MRDH
* 6 - DEBUG_OP_INSTRD - Read the instruction at the current PC into MRD registers
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
*                  |          |<--- CLK                                       |                                  |
*                  |          |<--- RESETN                              DEBUG_OP_EN                               ------------> xx_OPX
*                  |          |---> RESET                                     |
*                  |          |                                               |   Instruction
*                  |          |<--- DEBUG_SEQ_xxx                             |  Phase Decoder   
*                  |          |                                               |    ---\/---   
*                  |          |                                               -----|      |---> FETCH     |
*                  |          |<--- PHI -------------------------------------------|      |---> DECODE    |
*                  |          |---> DEBUG_REQ ------------------------------------>|      |---> EXECUTE   |--> PHI
*                  |          |<--- DEBUG_ACK -------------------------------------|      |---> COMMIT    |
*                  |          |---- DEBUG_STOP ----------------------------------->|      |---> STOPPED   |
*                  |          |---- DEBUG_MODE ----------------------------------->|      |
*                  |          |                                                    |      |<--- AT_DEBUG_BKP
*                  |          |<--- DIN, PC_A, CC_D, REGB_DATA, INSTRUCTION        |      |<--- IN_DEBUG_WATCH
*                  |          |                                                    |      |
*                  |          |<--- ADDR                                           --------
*                  |          |
*                  |          |---> DEBUG_BKP_ADDR
*                  |          |---> DEBUG_BKP_ENX
*                  |          |<--- AT_DEBUG_BKP
*                  |          |
*                  |          |---> DEBUG_WATCH_START_ADDR
*                  |          |---> DEBUG_WATCH_END_ADDR
*                  |          |---> DEBUG_WATCH_ENX
*                  |          |<--- IN_DEBUG_WATCH
*                  |          |
*                  |          |
*                  ------------
**/

module debugPort(
	
	/***************************************
	* Interface signals
	****************************************/
	input [7:0]      DEBUG_DIN,
	output reg [7:0] DEBUG_DOUT,
	input [3:0]      DEBUG_REG_ADDR,
	input             DEBUG_RDN,
	input             DEBUG_WRN,
	
	/***************************************
	* Global signals
	****************************************/
	input             CLK,
	input             RESETN,
	/**
	* Combined with the DEBUG_MODE_RESET signal
	**/
	output            RESET,
	
	/***************************************************************
	* Outputs to instruction latch
	****************************************************************/
	output [15:0] DEBUG_OP_INSTRUCTION,
	/***************************************************************
	* Outputs to instruction phase decoder
	****************************************************************/
	output            DEBUG_REQ,
	output            DEBUG_STOP,
	output            DEBUG_MODE,
	/***************************************************************
	* Inputs from the phase decoder
	****************************************************************/
    input             DEBUG_ACK,           
	
	/***************************************************************
	* Inputs from the debugSequencer
	***************************************************************/
	input             DEBUG_SEQ_ADDR_INC_EN,
	input             DEBUG_SEQ_LD_MRD_EN,
	input             DEBUG_SEQ_LD_SNOOP_INST_EN,
	input             DEBUG_SEQ_LD_SNOOP_DATA_EN,
	input             DEBUG_SEQ_LD_SNOOP_ARGA_EN,
	input             DEBUG_SEQ_LD_SNOOP_ARGD_EN,
	
	/**************************************************************
	* Watch and breakpoint addresses and enables
	**************************************************************/
	output [15:0]    DEBUG_BKP_ADDR,
	output            DEBUG_BKP_ENX,
	output [15:0]    DEBUG_WATCH_START_ADDR,
	output [15:0]    DEBUG_WATCH_END_ADDR,
	output            DEBUG_WATCH_ENX,
	/**************************************************************
	* Watch and breakpoint inputs
	**************************************************************/
	input             AT_BKP,
	input             IN_WATCH,
	
	/**************************************************************
	* Input buses
	**************************************************************/
	input [15:0]     DEBUG_DIN_DIN,
	input [15:0]     DEBUG_REGB_DATA,
	input [15:0]     DEBUG_CC_DATA,
	input [15:0]     DEBUG_PC_A,
	input [15:0]     DEBUG_INSTRUCTION,
	
	/**************************************************************
	* Output buses
	**************************************************************/
	output [15:0] DEBUG_MR_ADDR,
	output [15:0] DEBUG_MR_DATA

);

/**************************************************************
* Register enables 
**************************************************************/
wire EN_MODE, EN_OP, EN_MRAL, EN_MRAH, EN_MRDL, EN_MRDH,
	
	 EN_SNOOP_INST_AL,  EN_SNOOP_INST_AH,
	 EN_BREAK_AL,       EN_BREAK_AH,
	 
     EN_SNOOP_INST_DL,  EN_SNOOP_INST_DH,
	 
	 EN_SNOOP_ARG_AL,   EN_SNOOP_ARG_AH,
	 EN_WATCH_START_AH, EN_WATCH_START_AL,
	 
	 EN_SNOOP_ARG_DL,   EN_SNOOP_ARG_DH,
	 EN_WATCH_END_AH,   EN_WATCH_END_AL,
	 
	 EN_SNOOP_STATUS,   EN_DEBUG_STATUS;

/**************************************************************
* Register outputs 
**************************************************************/
wire [7:0] DEBUG_MODE_R;
wire [7:0] DEBUG_OP_R;

	
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
assign DEBUG_OP_INSTRUCTION = {DEBUG_OP_R, DEBUG_MR_ADDR[8:1]};
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
synchronizer #(.BUS_WIDTH(8)) opReg (

	.SLOWCLK(DEBUG_WRN),
	.RESET(DEBUG_LOCAL_RESET),
	.FASTCLK(CLK),
	.EN(EN_OP),
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

wordRegister breakAReg (

	.CLK(DEBUG_WRN),
	.RESET(RESET),
	.EN0(EN_BREAK_AL),
	.EN1(EN_BREAK_AH),
	.LD(1'b1),
	.DIN(DEBUG_DIN),
	.DOUT(DEBUG_BKP_ADDR)

);

wordRegister watchStartReg (

	.CLK(DEBUG_WRN),
	.RESET(RESET),
	.EN0(EN_WATCH_START_AL),
	.EN1(EN_WATCH_START_AH),
	.LD(1'b1),
	.DIN(DEBUG_DIN),
	.DOUT(DEBUG_WATCH_START_ADDR)

);

wordRegister watchEndReg (

	.CLK(DEBUG_WRN),
	.RESET(RESET),
	.EN0(EN_WATCH_END_AL),
	.EN1(EN_WATCH_END_AH),
	.LD(1'b1),
	.DIN(DEBUG_DIN),
	.DOUT(DEBUG_WATCH_END_ADDR)

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