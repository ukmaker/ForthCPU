module pcTestHarness (

	input	reset,
	input	[1:0] pc_opx,
	output LOCK, 
	output [7:0] addr
);

	wire [15:0] pc_dw;
	wire [15:0] ao;

	wire CLKOP;
	wire CLKOS;
	wire pc_clk;
	
	assign pc_dw = 16'h1234;
	
	assign addr[7:0] = ao[15:8];
	
	OSCH OSCinst0 (.STDBY(1'b0), .OSC(clk), .SEDSTDBY());
	defparam OSCinst0.NOM_FREQ = "20.46";
	
	pll pll_inst (.CLKI(clk), .CLKOP(CLKOP), .CLKOS3(CLKOS), .LOCK(LOCK));
	
	prescaler psc(.clk_in(CLKOS), .clk_out(pc_clk));
	
	program_counter pc(
		.clk(pc_clk),
		.pc_resetx(reset),
		.pc_opx(pc_opx),
		.pc_d(pc_dw),
		.pc_a(ao)
	);
	
	
endmodule