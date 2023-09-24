module pcTestHarness (

	input	RESET,
	input	JMPX,
	input   JRX,
	output  LOCK, 
	output  [7:0] addr
);

	wire [15:0] PC_D;
	wire [15:0] PC_A;

	wire CLKOP;
	wire CLKOS;
	wire OSC;
	wire CLK;
	wire PC_EN;
	
	assign PC_EN = 1'b1;
	
	assign PC_D = 16'h1234;
	
	assign addr[7:0] = PC_A[15:8];
	
	OSCH OSCinst0 (.STDBY(1'b0), .OSC(OSC), .SEDSTDBY());
	defparam OSCinst0.NOM_FREQ = "20.46";
	
	pll pll_inst (.CLKI(OSC), .CLKOP(CLKOP), .CLKOS3(CLKOS), .LOCK(LOCK));
	
	prescaler psc(.clk_in(CLKOS), .clk_out(CLK));
	
	programCounter pc(
		.CLK(CLK),
		.RESET(RESET),
		.PC_EN(PC_EN)
		
	);
	
	
endmodule