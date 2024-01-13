`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module requestGeneratorTests;
	
	reg CLK;
	reg RESET;
	
	reg DEBUG_WR;
	reg DEBUG_RD;
	
	reg EN_MODE;
	reg DEBUG_MODE_REQ_BIT;

	reg EN_MRDH;
	reg [1:0] DEBUGX;
	reg DEBUG_OP_INCX;
	
	reg DEBUG_ACK;
	wire DEBUG_REQ;
	
	
requestGenerator testInst(
	
	.CLK(CLK),
	.RESET(RESET),
	
	.DEBUG_WR(DEBUG_WR),
	.DEBUG_RD(DEBUG_RD),
	
	.EN_MODE(EN_MODE),
	.DEBUG_MODE_REQ_BIT(DEBUG_MODE_REQ_BIT),

	.EN_MRDH(EN_MRDH),
	.DEBUGX(DEBUGX),
	.DEBUG_OP_INCX(DEBUG_OP_INCX),
	
	.DEBUG_ACK(DEBUG_ACK),
	.DEBUG_REQ(DEBUG_REQ)
);

always begin
	#50 CLK = ~CLK;
end

initial begin
	
	CLK = 1;
	RESET = 0;
	DEBUG_WR = 0;
	DEBUG_RD = 0;
	EN_MODE = 0;
	DEBUG_MODE_REQ_BIT = 0;
	EN_MRDH = 0;
	DEBUGX = `DEBUGX_STEP;
	DEBUG_OP_INCX = 0;
	DEBUG_ACK = 0;
	`TICKTOCK;
	RESET = 1;
	`TICKTOCK;
	RESET = 0;
	`TICKTOCK;
	// Generate a basic req
	DEBUG_MODE_REQ_BIT = 1;
	EN_MODE = 1;
	#10;
	DEBUG_WR = 1;
	`TICKTOCK;
	DEBUG_WR = 0;
	`TICKTOCK;
	DEBUG_MODE_REQ_BIT = 0;
	EN_MODE = 0;	
	`assert("DEBUG_REQ", 1, DEBUG_REQ)
	`TICKTOCK;
	// ACK it
	DEBUG_ACK = 1;
	`TICKTOCK;
	DEBUG_ACK = 0;
	`assert("DEBUG_REQ", 0, DEBUG_REQ)
	`TICKTOCK;
	
	// Generate a req from a DH write with INCX set
	DEBUG_OP_INCX = 1;
	EN_MRDH = 1;
	`TICKTOCK;
	DEBUG_WR = 1;
	`TICKTOCK;
	DEBUG_WR = 0;
	`TICKTOCK;
	EN_MRDH = 0;
	`assert("DEBUG_REQ", 1, DEBUG_REQ)
	`TICKTOCK;
	// ACK it
	DEBUG_ACK = 1;
	`TICKTOCK;
	DEBUG_ACK = 0;
	`assert("DEBUG_REQ", 0, DEBUG_REQ)
	`TICKTOCK;
	
	
	// Generate a req from a DH read with INCX set
	DEBUG_OP_INCX = 1;
	EN_MRDH = 1;
	`TICKTOCK;
	DEBUG_RD = 1;
	`TICKTOCK;
	DEBUG_RD = 0;
	`TICKTOCK;
	EN_MRDH = 0;
	`assert("DEBUG_REQ", 1, DEBUG_REQ)
	`TICKTOCK;
	// ACK it
	DEBUG_ACK = 1;
	`TICKTOCK;
	DEBUG_ACK = 0;
	`assert("DEBUG_REQ", 0, DEBUG_REQ)
	`TICKTOCK;
	

end


endmodule