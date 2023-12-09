`ifndef CONSTANTS
`define CONSTANTS 1


/*******************************************
* Register addresses
*******************************************/
`define R0  4'b0000 
`define R1  4'b0001 
`define R2  4'b0010 
`define R3  4'b0011 
`define R4  4'b0100 
`define R5  4'b0101 
`define R6  4'b0110 
`define R7  4'b0111 
`define RA  4'b1000 
`define RB  4'b1001 
`define RI  4'b1010 
`define RFP 4'b1011 
`define RWA 4'b1100 
`define RSP 4'b1101 
`define RRS 4'b1110 
`define RL  4'b1111 

/*******************************************
* Data sources
*******************************************/
// ALU A input
`define ALUA_SRCX_REG_A     3'b000
`define ALUA_SRCX_ZERO      3'b001
`define ALUA_SRCX_ONE       3'b010
`define ALUA_SRCX_TWO       3'b011
`define ALUA_SRCX_MINUS_ONE 3'b100
`define ALUA_SRCX_MINUS_TWO 3'b101
`define ALUA_SRCX_U5        3'b110
`define ALUA_SRCX_U5_0      3'b111

// ALU B input
`define ALUB_SRCX_REG_B  3'b000
`define ALUB_SRCX_U8H    3'b001
`define ALUB_SRCX_U8     3'b010
`define ALUB_SRCX_S8     3'b011
`define ALUB_SRCX_U4     3'b100
`define ALUB_SRCX_U4_0   3'b101
`define ALUB_SRCX_ZERO   3'b110

/*******************************************
* Address bus sources
*******************************************/
`define ADDR_BUSX_PC_A      3'b000
`define ADDR_BUSX_ALU_R     3'b001
`define ADDR_BUSX_ALUB_DATA 3'b010
`define ADDR_BUSX_HERE      3'b011
`define ADDR_BUSX_DEBUG     3'b100


/*******************************************
* ALU operations
*******************************************/
`define ALU_OPX_MOV 4'b0000
`define ALU_OPX_ADD 4'b0001
`define ALU_OPX_SUB 4'b0010
`define ALU_OPX_MUL 4'b0011
`define ALU_OPX_OR  4'b0100
`define ALU_OPX_AND 4'b0101
`define ALU_OPX_XOR 4'b0110
`define ALU_OPX_SL  4'b0111
`define ALU_OPX_SR  4'b1000
`define ALU_OPX_SRA 4'b1001
`define ALU_OPX_ROT 4'b1010
`define ALU_OPX_BIT 4'b1011
`define ALU_OPX_SET 4'b1100
`define ALU_OPX_CLR 4'b1101
`define ALU_OPX_CMP 4'b1110
`define ALU_OPX_SEX 4'b1111

/*******************************************
* Bus sequencer
*******************************************/
`define BUS_SEQX_NONE  2'b00
`define BUS_SEQX_FETCH 2'b01
`define BUS_SEQX_READ  2'b10
`define BUS_SEQX_WRITE 2'b11

/*******************************************
* Branch logic control fields
*******************************************/
`define CC_INVERTX_NONE   1'b0
`define CC_INVERTX_INVERT 1'b1

`define CC_APPLYX_NONE  1'b0
`define CC_APPLYX_APPLY 1'b1

`define CC_REGX_RUN  2'b00
`define CC_REGX_INT0 2'b01
`define CC_REGX_INT1 2'b10

`define CC_SELECTX_Z 2'b00
`define CC_SELECTX_C 2'b01
`define CC_SELECTX_S 2'b10
`define CC_SELECTX_P 2'b11

/*******************************************
* Data bus sources
*******************************************/
`define DATA_BUSX_REGA_DOUT  2'b00
`define DATA_BUSX_ALU_R      2'b01
`define DATA_BUSX_DEBUG      2'b10

/*******************************************
* Debugging interface
********************************************/
`define DEBUG_ADDRX_MODE    3'b000
`define DEBUG_ADDRX_OP      3'b001
`define DEBUG_ADDRX_DL      3'b010
`define DEBUG_ADDRX_DH      3'b011
`define DEBUG_ADDRX_AL      3'b100
`define DEBUG_ADDRX_AH      3'b101

`define DEBUG_ADDR_INCX_NONE 1'b0
`define DEBUG_ADDR_INCX_INC  1'b1

`define DEBUG_LD_DATAX_NONE  1'b0
`define DEBUG_LD_DATAX_LD    1'b1

