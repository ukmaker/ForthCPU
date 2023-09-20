`ifndef CONSTANTS
`define CONSTANTS 1
/**
* Register addresses
**/

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
`define RFP  4'b1011 
`define RWA  4'b1100 
`define RSP  4'b1101 
`define RRS  4'b1110 
`define RLN  4'b1111 

/**
* Program counter control
**/
// Operation base value
`define BC_BASEX_PC   1'b0
`define BC_BASEX_ZERO 1'b1
// Operation offset value
`define PC_OFFSETX_D    2'b00
`define PC_OFFSETX_TWO  2'b01
`define PC_OFFSETX_FOUR 2'b10

`define CC_SELECTX_Z 2'b00
`define CC_SELECTX_C 2'b01
`define CC_SELECTX_S 2'b10
`define CC_SELECTX_P 2'b11

/**
* Data sources
**/
// ALU A input
`define ALU_A_SOURCEX_REG_A 1'b0
`define ALU_A_SOURCEX_INCREMENTER 1'b1

`define ALU_A_CONSTX_ONE       2'b00
`define ALU_A_CONSTX_TWO       2'b01
`define ALU_A_CONSTX_MINUS_ONE 2'b10
`define ALU_A_CONSTX_MINUS_TWO 2'b11


// ALU B input
`define ALU_B_SOURCEX_REG_B    3'b000
`define ALU_B_SOURCEX_ARG_U4   3'b001
`define ALU_B_SOURCEX_ARG_U8   3'b010
`define ALU_B_SOURCEX_U8_REG_B 3'b011
`define ALU_B_SOURCEX_ARG_U4_0 3'b100
`define ALU_B_SOURCEX_ZERO     3'b101

/**
* Register A load sources
**/
`define REGA_DINX_ALU_R    2'b00
`define REGA_DINX_PC_A     2'b01
`define REGA_DINX_ALUA_PP  2'b10

/**
* Register A address sources
**/
`define REGA_ADDRX_ARGA 3'b000
`define REGA_ADDRX_RL   3'b001
`define REGA_ADDRX_RB   3'b010
`define REGA_ADDRX_RA   3'b011
`define REGA_ADDRX_RSP  3'b100
`define REGA_ADDRX_RFP  3'b101
`define REGA_ADDRX_RRS  3'b110

/**
* Register B address sources
**/
`define REGB_ADDRX_ARGB 2'b00
`define REGB_ADDRX_ARGA 2'b01
`define REGB_ADDRX_RB   2'b10


/** 
* Address bus sources
**/
`define ADDR_BUSX_PC    2'b00
`define ADDR_BUSX_REG_A 2'b01
`define ADDR_BUSX_REG_B 2'b10
`define ADDR_BUSX_ALU   2'b11

/**
* Data bus sources
**/
`define DATA_BUSX_REG_A 2'b01
`define DATA_BUSX_REG_B 2'b10
`define DATA_BUSX_ALU   2'b11

/**
* Phase
**/
`define FETCH   4'b0001
`define DECODE  4'b0010
`define EXECUTE 4'b0100
`define COMMIT  4'b1000

/**
* Instruction group
**/
`define GROUP_SYSTEM 2'b00
`define GROUP_LOAD_STORE 2'b01
`define GROUP_JUMP 2'b10
`define GROUP_ARITHMETIC_LOGIC 2'b11

/**
* Instruction mode
**/
// ALU operations
`define MODE_REG_REG 2'b00
`define MODE_REG_U4 2'b01
`define MODE_REGB_U8 2'b10
`define MODE_REGA_U8RB 2'b11
// Load/Store operations
`define MODE_REG_MEM 2'b00
`define MODE_REG_FRAME 2'b01
`define MODE_REG_STACK 2'b10
`define MODE_REG_RETSTACK 2'b11
// Jumps
`define MODE_ABS_REG 2'b00
`define MODE_ABS_U8RB 2'b01
`define MODE_REL_REG 2'b10
`define MODE_REL_U8RB 2'b11

/**
* ALU operations
**/
`define ALU_MOV 4'b0000
`define ALU_ADD 4'b0001
`define ALU_SUB 4'b0010
`define ALU_MUL 4'b0011
`define ALU_OR  4'b0100
`define ALU_AND 4'b0101
`define ALU_XOR 4'b0110
`define ALU_SL  4'b0111
`define ALU_SR  4'b1000
`define ALU_SRA 4'b1001
`define ALU_ROT 4'b1010
`define ALU_BIT 4'b1011
`define ALU_SET 4'b1100
`define ALU_CLR 4'b1101
`define ALU_CMP 4'b1110
`define ALU_SEX 4'b1111

/**
* Load/Store
**/
`define LDS_LD  2'b00
`define LDS_LDB 2'b01
`define LDS_ST  2'b10
`define LDS_STB 2'b11

`define LDSF_NONE     2'b00
`define LDSF_PRE_DEC  2'b10
`define LDSF_POST_INC 2'b11

`endif