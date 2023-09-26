`timescale 1 ns / 1 ns
`include "C:/Users/Duncan/git/ForthCPU/constants.v"
`include "C:/Users/Duncan/git/ForthCPU/testSetup.v"

module processorCoreTests;
	
reg CLK;
reg RESET;
	
wire FETCH;
wire DECODE;
wire EXECUTE;
wire COMMIT;

wire [15:0] ABUS;
wire [15:0] DBUS_OUT;
reg [15:0] DBUS_IN;

wire RD;
wire WR;
PUR PUR_INST(.PUR(1'b1));
GSR GSR_INST(.GSR(1'b1));
	
	

core testInstance(
	
	.CLK(CLK),
	.RESET(RESET),
	
	.FETCH(FETCH), 
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	
	.ABUS(ABUS),
	.DBUS_OUT(DBUS_OUT),
	.DBUS_IN(DBUS_IN),
	
	.RD(RD),
	.WR(WR)

);


// clk gen
always begin
	#50 CLK = ~CLK;
end

initial begin
	#10
	CLK = 0; 
	`TICK;
	 RESET = 1;
	 DBUS_IN = 16'h0000;
	 `TICK;
	 `TICK;
	 
	 RESET = 0;  
	 `TICKTOCK;
	 `TICKTOCK;
	 `TICKTOCK;
	 
	 /************************************************************************
	 * LD Ra,(Rb)
	 *************************************************************************/
	 // Start FETCH
	 DBUS_IN = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_REGB_U8,8'b10101111};	 
	 `TICKTOCK;  
	// DECODE
	`TICKTOCK; 
	// EXECUTE 
	// Control outputs become valid here

	
	// COMMIT
	`TICKTOCK;

	
	`TICKTOCK
	
	 /************************************************************************
	 * LD Ra,(--Rb)
	 *************************************************************************/
	// FETCH
	DBUS_IN = {`GROUP_LOAD_STORE,`LDSF_NONE,`LDS_ST,`MODE_REG_MEM,`R0,`RB};	 
	`TICKTOCK;
	 
	// DECODE
	`TICKTOCK; 

	// EXECUTE 
	// Control outputs become valid here

	
	// COMMIT
	`TICKTOCK;

		
	
	`TICKTOCK
	
	 /************************************************************************
	 * LD Ra,(Rb++)
	 *************************************************************************/
	// FETCH
	DBUS_IN = {`GROUP_LOAD_STORE,`LDSF_POST_INC,`LDS_LD,`MODE_REG_MEM,`R5,`RI};	 
	 `TICKTOCK;
	 
	// DECODE
	`TICKTOCK; 

	// EXECUTE 
	// Control outputs become valid here

	
	// COMMIT
	`TICKTOCK;

	`TICKTOCK;
	
end
	
endmodule