`define DEBUG_OPX_NONE   3'b000
`define DEBUG_OPX_RD_MEM 3'b001
`define DEBUG_OPX_WR_MEM 3'b010
`define DEBUG_OPX_RD_REG 3'b011
`define DEBUG_OPX_WR_REG 3'b100
`define DEBUG_OPX_RD_CC  3'b101
`define DEBUG_OPX_RD_PC  3'b110

`define DEBUG_DATAX_DIN       2'b00
`define DEBUG_DATAX_REGB_DATA 2'b01
`define DEBUG_DATAX_CC_DATA   2'b10
`define DEBUG_DATAX_PC_A_NEXT 2'b11

`define DEBUG_MODEX_STOP  3'b001
`define DEBUG_MODEX_DEBUG 3'b010
`define DEBUG_MODEX_REQ   3'b100

/*******************************************
* Program counter control inputs
*******************************************/
`define PC_LD_INT0X_NONE 1'b0
`define PC_LD_INT0X_LD   1'b1

`define PC_LD_INT1X_NONE 1'b0
`define PC_LD_INT1X_LD   1'b1

`define PC_ENX_NONE      1'b0
`define PC_ENX_EN        1'b1

`define PC_HEREX_NONE    1'b0
`define PC_HEREX_EN      1'b1

`define PC_NEXTX_NEXT  3'b000
`define PC_NEXTX_INTV0 3'b001
`define PC_NEXTX_INTV1 3'b010
`define PC_NEXTX_INTR0 3'b011
`define PC_NEXTX_INTR1 3'b100

// The outputs
`define PC_OFFSETX_0    2'b00
`define PC_OFFSETX_2    2'b01
`define PC_OFFSETX_4    2'b10
`define PC_OFFSETX_DIN  2'b11

`define PC_BASEX_PC_A      2'b00
`define PC_BASEX_REGB_DOUT 2'b01
`define PC_BASEX_0         2'b10

/**
* Interrupt logic control inputs
**/
`define RETIX_NONE 1'b0
`define RETIX_RETI 1'b1

`define EIX_NONE 1'b0
`define EIX_EI   1'b1

`define DIX_NONE 1'b0
`define DIX_DI   1'b1

`define INTV0 16'h0004
`define INTV1 16'h0008

`define INT_STATE_RUN      4'b0000
`define INT_STATE_RUN_E    4'b0001
`define INT_STATE_VEC1     4'b0010
`define INT_STATE_VEC0     4'b0011
`define INT_STATE_VEC1_0   4'b0100
`define INT_STATE_RUN1     4'b0101
`define INT_STATE_RUN0     4'b0110
`define INT_STATE_RUN1_0   4'b0111
`define INT_STATE_RETI1    4'b1000
`define INT_STATE_RETI0    4'b1001
`define INT_STATE_RETI1_0  4'b1010

/*******************************************
* Interrupt mask registers
********************************************/
`define INT_MASK 2'b00
`define INT_INTS 2'b01
`define INT_PRI  2'b10

/**************************************
* Bus interface
***************************************/
`define BYTEX_WORD 1'b0
`define BYTEX_BYTE 1'b1
`define RDX_NONE   1'b0
`define RX_RD      1'b1
`define WRX_NONE   1'b0
`define WRX_WR     1'b1

/**************************************
* Register control
***************************************/
`define REG_EN_NONE       1'b0
`define REG_EN_EN         1'b1
`define REG_WEN_NONE      1'b0
`define REG_WEN_EN        1'b1

`define REG_BYTE_ENX_NONE 2'b00
`define REG_BYTE_ENX_LOW  2'b01
`define REG_BYTE_ENX_HIGH 2'b10
`define REG_BYTE_ENX_BOTH 2'b11

/**************************************
* Register sequencing
***************************************/
// registers not used
`define REG_SEQX_NONE    4'b000
// CMP instruction (no register write)
// ST
`define REG_SEQX_RDA_RDB 4'b0001
// ALU ops
// LD
`define REG_SEQX_LDA_RDB 4'b0010
// POP
`define REG_SEQX_LDA_UPB 4'b0011
// PUSH
`define REG_SEQX_RDA_UPB 4'b0100
// ALU immediate (MOVI R0,U4...)
`define REG_SEQX_LDA_IMM 4'b0101
// ALU immediate (CMP R0,U4...)
`define REG_SEQX_RDA_IMM 4'b0110
// ALU OP a,b
`define REG_SEQX_UPA_RDB 4'b0111
// ALU OP a,IMM
`define REG_SEQX_UPA_IMM 4'b1000
// JMP Rb
`define REG_SEQX_RDB     4'b1001

