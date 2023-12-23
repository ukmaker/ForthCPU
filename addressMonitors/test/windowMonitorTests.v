`include "../../constants.v"
`include "../../testSetup.v"

module windowMonitorTests;
	
	reg CLK;
	reg RESET;
	reg ENABLE;
	reg [15:0] DATA;
	reg [15:0] ADDR;
	reg LD_START;
	reg LD_END;
	
	wire IN_WINDOW;
	
	reg RESETADDR;
	
windowMonitor testArticle(
	.CLK(CLK),
	.RESET(RESET),
	.ENABLE(ENABLE),
	.DATA(DATA),
	.LD_START(LD_START),
	.LD_END(LD_END),
	.ADDR(ADDR),
	
	.IN_WINDOW(IN_WINDOW)
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
	LD_START = 0;
	LD_END = 0;
	ENABLE = 0;
	#100;
	RESET = 1;
	#100;
	RESET = 0;
	#105;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	DATA = 16'h0003;
	LD_START = 1'b1;
	#100;
	LD_START = 1'b0;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	ENABLE = 1'b1;
	#100;
	ENABLE = 1'b0;
	RESETADDR = 1;
	#100;
	RESETADDR = 0;
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	
	LD_END = 1'b1;
	#100;
	LD_END = 1'b0;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	ENABLE = 1'b1;
	#100;
	ENABLE = 1'b0;
	RESETADDR = 1;
	#100;
	RESETADDR = 0;
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	
	// Now set up a window
	ENABLE = 1'b0;
	LD_START = 1'b1;
	DATA = 16'h0003;
	#100;
	LD_START = 0;
	LD_END = 1;
	ENABLE = 1;
	DATA = 16'h0006;
	#100;
	ENABLE = 1'b0;
	LD_END = 1'b0;
	RESETADDR = 1'b1;
	#100;
	RESETADDR = 1'b0;
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b1, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b1, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b1, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b1, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	#100;
	`assert("IN_WINDOW", 1'b0, IN_WINDOW)
	
	

end

endmodule