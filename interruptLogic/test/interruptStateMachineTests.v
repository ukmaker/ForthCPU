`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module interruptStateMachineTests;
	
	reg CLK;
	reg RESET;
	reg COMMIT;
	
	reg RETIX;
	reg EIX;
	reg DIX;

	reg INT0;
	reg INT1;
	
	wire [2:0] PC_NEXTX;
	wire PC_LD_INT0;
	wire PC_LD_INT1;
	
	wire [1:0] CC_REGX;
	wire CCL_ENRX;
	wire CCL_EN0X;
	wire CCL_EN1X;
	
interruptStateMachine testInstance(
	.CLK(CLK),
	.RESET(RESET),
	.COMMIT(COMMIT),
	.RETIX(RETIX),
	.INT0(INT0),
	.INT1(INT1),
	.EIX(EIX),
	.DIX(DIX),
	.PC_NEXTX(PC_NEXTX),
	.PC_LD_INT0(PC_LD_INT0),
	.PC_LD_INT1(PC_LD_INT1),
	.CC_REGX(CC_REGX),
	.CCL_ENRX(CCL_ENRX),
	.CCL_EN0X(CCL_EN0X),
	.CCL_EN1X(CCL_EN1X)
);


// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	CLK = 0;
	#60
	RESET = 1;
	`TICKTOCK;
	
	RETIX = 0;
	INT0 = 0;
	INT1 = 0;
	EIX = 0;
	DIX = 0;
	COMMIT = 0;
	RESET=0;
	`TICKTOCK;
	`TICKTOCK;
	$display("1>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	// Always handkle INT0 (NMI)
	INT0 = 1;
	`TICKTOCK;
	$display("2>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	COMMIT = 1; //1
	`TICKTOCK;
	$display("3>>");
	`assert("PC_NEXTX", `PC_NEXTX_INTV0, PC_NEXTX)
	`assert("PC_LD_INT0", 1, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	// Ignore INT1 - interrupts not yet enabled
	INT0 = 0;
	INT1 = 1;
	COMMIT = 0;
	`TICKTOCK;
	$display("4>>");
	`assert("PC_NEXTX", `PC_NEXTX_INTV0, PC_NEXTX)
	`assert("PC_LD_INT0", 1, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	COMMIT = 1; //2
	`TICKTOCK;
	$display("5>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)

	// Ignore INT0 and INT1
	INT0 = 1;
	INT1 = 1;
	COMMIT = 0;
	`TICKTOCK;
	$display("6>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	COMMIT = 1; //3
	`TICKTOCK;
	$display("7>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	 
	// Normal return from interrupt
	INT0 = 0;
	INT1 = 0;
	RETIX = 1;
	COMMIT = 0;
	`TICKTOCK;
	$display("8>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	 
	COMMIT = 1; //6
	`TICKTOCK;
	$display("9>>");
	`assert("PC_NEXTX", `PC_NEXTX_INTR0, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	// Enable interrupts
	RETIX = 0;
	INT0 = 0;
	INT1 = 0;
	EIX = 1;
	COMMIT = 0;
	`TICKTOCK;
	$display("10>>");
	`assert("PC_NEXTX", `PC_NEXTX_INTR0, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	COMMIT = 1; //4
	`TICKTOCK;
	$display("11>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	// Now we should handle an interrupt
	EIX = 0;
	INT1 = 1;
	COMMIT = 0;
	`TICKTOCK;
	$display("12>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)

	COMMIT = 1;
	`TICKTOCK;
	$display("13>>");
	`assert("PC_NEXTX", `PC_NEXTX_INTV1, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 1, PC_LD_INT1)

	// Run the interrupt
	COMMIT = 0;
	`TICKTOCK;
	$display("14>>");
	`assert("PC_NEXTX", `PC_NEXTX_INTV1, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 1, PC_LD_INT1)

	COMMIT = 1;
	`TICKTOCK;
	$display("15>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	// Normal return from interrupt
	INT0 = 0;
	INT1 = 0;
	RETIX = 1;
	COMMIT = 0;
	`TICKTOCK;
	$display("16>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	 
	COMMIT = 1;
	`TICKTOCK;
	$display("17>>");
	`assert("PC_NEXTX", `PC_NEXTX_INTR1, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	RETIX = 0;
	COMMIT = 0;
	`TICKTOCK;
	$display("18>>");
	`assert("PC_NEXTX", `PC_NEXTX_INTR1, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)

	COMMIT = 1;
	`TICKTOCK;
	$display("19>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)

	// Now we should handle an interrupt
	EIX = 0;
	INT1 = 1;
	COMMIT = 0;
	`TICKTOCK;
	$display("20>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)

	COMMIT = 1;
	`TICKTOCK;
	$display("21>>");
	`assert("PC_NEXTX", `PC_NEXTX_INTV1, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 1, PC_LD_INT1)

	// Run the interrupt
	INT1 = 0;
	COMMIT = 0;
	`TICKTOCK;
	$display("22>>");
	`assert("PC_NEXTX", `PC_NEXTX_INTV1, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 1, PC_LD_INT1)

	COMMIT = 1;
	`TICKTOCK;
	$display("23>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)

	// Nest an INT0
	EIX = 0;
	INT1 = 0;
	INT0 = 1;
	COMMIT = 0;
	`TICKTOCK;
	$display("24>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)

	COMMIT = 1;
	`TICKTOCK;
	$display("25>>");
	`assert("PC_NEXTX", `PC_NEXTX_INTV0, PC_NEXTX)
	`assert("PC_LD_INT0", 1, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)

	// Run the interrupt
	INT0 = 0;
	COMMIT = 0;
	`TICKTOCK;
	$display("26>>");
	`assert("PC_NEXTX", `PC_NEXTX_INTV0, PC_NEXTX)
	`assert("PC_LD_INT0", 1, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)

	COMMIT = 1;
	`TICKTOCK;
	$display("27>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)

	// Nested return from interrupt
	INT0 = 0;
	INT1 = 0;
	RETIX = 1;
	COMMIT = 0;
	`TICKTOCK;
	$display("28>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	 
	COMMIT = 1;
	`TICKTOCK;
	$display("29>>");
	`assert("PC_NEXTX", `PC_NEXTX_INTR0, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)

	RETIX = 1;
	COMMIT = 0;
	`TICKTOCK;
	$display("30>>");
	`assert("PC_NEXTX", `PC_NEXTX_INTR0, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	 
	COMMIT = 1;
	`TICKTOCK;
	$display("31>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)

	// Normal return from interrupt
	INT0 = 0;
	INT1 = 0;
	RETIX = 1;
	COMMIT = 0;
	`TICKTOCK;
	$display("32>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	 
	COMMIT = 1;
	`TICKTOCK;
	$display("33>>");
	`assert("PC_NEXTX", `PC_NEXTX_INTR1, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	RETIX = 0;
	COMMIT = 0;
	`TICKTOCK;
	$display("34>>");
	`assert("PC_NEXTX", `PC_NEXTX_INTR1, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)

	COMMIT = 1;
	`TICKTOCK;
	$display("35>>");
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)

 end
 
 endmodule
