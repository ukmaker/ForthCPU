`include "../../constants.v"

/**************************************************
* Snoop the address and data buses
* and capture instruction and argument
* address and data.
***************************************************/

module snooper (
	
	input CLK,
	input RESET,
	input FETCH, DECODE, EXECUTE, COMMIT,
	
	/******************************************
	* Inputs from the CPU
	*******************************************/
	input [15:0] DIN,
	input [15:0] ADDR,
	
	/******************************************
	* Input from DEBUG_SEQ for
	* debug cycles to enable internal register
	* reads which put data on the bus but do not
	* run a normal write-cycle
	*******************************************/
	input DEBUG_SNOOP_LD_EN,
	
	/******************************************
	* Select the register to read
	*******************************************/
	input [1:0]       SNOOP_REGX,
	output reg [15:0] SNOOP_REG
);
/******************************************
* Internal capture registers
******************************************/
reg [15:0] SNOOP_INST_ADDR;
reg [15:0] SNOOP_INST_DATA;
reg [15:0] SNOOP_ARG_ADDR;
reg [15:0] SNOOP_ARG_DATA;

always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		SNOOP_INST_ADDR <= 16'h0000;
		SNOOP_INST_DATA <= 16'h0000;
		SNOOP_ARG_ADDR  <= 16'h0000;
		SNOOP_ARG_DATA  <= 16'h0000;
	end else begin
		if(EXECUTE & DEBUG_SNOOP_LD_EN) begin
			// Instruction capture
			SNOOP_INST_ADDR <= ADDR;
			SNOOP_INST_DATA <= DIN;
		end else if(COMMIT & DEBUG_SNOOP_LD_EN) begin
			// arg capture
			SNOOP_ARG_ADDR  <= ADDR;
			SNOOP_ARG_DATA  <= DIN;
		end
	end
end

always @(*) begin
	case(SNOOP_REGX)
		`SNOOP_REGX_INST_ADDR: SNOOP_REG = SNOOP_INST_ADDR;
		`SNOOP_REGX_INST_DATA: SNOOP_REG = SNOOP_INST_DATA;
		`SNOOP_REGX_ARG_ADDR:  SNOOP_REG = SNOOP_ARG_ADDR;
		`SNOOP_REGX_ARG_DATA:  SNOOP_REG = SNOOP_ARG_DATA;
	endcase
end


endmodule