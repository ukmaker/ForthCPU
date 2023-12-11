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
	input [2:0]      DEBUG_ADDR,
	input             DEBUG_RDN,
	input             DEBUG_WRN,
	
	/***************************************
	* Signals to the CPU
	****************************************/
	input             CLK,
	input             RESET,
	
	output [3:0]     DEBUG_OP,
	output            DEBUG_MODE,
	output [15:0]    DEBUG_ADDR_OUT,
	output [3:0]     DEBUG_ARGX_OUT,
	output [15:0]    DEBUG_DATA_OUT,

	input             DEBUG_ADDR_INC_EN,
	
	input             DEBUG_LD_DATA_EN,
	input [1:0]      DEBUG_DATAX,
	input [15:0]     DEBUG_DIN_DIN,
	input [15:0]     DEBUG_REGB_DATA,
	input [15:0]     DEBUG_CC_DATA,
	input [15:0]     DEBUG_PC_A_NEXT,

	output            DEBUG_STOP,
	output            DEBUG_REQ,
	input             DEBUG_ACK
	
);

/***************************************************
* Internal wiring
****************************************************/
assign DEBUG_ARGX_OUT = DEBUG_ADDR_OUT[4:1];
assign DEBUG_DIN_REQ  = DEBUG_DIN[2];
/***************************************************
* Register selects
****************************************************/
wire EN_MODE, EN_OP, EN_DL, EN_DH, EN_AL, EN_AH, EN_UNUSED0, EN_UNUSED1;
wire EN_INC_REQ;

/***************************************************
* Internal muxes
****************************************************/
wire [7:0]  DEBUG_READ_MUX_IN_L;
wire [7:0]  DEBUG_READ_MUX_IN_H;
wire [7:0]  DEBUG_READ_MUX_OUT;
reg  [15:0] DEBUG_DATA_MUX_OUT;

/***************************************************
* Internal registers
****************************************************/
wire AL_RO;
wire AH_RO; // unused
/***************************************************
* Internal control signals
****************************************************/
wire DEBUG_INCX = DEBUG_OP[0];

/***************************************************
* Instances
****************************************************/
oneOfEightDecoder decoder(
	DEBUG_ADDR,
	EN_MODE,
	EN_OP,
	EN_DL,
	EN_DH,
	EN_AL,
	EN_AH,
	EN_UNUSED0,
	EN_UNUSED1
);

requestGenerator requestGen(
	.CLK(CLK),
	.RESET(RESET),
	.DEBUG_WRN(DEBUG_WRN),
	.DEBUG_RDN(DEBUG_RDN),
	
	.EN_MODE(EN_MODE),
	.DEBUG_DIN_REQ(DEBUG_DIN_REQ),
	
	.EN_DH(EN_DH),
	.DEBUG_INCX(DEBUG_INCX),
	
	.DEBUG_ACK(DEBUG_ACK),
	.DEBUG_REQ(DEBUG_REQ)
);

assign DEBUG_ADDR_OUT[0] = 1'b0;

// Address synchronized counters
synchronizedCounter #(.BUS_WIDTH(7)) addrL(

	.SLOWCLK(DEBUG_WRN),
	.RESET(RESET),
	.FASTCLK(CLK),
	.EN(EN_AL),
	.LD(1'b1),
	.COUNT(DEBUG_ADDR_INC_EN),
	.RI(1'b1),
	.RO(AL_RO),
	.D(DEBUG_DIN[7:1]),
	.Q(DEBUG_ADDR_OUT[7:1])
);

synchronizedCounter #(.BUS_WIDTH(8)) addrH(

	.SLOWCLK(DEBUG_WRN),
	.RESET(RESET),
	.FASTCLK(CLK),
	.EN(EN_AH),
	.LD(1'b1),
	.COUNT(DEBUG_ADDR_INC_EN),
	.RI(AL_RO),
	.RO(AH_RO),
	.D(DEBUG_DIN),
	.Q(DEBUG_ADDR_OUT[15:8])
);

// Data synchronized registers
synchronizer #(.BUS_WIDTH(8)) dataL(

	.RESET(RESET),
	.SLOWCLK(DEBUG_WRN),
	.EN(EN_DL),
	.LD(1'b1),
	.FASTCLK(CLK),
	.CLR(RESET),
	.D(DEBUG_DIN),
	.Q(DEBUG_DATA_OUT[7:0])
);

synchronizer #(.BUS_WIDTH(8)) dataH(

	.RESET(RESET),
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
	.RESET(RESET),
	.LD(DEBUG_LD_DATA_EN),
	.EN(1'b1),
	.DIN(DEBUG_DATA_MUX_OUT),
	.DOUT({DEBUG_READ_MUX_IN_H, DEBUG_READ_MUX_IN_L})
);

// Control registers
register #(.BUS_WIDTH(4)) opReg(
	.CLK(DEBUG_WRN),
	.RESET(RESET),
	.DIN(DEBUG_DIN[3:0]),
	.DOUT(DEBUG_OP),
	.LD(1'b1),
	.EN(EN_OP)
);	

synchronizer #(.BUS_WIDTH(2)) modeReg(
	.SLOWCLK(DEBUG_WRN),
	.FASTCLK(CLK),
	.RESET(RESET),
	.D(DEBUG_DIN[1:0]),
	.Q({DEBUG_MODE, DEBUG_STOP}),
	.CLR(RESET),
	.LD(1'b1),
	.EN(EN_MODE)
);



/**
* Data multiplexer
**/
always @(*) begin
	case(DEBUG_DATAX)
		`DEBUG_DATAX_DIN:       DEBUG_DATA_MUX_OUT = DEBUG_DIN_DIN;
		`DEBUG_DATAX_REGB_DATA: DEBUG_DATA_MUX_OUT = DEBUG_REGB_DATA;
		`DEBUG_DATAX_CC_DATA:   DEBUG_DATA_MUX_OUT = DEBUG_CC_DATA;
		`DEBUG_DATAX_PC_A_NEXT: DEBUG_DATA_MUX_OUT = DEBUG_PC_A_NEXT;
	endcase
end

/**
* Register read
**/
always @(*) begin
	if(EN_DH) begin
		DEBUG_DOUT = DEBUG_READ_MUX_IN_H;
	end else begin
		DEBUG_DOUT = DEBUG_READ_MUX_IN_L;
	end
end

endmodule