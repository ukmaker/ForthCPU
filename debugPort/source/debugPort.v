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
	input [15:0]     DEBUG_MEM_DATA_IN,
	input             DEBUG_INCX,
	input             DEBUG_LDX,
	output            DEBUG_REQX,
	output            DEBUG_WRX,

	output [2:0]     DEBUG_OPX,
	output [3:0]     DEBUG_REGX,
	output [1:0]     DEBUG_PCX,
	output [1:0]     DEBUG_CCX,
	
	input [15:0]     DEBUG_DIN_DIN,
	input [15:0]     DEBUG_REGA_DATA,
	input [15:0]     DEBUG_CC_DATA,
	input [15:0]     DEBUG_PC_A_NEXT
	
);

/***************************************************
* Intermodule wiring
****************************************************/
wire EN_STATUS, EN_SELX, EN_MAL, EN_MAH, EN_MDL, EN_MDH, EN_DATAX, EN_OPX;


/***************************************************
* Internal registers
****************************************************/
reg [7:0]  DEBUG_MDL_R;
reg [7:0]  DEBUG_MDH_R;
reg [7:0]  DEBUG_OPX_R;
reg [3:0]  DEBUG_REGX_R;
reg [1:0]  DEBUG_PCX_R;
reg [1:0]  DEBUG_CCX_R;
reg [1:0]  DEBUG_DATAX_R;
reg [15:0] DEBUG_DOUT_R;

/***************************************************
* Instances
****************************************************/
oneOfEightDecoder decoder(
	DEBUG_ADDR,
	EN_STATUS,
	EN_SELX,
	EN_MAL,
	EN_MAH,
	EN_MDL,
	EN_MDH,
	EN_DATAX,
	EN_OPX
);

// Memory address counters
upCounter memAL(
	.CLK(CLK),
	.RESET(RESET),
	.CP(DEBUG_INCX),
	.EN(EN_MAL),
	.LD(DEBUG_WR),
	.DIN(DEBUG_DIN),
	.DOUT(DEBUG_MEM_ADDR[7:0]),
	.RI(1'b1),
	.RO(ROL)
);
	
upCounter memAH(
	.CLK(CLK),
	.RESET(RESET),
	.CP(DEBUG_INCX),
	.EN(EN_MAH),
	.LD(DEBUG_WR),
	.DIN(DEBUG_DIN),
	.DOUT(DEBUG_MEM_ADDR[15:8]),
	.RI(ROL),
	.RO(ROH)
);

register memDL(
	.CLK(CLK),
	.RESET(RESET),
	.DIN(DEBUG_DIN),
	.DOUT(DEBUG_MEM_DATA_OUT[7:0]),
	.LD(DEBUG_WR),
	.EN(EN_MDL)
);
	

/**
* Simple assigns for now
**/
assign DEBUG_TRIG_WR = DEBUG_WR;
assign DEBUG_TRIG_RD = DEBUG_RD;

/**
* Data multiplexer
**/
always @(*) begin
	case(DEBUG_DATAX)
		`DEBUG_DATAX_DIN:       DEBUG_DATA = DEBUG_DIN_DIN;
		`DEBUG_DATAX_REGA_DATA: DEBUG_DATA = DEBUG_REGA_DATA;
		`DEBUG_DATAX_CC_DATA:   DEBUG_DATA = DEBUG_CC_DATA;
		`DEBUG_DATAX_PC_A_NEXT: DEBUG_DATA = DEBUG_PC_A_NEXT;
	endcase
end
/**
* Data output reg
**/
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		DEBUG_DOUT_R <= 16'h0000;
	end else begin
		DEBUG_DOUT_R <= DEBUG_DATA;
	end
end

/**
* Register read
**/
always @(*) begin
	if(EN6) begin
		DEBUG_DOUT = DEBUG_DOUT_R[7:0];
	end else if(EN7) begin
		DEBUG_DOUT = DEBUG_DOUT_R[15:8];
	end
end

endmodule