/**
* Register A load sources
**/
`define REGA_DINX_DIN       2'b00
`define REGA_DINX_BYTE      2'b01
`define REGA_DINX_HERE      2'b10
`define REGA_DINX_ALU_R     2'b11

`define REGA_BYTEX_LOW      1'b0
`define REGA_BYTEX_HIGH     1'b1

/**
* Register A address sources
**/
`define REGA_ADDRX_ARGA 2'b00
`define REGA_ADDRX_RA   2'b01
`define REGA_ADDRX_RB   2'b10
`define REGA_ADDRX_RL   2'b11

/**
* Register B address sources
**/
`define REGB_ADDRX_ARGB 3'b000
`define REGB_ADDRX_RB   3'b001
`define REGB_ADDRX_RSP  3'b010
`define REGB_ADDRX_RFP  3'b011
`define REGB_ADDRX_RRS  3'b100

/**
* Phase
**/
`define PHI_STOPPED       4'b0000
`define PHI_FETCH         4'b0001
`define PHI_DECODE        4'b0010
`define PHI_EXECUTE       4'b0011
`define PHI_COMMIT        4'b0100
`define PHI_DEBUG_STOPPED 4'b1000
`define PHI_DEBUG_FETCH   4'b1001
`define PHI_DEBUG_DECODE  4'b1010
`define PHI_DEBUG_EXECUTE 4'b1011
`define PHI_DEBUG_COMMIT  4'b1100
`define PHI_DEBUG_ACK     4'b1101

/**
* Instruction group
**/
`define GROUP_SYSTEM 2'b00
`define GROUP_LOAD_STORE 2'b01
`define GROUP_JUMP 2'b10
`define GROUP_ARITHMETIC_LOGIC 2'b11

/**
* General instructions
**/
`define GEN_OP_NOP  3'b000
`define GEN_OP_HALT 3'b001
`define GEN_OP_EI   3'b010
`define GEN_OP_DI   3'b011
`define GEN_OP_RETI 3'b100

/**
* Instruction mode
**/
// ALU operations
`define MODE_ALU_REG_REG   2'b00
`define MODE_ALU_REG_U4    2'b01
`define MODE_ALU_REGA_U8   2'b10
`define MODE_ALU_REGA_S8   2'b11

// Load/Store mode
`define MODE_LDS_REG_REG      3'b000
`define MODE_LDS_REG_HERE     3'b001
`define MODE_LDS_REG_REG_INC  3'b010
`define MODE_LDS_REG_REG_DEC  3'b011
`define MODE_LDS_REG_RB       3'b100
`define MODE_LDS_REG_FP       3'b101
`define MODE_LDS_REG_SP       3'b110
`define MODE_LDS_REG_RS       3'b111

/**
* Load/Store operation
**/
`define LDSOPF_LD  2'b00
`define LDSOPF_LDB 2'b01
`define LDSOPF_ST  2'b10
`define LDSOPF_STB 2'b11

// Jump mode
`define MODE_JMP_ABS_REG  2'b00
`define MODE_JMP_IND_REG  2'b01
`define MODE_JMP_ABS_HERE 2'b10
`define MODE_JMP_REL_HERE 2'b11

/**
* Apply condition codes
**/
`define SKIPF_NONE     2'b00
`define SKIPF_SKIP     2'b10
`define SKIPF_NOT_SKIP 2'b11

/**
* Jump with link
**/
`define JLF_NONE       1'b0
`define JLF_LINK       1'b1

/*******************************************
* UART definitions
********************************************/
`define UART_STATUS_DATA_AVAILABLE 16'h0001
`define UART_STATUS_TX_ACTIVE      16'h0002
`define UART_STATUS_TX_COMPLETE    16'h0004
`define UART_STATUS_RX_INTERRUPT   16'h0008
`define UART_STATUS_TX_INTERRUPT   16'h0010

`define UART_STATUS_DATA_AVAILABLE_BIT 0
`define UART_STATUS_TX_ACTIVE_BIT      1
`define UART_STATUS_TX_COMPLETE_BIT    2
`define UART_STATUS_RX_INTERRUPT_BIT   3
`define UART_STATUS_TX_INTERRUPT_BIT   4

`define UART_REG_STATUS      2'b00
`define UART_REG_DATA        2'b01
`define UART_REG_RX_CLK_DIV  2'b10
`define UART_REG_TX_CLLK_DIV 2'b11

`endif