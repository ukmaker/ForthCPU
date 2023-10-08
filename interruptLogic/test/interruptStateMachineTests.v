`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

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
	.PC_LD_INT1(PC_LD_INT1)
);


// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	#10
	CLK = 0;
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
	
	// Ignore INT0
	INT0 = 1;
	`TICKTOCK;
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	COMMIT = 1; //1
	`TICKTOCK;
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	// Ignore INT1
	INT0 = 0;
	INT1 = 1;
	COMMIT = 0;
	`TICKTOCK;
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	COMMIT = 1; //2
	`TICKTOCK;
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)

	// Ignore INT0 and INT1
	INT0 = 1;
	INT1 = 1;
	COMMIT = 0;
	`TICKTOCK;
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	COMMIT = 1; //3
	`TICKTOCK;
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	 
	 // Enable interrupts
	 INT0 = 0;
	 INT1 = 0;
	 EIX = 1;
	 COMMIT = 0;
	`TICKTOCK;
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	COMMIT = 1; //4
	`TICKTOCK;
	`assert("PC_NEXTX", `PC_NEXTX_NEXT, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	// Now we should handle an interrupt
	EIX = 0;
	INT1 = 1;
	COMMIT = 0;
	`TICKTOCK;
	`assert("PC_NEXTX", `PC_NEXTX_INTV1, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 1, PC_LD_INT1)
	
	COMMIT = 1; //5
	`TICKTOCK;
	`assert("PC_NEXTX", `PC_NEXTX_INTV1, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 1, PC_LD_INT1)
	
	// Normal return from interrupt
	INT1 = 0;
	RETIX = 1;
	COMMIT = 0;
	`TICKTOCK;
	`assert("PC_NEXTX", `PC_NEXTX_INTR1, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	 
	COMMIT = 1; //6
	`TICKTOCK;
	`assert("PC_NEXTX", `PC_NEXTX_INTR1, PC_NEXTX)
	`assert("PC_LD_INT0", 0, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	// INT0 takes priority
	INT0 = 1;
	INT1 = 1;
	RETIX = 0;
	COMMIT = 0;
	`TICKTOCK;
	`assert("PC_NEXTX", `PC_NEXTX_INTV0, PC_NEXTX)
	`assert("PC_LD_INT0", 1, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	
	COMMIT = 1; //7
	`TICKTOCK;
	`assert("PC_NEXTX", `PC_NEXTX_INTV0, PC_NEXTX)
	`assert("PC_LD_INT0", 1, PC_LD_INT0)
	`assert("PC_LD_INT1", 0, PC_LD_INT1)
	

 end
 
 endmodule
