`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module requestGeneratorTests;
	
	reg CLK;
	reg RESET;
	
	reg DEBUG_WRN;
	reg DEBUG_RDN;
	
	reg EN_MODE;
	reg DEBUG_DIN_REQ;

	reg EN_DH;
	reg DEBUG_INCX;
	
	reg DEBUG_ACK;
	wire DEBUG_REQ;
	
requestGenerator testInstance(
	
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
	
always begin
	#50 CLK = ~CLK;
end

initial begin

	CLK           = 1'b1;
	RESET         = 1'b0;
	DEBUG_WRN     = 1'b1;
	DEBUG_RDN     = 1'b1;
	EN_MODE       = 1'b0;
	DEBUG_DIN_REQ = 1'b0;
	EN_DH         = 1'b0;
	DEBUG_INCX    = 1'b0;
	DEBUG_ACK     = 1'b0;
	#100;
	RESET = 1;
	#100;
	RESET=0;
	#100;
	/**********************
	* DH toggled request
	* INCX not set
	* => no request
	***********************/
	EN_DH = 1;
	#100;
	DEBUG_WRN = 0;
	#100;
	DEBUG_WRN = 1;
	#200;
	`assert("REQ", 0, DEBUG_REQ)
	#100;
	/**********************
	* DH toggled request
	* INCX set
	* => request
	***********************/
	DEBUG_INCX = 1;
	EN_DH = 1;
	#100;
	DEBUG_WRN = 0;
	#100;
	DEBUG_WRN = 1;
	#210;
	`assert("REQ", 1, DEBUG_REQ)
	#100;
	// ACK the request
	DEBUG_ACK = 1;
	#100;
	DEBUG_ACK = 0;
	`assert("REQ", 0, DEBUG_REQ)
	
	


		
end

endmodule