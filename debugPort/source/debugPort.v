`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/*********************************************
* Debugging interface provides control signals
* to the instruction phase decoder and
* the opxMultiplexer
* It takes data input from
* - the program counter
* - condition code registers
* - interrupt return registers
* - register file
* - data bus
*
* It can write words to the bus, with an autoincrementing address
*
* Interface is over an 8-bit data bus to save pins
**/

module debugPort(
	
	/***************************************
	* Interface signals
	****************************************/
	input [7:0]      DEBUG_DIN,
	output reg [7:0] DEBUG_DOUT,
	input [2:0]      DEBUG_REG_ADDR,
	input             DEBUG_RDN,
	input             DEBUG_WRN,
	
	/***************************************
	* Signals to the CPU
	****************************************/
	input             CLK,
	input             RESETN,
	output            RESET,
	
	output            DEBUG_ADDR_INC,
	output [2:0]     DEBUG_OP,
	output            DEBUG_MODE,
	output reg [15:0]DEBUG_ADDR_OUT,
	output [15:0]    DEBUG_DATA_OUT,

	input             DEBUG_ADDR_INC_EN,
	
	input             DEBUG_LD_DATA_EN,
	input             DEBUG_LD_ARG_EN,
	input [2:0]      DEBUG_DATAX,
	input [15:0]     DEBUG_DIN_DIN,
	input [15:0]     DEBUG_REGB_DATA,
	input [15:0]     DEBUG_CC_DATA,
	input [15:0]     DEBUG_PC_A,
	input [15:0]     DEBUG_INSTRUCTION,

	output            DEBUG_STOP,
	output            DEBUG_REQ,
	input             DEBUG_ACK
	
);

/***************************************************
* Internal wiring
****************************************************/
wire [15:0] DEBUG_ADDR_OUT_R;
/***************************************************
* Register selects
****************************************************/
wire EN_MODE, EN_OP, EN_DL, EN_DH, EN_AL, EN_AH, EN_UNUSED0, EN_UNUSED1;
wire OP_NOP,OP_MEMRD,OP_MEMWR,OP_REGRD,OP_REGWR,OP_CCRD,OP_PCRD,OP_INSTRD;

/***************************************************
* Internal muxes
****************************************************/
wire [7:0]  DEBUG_READ_MUX_IN_DL;
wire [7:0]  DEBUG_READ_MUX_IN_DH;
wire [7:0]  DEBUG_READ_MUX_IN_ARGL;
wire [7:0]  DEBUG_READ_MUX_IN_ARGH;
reg  [15:0] DEBUG_READ_MUX_OUT;
reg  [15:0] DEBUG_DATA_MUX_OUT;

/***************************************************
* Internal registers
****************************************************/
wire AL_RO;
wire AH_RO; // unused
/***************************************************
* Internal control signals
****************************************************/
wire DEBUG_DIN_REQ = DEBUG_DIN[3];
wire DEBUG_RESET;
wire DEBUG_LOCAL_RESET;

assign DEBUG_LOCAL_RESET = ~RESETN;
assign RESET = DEBUG_LOCAL_RESET | DEBUG_RESET;

/***************************************************
* Instances
****************************************************/
oneOfEightDecoder regAddrDecoder(
	DEBUG_REG_ADDR,
	EN_MODE,
	EN_OP,
	EN_AL,
	EN_AH,
	EN_DL,
	EN_DH,
	EN_UNUSED0,
	EN_UNUSED1
);

// OPERATION decode
oneOfEightDecoder opDecoder(
	DEBUG_OP,
	OP_NOP,
	OP_MEMRD,
	OP_MEMWR,
	OP_REGRD,
	OP_REGWR,
	OP_CCRD,
	OP_PCRD,
	OP_INSTRD
);

requestGenerator requestGen(
	.CLK(CLK),
	.RESET(DEBUG_LOCAL_RESET),
	.DEBUG_WRN(DEBUG_WRN),
	.DEBUG_RDN(DEBUG_RDN),
	
	.EN_MODE(EN_MODE),
	.DEBUG_DIN_REQ(DEBUG_DIN_REQ),
	
	.EN_DH(EN_DH),
	.EN_DL(EN_DL),
	.DEBUG_ADDR_INC(DEBUG_ADDR_INC),
	.OP_CCRD(OP_CCRD),
	
	.DEBUG_ACK(DEBUG_ACK),
	.DEBUG_REQ(DEBUG_REQ)
);

//assign DEBUG_ADDR_OUT[0] = 1'b0;

// Address synchronized counters
synchronizedCounter #(.BUS_WIDTH(8)) addrL(

	.SLOWCLK(DEBUG_WRN),
	.RESET(DEBUG_LOCAL_RESET),
	.FASTCLK(CLK),
	.EN(EN_AL),
	.LD(1'b1),
	.COUNT(DEBUG_ADDR_INC_EN),
	.RI(1'b1),
	.RO(AL_RO),
	.D(DEBUG_DIN[7:0]),
	.Q(DEBUG_ADDR_OUT_R[7:0])
);

synchronizedCounter #(.BUS_WIDTH(8)) addrH(

	.SLOWCLK(DEBUG_WRN),
	.RESET(DEBUG_LOCAL_RESET),
	.FASTCLK(CLK),
	.EN(EN_AH),
	.LD(1'b1),
	.COUNT(DEBUG_ADDR_INC_EN),
	.RI(AL_RO),
	.RO(AH_RO),
	.D(DEBUG_DIN),
	.Q(DEBUG_ADDR_OUT_R[15:8])
);

// Data synchronized registers
synchronizer #(.BUS_WIDTH(8)) dataL(

	.RESET(DEBUG_LOCAL_RESET),
	.SLOWCLK(DEBUG_WRN),
	.EN(EN_DL),
	.LD(1'b1),
	.FASTCLK(CLK),
	.CLR(RESET),
	.D(DEBUG_DIN),
	.Q(DEBUG_DATA_OUT[7:0])
);

synchronizer #(.BUS_WIDTH(8)) dataH(

	.RESET(DEBUG_LOCAL_RESET),
	.SLOWCLK(DEBUG_WRN),
	.EN(EN_DH),
	.LD(1'b1),
	.FASTCLK(CLK),
	.CLR(RESET),
	.D(DEBUG_DIN),
	.Q(DEBUG_DATA_OUT[15:8])
);

// Read data register
register #(.BUS_WIDTH(16)) dataR(

	.CLK(CLK),
	.RESET(DEBUG_LOCAL_RESET),
	.LD(DEBUG_LD_DATA_EN),
	.EN(1'b1),
	.DIN(DEBUG_DATA_MUX_OUT),
	.DOUT({DEBUG_READ_MUX_IN_DH, DEBUG_READ_MUX_IN_DL})
);

// Read arg register
register #(.BUS_WIDTH(16)) argR(

	.CLK(CLK),
	.RESET(DEBUG_LOCAL_RESET),
	.LD(DEBUG_LD_ARG_EN),
	.EN(1'b1),
	.DIN(DEBUG_DIN_DIN),
	.DOUT({DEBUG_READ_MUX_IN_ARGH, DEBUG_READ_MUX_IN_ARGL})
);

// Control registers
register #(.BUS_WIDTH(4)) opReg(
	.CLK(DEBUG_WRN),
	.RESET(DEBUG_LOCAL_RESET),
	.DIN(DEBUG_DIN[3:0]),
	.DOUT({DEBUG_OP, DEBUG_ADDR_INC}),
	.LD(1'b1),
	.EN(EN_OP)
);	

synchronizer #(.BUS_WIDTH(3)) modeReg(
	.SLOWCLK(DEBUG_WRN),
	.FASTCLK(CLK),
	.RESET(DEBUG_LOCAL_RESET),
	.D(DEBUG_DIN[2:0]),
	.Q({DEBUG_RESET, DEBUG_MODE, DEBUG_STOP}),
	.CLR(DEBUG_LOCAL_RESET),
	.LD(1'b1),
	.EN(EN_MODE)
);

/**
* Address out multiplexer
**/
always @(*) begin
	if(OP_MEMRD | OP_MEMWR) begin
		DEBUG_ADDR_OUT = {DEBUG_ADDR_OUT_R[15:1], 1'b1};
	end else begin
		DEBUG_ADDR_OUT = DEBUG_ADDR_OUT_R;
	end
end

/**
* Data multiplexer
**/
always @(*) begin
	case(DEBUG_DATAX)
		`DEBUG_DATAX_DIN:         DEBUG_DATA_MUX_OUT = DEBUG_DIN_DIN;
		`DEBUG_DATAX_REGB_DATA:   DEBUG_DATA_MUX_OUT = DEBUG_REGB_DATA;
		`DEBUG_DATAX_CC_DATA:     DEBUG_DATA_MUX_OUT = DEBUG_CC_DATA;
		`DEBUG_DATAX_PC_A:        DEBUG_DATA_MUX_OUT = DEBUG_PC_A;
		`DEBUG_DATAX_INSTRUCTION: DEBUG_DATA_MUX_OUT = DEBUG_INSTRUCTION;
		default:                  DEBUG_DATA_MUX_OUT = DEBUG_DIN_DIN;
	endcase
end

/**
* Register read
**/
always @(*) begin
	case(DEBUG_REG_ADDR)
		`DEBUG_REG_ADDR_DL:   DEBUG_DOUT = DEBUG_READ_MUX_IN_DL;
		`DEBUG_REG_ADDR_DH:   DEBUG_DOUT = DEBUG_READ_MUX_IN_DH;
		`DEBUG_REG_ADDR_ARGL: DEBUG_DOUT = DEBUG_READ_MUX_IN_ARGL;
		`DEBUG_REG_ADDR_ARGH: DEBUG_DOUT = DEBUG_READ_MUX_IN_ARGH;
		default: 	          DEBUG_DOUT = DEBUG_READ_MUX_IN_DL;
	endcase
end

endmodule