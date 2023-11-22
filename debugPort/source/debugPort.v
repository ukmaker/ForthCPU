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
	
	input             CLK,
	input             RESET,
	input [7:0]      DEBUG_DIN,
	output reg [7:0] DEBUG_DOUT,
	input [2:0]      DEBUG_ADDR,
	input             DEBUG_RD,
	input             DEBUG_WR,
	
	output [15:0]    DEBUG_MEM_ADDR,
	output [15:0]    DEBUG_MEM_DATA_OUT,

	input             DEBUG_ADDR_INCX,
	input             DEBUG_ADDR_LDX,
	output            DEBUG_STOPX,
	output            DEBUG_REQX,
	input             DEBUG_ACKX,

	// 
	output [2:0]     DEBUG_OPX,
	output [3:0]     DEBUG_REGA_ADDRX,
	
	output [2:0]     DEBUG_PC_NEXTX,
	output [1:0]     DEBUG_CC_REGX,
	
	input [15:0]     DEBUG_DIN_DIN,
	input [15:0]     DEBUG_REGA_DATA,
	input [15:0]     DEBUG_CC_DATA,
	input [15:0]     DEBUG_PC_A_NEXT,
	input             DEBUG_DOUT_LDX
	
);

/***************************************************
* Register selects
****************************************************/
wire EN_STATUS, EN_SOURCEX, EN_MAL, EN_MAH, EN_MDL, EN_MDH, EN_DATAX, EN_OPX;
wire [1:0] DEBUG_DOUTX;

wire [7:0] MAH_BUF;
wire [7:0] MAL_BUF;

/***************************************************
* Internal muxes
****************************************************/
reg [15:0] DEBUG_DATA_MUX_OUT;

wire [7:0]  DEBUG_READ_MUX_IN_L;
wire [7:0]  DEBUG_READ_MUX_IN_H;
wire [7:0]  DEBUG_READ_MUX_OUT;
wire [15:0] DEBUG_DOUT_REG;

/***************************************************
* Internal registers
****************************************************/
reg [7:0]  DEBUG_MDL_R;
reg [7:0]  DEBUG_MDH_R;
reg [7:0]  DEBUG_OPX_R;

reg [1:0]  DEBUG_DATAX_R;


assign DEBUG_MEM_ADDR[0] = 1'b0;

/***************************************************
* Instances
****************************************************/
oneOfEightDecoder decoder(
	DEBUG_ADDR,
	EN_OPX,
	EN_SOURCEX,
	EN_MAL,
	EN_MAH,
	EN_MDL,
	EN_MDH,
	EN_DATAX,
	EN_STOP
);

requestGenerator requestGen(
	.CLK(CLK),
	.RESET(RESET),
	.WR(DEBUG_WR),
	.RD(DEBUG_RD),
	.ACKX(DEBUG_ACKX),
	.EN_OP(EN_OPX),
	.EN_MDH(EN_MDH),
	.REQX(DEBUG_REQX)
);

stopSynchroniser stopper(
	.CLK(CLK),
	.RESET(RESET),
	.WR(DEBUG_WR),
	.D0(DEBUG_DIN[0]),
	.EN_STOP(EN_STOP),
	.STOPX(DEBUG_STOPX)
);

// Memory address buffer registers
register memALBufReg(
	.CLK(DEBUG_WR),
	.RESET(RESET),
	.DIN(DEBUG_DIN),
	.DOUT(MAL_BUF),
	.LD(EN_MAL),
	.EN(EN_MAL)
);
	
register memAHBufReg(
	.CLK(DEBUG_WR),
	.RESET(RESET),
	.DIN(DEBUG_DIN),
	.DOUT(MAH_BUF),
	.LD(EN_MAH),
	.EN(EN_MAH)
);

// Memory address counters
upCounter memALReg(
	.CLK(CLK),
	.RESET(RESET),
	.CP(DEBUG_ADDR_INCX),
	.EN(DEBUG_ADDR_LDX),
	.LD(DEBUG_ADDR_LDX),
	.DIN({MAH_BUF[0],MAL_BUF[7:1]}),
	.DOUT(DEBUG_MEM_ADDR[8:1]),
	.RI(1'b1),
	.RO(ROL)
);
	
upCounter #(.BUS_WIDTH(7)) memAHReg(
	.CLK(CLK),
	.RESET(RESET),
	.CP(DEBUG_ADDR_INCX),
	.EN(DEBUG_ADDR_LDX),
	.LD(DEBUG_ADDR_LDX),
	.DIN(MAH_BUF[7:1]),
	.DOUT(DEBUG_MEM_ADDR[15:9]),
	.RI(ROL),
	.RO(ROH)
);

register memDLReg(
	.CLK(CLK),
	.RESET(RESET),
	.DIN(DEBUG_DIN),
	.DOUT(DEBUG_MEM_DATA_OUT[7:0]),
	.LD(DEBUG_WR),
	.EN(EN_MDL)
);
	
register memDHReg(
	.CLK(CLK),
	.RESET(RESET),
	.DIN(DEBUG_DIN),
	.DOUT(DEBUG_MEM_DATA_OUT[15:8]),
	.LD(DEBUG_WR),
	.EN(EN_MDH)
);

// Control registers
register #(.BUS_WIDTH(16)) dataOutReg(
	.CLK(CLK),
	.RESET(RESET),
	.DIN(DEBUG_DATA_MUX_OUT),
	.DOUT(DEBUG_DOUT_REG),
	.LD(DEBUG_DOUT_LDX),
	.EN(1'b1)
);

register #(.BUS_WIDTH(2)) dataXReg(
	.CLK(DEBUG_WR),
	.RESET(RESET),
	.DIN(DEBUG_DIN[1:0]),
	.DOUT(DEBUG_DOUTX),
	.LD(DEBUG_WR),
	.EN(EN_DATAX)
);
	
register #(.BUS_WIDTH(6)) opXReg(
	.CLK(DEBUG_WR),
	.RESET(RESET),
	.DIN(DEBUG_DIN[2:0]),
	.DOUT({DEBUG_REGA_ADDRX,,DEBUG_OPX}),
	.LD(EN_OPX),
	.EN(EN_OPX)
);	

register #(.BUS_WIDTH(5)) dataSourcesReg(
	.CLK(DEBUG_WR),
	.RESET(RESET),
	.DIN(DEBUG_DIN),
	.DOUT({DEBUG_PC_NEXTX,DEBUG_CC_REGX}),
	.LD(EN_SOURCEX),
	.EN(EN_SOURCEX)
);

/**
* Data multiplexer
**/
always @(*) begin
	case(DEBUG_DOUTX)
		`DEBUG_DATAX_DIN:       DEBUG_DATA_MUX_OUT = DEBUG_DIN_DIN;
		`DEBUG_DATAX_REGA_DATA: DEBUG_DATA_MUX_OUT = DEBUG_REGA_DATA;
		`DEBUG_DATAX_CC_DATA:   DEBUG_DATA_MUX_OUT = DEBUG_CC_DATA;
		`DEBUG_DATAX_PC_A_NEXT: DEBUG_DATA_MUX_OUT = DEBUG_PC_A_NEXT;
	endcase
end

/**
* Register read
**/
always @(*) begin
	if(EN_MDH) begin
		DEBUG_DOUT = DEBUG_DOUT_REG[15:8];
	end else begin
		DEBUG_DOUT = DEBUG_DOUT_REG[7:0];
	end
end

endmodule