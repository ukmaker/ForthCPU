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

	input EN_DH,
	input DEBUG_INCX,
	
	input DEBUG_ACK,
	output reg DEBUG_REQ
);

/****************************************
* Internal wiring
*****************************************/
wire DEBUG_MODE_REQ;
wire DEBUG_INC_REQ;

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
	.EN(EN_DH),
	.LD(1'b1),
	
	.FASTCLK(CLK),
	.CLR(DEBUG_ACK),
	
	.D(DEBUG_INCX),
	.Q(DEBUG_INC_REQ)
);

always @(*) begin
	DEBUG_REQ = DEBUG_INC_REQ | DEBUG_MODE_REQ;
end


endmodule