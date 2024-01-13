`include "C:/Users/Duncan/git/ForthCPU/constants.v"

/**********************************************************
* Generate a debug request due to
* - writing the DEBUG_REQ bit high in the MODE register
* - a read or write to the DH register when 
*   DEBUG_INC bit is set in the OP register
*   and DEBUG_MODE_DEBUGX is DEBUGX_DSTEP
**********************************************************/

module requestGenerator(
	
	input CLK,
	input RESET,
	
	input DEBUG_WR,
	input DEBUG_RD,
	
	input EN_MODE,
	input DEBUG_MODE_REQ_BIT,

	input EN_MRDH,
	input [1:0] DEBUGX,
	input DEBUG_OP_INCX,
	
	input DEBUG_ACK,
	output DEBUG_REQ
);

/****************************************
* Internal wiring
*****************************************/
wire DEBUG_MODE_REQ;
wire DEBUG_NEXT_REQ;
wire DEBUG_NEXT_REQ_R;

assign DEBUG_NEXT_REQ = DEBUG_OP_INCX & (DEBUGX != `DEBUGX_ILLEGAL);

assign DEBUG_REQ = DEBUG_NEXT_REQ_R | DEBUG_MODE_REQ;

/****************************************
* Synchronizer for the DEBUG_MODE_REQ bit
*****************************************/
synchronizer #(.BUS_WIDTH(1)) modeReqReg(

	.RESET(RESET),
	.SLOWCLK(DEBUG_WR),
	.EN(EN_MODE),
	.LD(1'b1),
	
	.FASTCLK(CLK),
	.CLR(DEBUG_ACK),
	
	.D(DEBUG_MODE_REQ_BIT),
	.Q(DEBUG_MODE_REQ)
);

/****************************************
* Synchronizer for the RD/WRD DH requests
*****************************************/
synchronizer #(.BUS_WIDTH(1)) dhReqReg(

	.RESET(RESET),
	.SLOWCLK(DEBUG_WR | DEBUG_RD),
	.EN(EN_MRDH),
	.LD(1'b1),
	
	.FASTCLK(CLK),
	.CLR(DEBUG_ACK),
	
	.D(DEBUG_NEXT_REQ),
	.Q(DEBUG_NEXT_REQ_R)
);

endmodule