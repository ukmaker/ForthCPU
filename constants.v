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
`define JRX_ABS   1'b0
`define JRX_REL   1'b1

`define JMPX_NONE 1'b0
`define JMPX_JMP  1'b1

`define CC_INVERTX_NONE   1'b0
`define CC_INVERTX_INVERT 1'b1

`define CC_APPLYX_NONE  1'b0
`define CC_APPLYX_APPLY 1'b1


`define CC_SELECTX_Z 2'b00
`define CC_SELECTX_C 2'b01
`define CC_SELECTX_S 2'b10
`define CC_SELECTX_P 2'b11

/**
* Data sources
**/
// ALU A input
`define ALUA_SRCX_REG_A 1'b0
`define ALUA_SRCX_INCREMENTER 1'b1

`define ALUA_CONSTX_ONE       2'b00
`define ALUA_CONSTX_TWO       2'b01
`define ALUA_CONSTX_MINUS_ONE 2'b10
`define ALUA_CONSTX_MINUS_TWO 2'b11


// ALU B input
`define ALUB_SRCX_REG_B    3'b000
`define ALUB_SRCX_ARG_U4   3'b001
`define ALUB_SRCX_ARG_U8   3'b010
`define ALUB_SRCX_U8_REG_B 3'b011
`define ALUB_SRCX_ARG_U4_0 3'b100
`define ALUB_SRCX_ARG_U6   3'b101
`define ALUB_SRCX_ARG_U6_0 3'b110
`define ALUB_SRCX_ZERO     3'b111

/**
* Register A load sources
**/
`define REGA_DINX_ALU_R     2'b00
`define REGA_DINX_PC_A      2'b01
`define REGA_DINX_ALUA_PP   2'b10

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
`define ADDR_BUSX_PC       2'b00
`define ADDR_BUSX_ALU_R    2'b01
`define ADDR_BUSX_REG_B    2'b10
`define ADDR_BUSX_ALUA_DIN 2'b11

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
* Well-known instructions
**/
`define INSTRUCTION_NOP  16'h0000
`define INSTRUCTION_HALT 16'h0100

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

/**
* Jump
**/
`define JPF_ABS_R  2'b00
`define JPF_ABS_U8 2'b01
`define JPF_REL_R  2'b10
`define JPF_REL_U8 2'b11


`endif