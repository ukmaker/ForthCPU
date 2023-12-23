`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/**********************************************************
* Generate a debug request due to
* - writing the DEBUG_REQ bit high in the MODE register
* - a read or write to the DH register when 
*   DEBUG_INC bit is set in the OP register
**********************************************************/

module requestGenerator(
	
	input CLK,
	input RESET,
	
	input DEBUG_WRN,
	input DEBUG_RDN,
	
	input EN_MODE,
	input DEBUG_DIN_REQ,

	input EN_DL,
	input EN_DH,
	input DEBUG_ADDR_INC,
	input OP_CCRD,
	
	input DEBUG_ACK,
	output reg DEBUG_REQ
);

/****************************************
* Internal wiring
*****************************************/
wire DEBUG_MODE_REQ;
wire DEBUG_INC_REQ;
wire INC_EN;

/****************************************
* Synchronizer for the DEBUG_MODE_REQ bit
*****************************************/
synchronizer #(.BUS_WIDTH(1)) modeReqReg(

	.RESET(RESET),
	.SLOWCLK(DEBUG_WRN),
	.EN(EN_MODE),
	.LD(1'b1),
	
	.FASTCLK(CLK),
	.CLR(DEBUG_ACK),
	
	.D(DEBUG_DIN_REQ),
	.Q(DEBUG_MODE_REQ)
);

/****************************************
* Synchronizer for the RD/WRD DH requests
*****************************************/
synchronizer #(.BUS_WIDTH(1)) dhReqReg(

	.RESET(RESET),
	.SLOWCLK(DEBUG_WRN & DEBUG_RDN),
	.EN(INC_EN),
	.LD(1'b1),
	
	.FASTCLK(CLK),
	.CLR(DEBUG_ACK),
	
	.D(DEBUG_ADDR_INC),
	.Q(DEBUG_INC_REQ)
);

// OP logic
assign INC_EN = (EN_DH & ~OP_CCRD) | (EN_DL & OP_CCRD);

always @(*) begin
	DEBUG_REQ = DEBUG_INC_REQ | DEBUG_MODE_REQ;
end


endmodule