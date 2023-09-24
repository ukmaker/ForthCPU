`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module programCounterTestbench;
	
reg CLK;
reg RESET;
reg PC_EN;
reg COMMIT;
reg [15:0] PC_D;
reg JRX;
reg CC_SIGN;
reg CC_CARRY;
reg CC_ZERO;
reg CC_PARITY;

reg [1:0] CC_SELECTX;
reg CC_INVERTX;
reg CC_APPLYX;
reg JMPX;

wire [15:0] PC_A;
	
programCounter testInstance(

.CLK(CLK),
.RESET(RESET),
.PC_EN(PC_EN),
.COMMIT(COMMIT),
.PC_D(PC_D),
.JRX(JRX),
.CC_SIGN(CC_SIGN),
.CC_CARRY(CC_CARRY),
.CC_ZERO(CC_ZERO),
.CC_PARITY(CC_PARITY),
.CC_SELECTX(CC_SELECTX),
.CC_INVERTX(CC_INVERTX),
.CC_APPLYX(CC_APPLYX),
.JMPX(JMPX),
.PC_A(PC_A)
);


// clk gen
always begin
	#50 CLK = ~CLK;
end


initial begin
	#(10) CLK = 0; 
	`TICK;
	RESET = 1;
	CC_SIGN = 0;
	CC_CARRY = 0;
	CC_ZERO = 0;
	CC_PARITY = 0;
	CC_INVERTX = `CC_INVERTX_NONE;
	CC_SELECTX = `CC_SELECTX_Z;
	CC_APPLYX = `CC_APPLYX_NONE;
	JMPX = `JMPX_NONE;
	JRX = `JRX_REL;
	PC_EN = 0;
	COMMIT = 0;
	
	PC_D = 16'h1234;

	`TICKTOCK;
	RESET = 0;  
	PC_EN = 1;
	COMMIT = 1;
	
	`TICKTOCK;
	`assert("PC=0", 16'h0002, PC_A)
	
	`TICKTOCK;
	`assert("PC=0", 16'h0004, PC_A)
	
	`TICKTOCK;
	`assert("PC=0", 16'h0006, PC_A)
	JMPX = `JMPX_JMP;
	JRX = `JRX_REL;
	
	`TICKTOCK;
	`assert("PC=0", 16'h123a, PC_A)
	JRX = `JRX_ABS;
	
	`TICKTOCK;
	`assert("PC=0", 16'h1234, PC_A)
	JMPX = `JMPX_NONE;
	JRX = `JRX_REL;
	CC_APPLYX = `CC_APPLYX_APPLY;
	PC_D = 16'h0010;
	
	`TICKTOCK;
	`assert("PC=0", 16'h1236, PC_A)
	
	CC_SELECTX = `CC_SELECTX_Z;
	CC_ZERO = 1;	
	`TICKTOCK;
	`assert("PC=0", 16'h1246, PC_A)
	CC_ZERO = 0;	
	`TICKTOCK;
	`assert("PC=0", 16'h1248, PC_A)
	
	
	CC_SELECTX = `CC_SELECTX_C;
	CC_CARRY = 1;	
	`TICKTOCK;
	`assert("PC=0", 16'h1258, PC_A)
	CC_CARRY = 0;	
	`TICKTOCK;
	`assert("PC=0", 16'h125a, PC_A)
	
	
	CC_SELECTX = `CC_SELECTX_S;
	CC_SIGN = 1;	
	`TICKTOCK;
	`assert("PC=0", 16'h126a, PC_A)
	CC_SIGN = 0;	
	`TICKTOCK;
	`assert("PC=0", 16'h126c, PC_A)
	
	
	CC_SELECTX = `CC_SELECTX_P;
	CC_PARITY = 1;	
	`TICKTOCK;
	`assert("PC=0", 16'h127c, PC_A)
	CC_PARITY = 0;	
	`TICKTOCK;
	`assert("PC=0", 16'h127e, PC_A)
	
	
end

endmodule
