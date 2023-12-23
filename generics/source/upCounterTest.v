`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module upCounterTest;
	
	reg CLK;
	reg RESET;
	reg [7:0] DIN;
	reg ENL;
	reg ENH;
	reg CP;
	reg LDH;
	reg LDL;
	
	wire [7:0] DOUTL;
	wire [7:0] DOUTH;
	wire ROL;
	wire ROH;
	reg RIL;
	

upCounter low(
	.CLK(CLK),
	.RESET(RESET),
	.DIN(DIN),
	.EN(ENL),
	.DOUT(DOUTL),
	.RO(ROL),
	.RI(RIL),
	.CP(CP),
	.LD(LDL)
);

upCounter hi(
	.CLK(CLK),
	.RESET(RESET),
	.DIN(DIN),
	.EN(ENH),
	.RO(ROH),
	.RI(ROL),
	.CP(CP),
	.DOUT(DOUTH),
	.LD(LDH)
);

always begin
	#50 CLK = ~CLK;
end

always begin
	#10;
	LDL = 1'b0;
	LDH = 1'b0;
	ENL = 0;
	ENH = 0;
	CP = 1;
	RESET = 1;
	CLK = 0;
	#100;
	RESET = 0;
	#100;
	/**
	* Enable the L counter - should not count
	**/
	ENL = 1;
	#200;
	/**
	* Set RIL high - should start counting
	**/
	RIL = 1;
	/**
	* Load the L counter
	**/
	LDL = 1;
	DIN = 8'haa;
	#100;
	LDL = 0;
	/**
	* Should continue counting
	**/
	#300;
	
	ENL = 1;
	LDL = 1;
	DIN = 8'hfe;
	#100;
	LDL = 0;
	LDH= 1;
	ENL = 1;
	DIN = 8'hfe;
	#100;
	LDH = 0;
	ENH = 1;
	#300;
	
	#1000;
	
	ENL = 0;
	LDL = 1;
	DIN = 8'hff;
	#100;
	LDL = 0;
	LDH= 1;
	DIN = 8'hff;
	#100;
	LDH = 0;
	ENL = 1;
	#300;
	
	#1000;
	
	
end

endmodule
	