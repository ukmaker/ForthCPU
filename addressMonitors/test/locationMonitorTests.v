`include "../../constants.v"
`include "../../testSetup.v"

module locationMonitorTests;
	
	reg CLK;
	reg RESET;
	reg ENABLE;
	reg [15:0] DATA;
	reg [15:0] ADDR;
	reg LD;
	
	wire AT_ADDR;
	
	reg RESETADDR;
	
locationMonitor testArticle(
	.CLK(CLK),
	.RESET(RESET),
	.ENABLE(ENABLE),
	.DATA(DATA),
	.LD(LD),
	.ADDR(ADDR),
	
	.AT_ADDR(AT_ADDR)
);

always begin
	#50 CLK = ~CLK;
end

always @(posedge CLK or posedge RESET) begin
	if(RESET | RESETADDR) begin
		ADDR <= 16'h0000;
	end else begin
		ADDR <= ADDR + 1;
	end
end

initial begin
	RESET = 0;
	RESETADDR = 0;
	CLK = 0;
	LD = 0;
	ENABLE = 0;
	#100;
	RESET = 1;
	#100;
	RESET = 0;
	#105;
	`assert("AT_ADDR", 1'b0, AT_ADDR)
	DATA = 16'h0003;
	LD = 1'b1;
	#100;
	LD = 1'b0;
	`assert("AT_ADDR", 1'b0, AT_ADDR)
	#100;
	`assert("AT_ADDR", 1'b0, AT_ADDR)
	#100;
	`assert("AT_ADDR", 1'b0, AT_ADDR)
	#100;
	`assert("AT_ADDR", 1'b0, AT_ADDR)
	#100;
	`assert("AT_ADDR", 1'b0, AT_ADDR)
	ENABLE = 1'b1;
	#100;
	ENABLE = 1'b0;
	RESETADDR = 1;
	#100;
	RESETADDR = 0;
	#100;
	`assert("AT_ADDR", 1'b0, AT_ADDR)
	#100;
	`assert("AT_ADDR", 1'b0, AT_ADDR)
	#100;
	`assert("AT_ADDR", 1'b0, AT_ADDR)
	#100;
	`assert("AT_ADDR", 1'b0, AT_ADDR)
	#100;
	`assert("AT_ADDR", 1'b0, AT_ADDR)
	ENABLE = 1'b1;
	LD = 1'b1;
	#100;
	ENABLE = 1'b0;
	LD = 1'b0;
	RESETADDR = 1;
	#100;
	RESETADDR = 0;
	#100;
	`assert("AT_ADDR", 1'b0, AT_ADDR)
	#100;
	`assert("AT_ADDR", 1'b0, AT_ADDR)
	#100;
	`assert("AT_ADDR", 1'b1, AT_ADDR)
	#100;
	`assert("AT_ADDR", 1'b0, AT_ADDR)
	#100;
	`assert("AT_ADDR", 1'b0, AT_ADDR)
end

endmodule