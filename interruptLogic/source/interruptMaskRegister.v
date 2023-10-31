`include "../../constants.v"
/************************************************************
* Implements masking of interrupt sources
* Status read of active interrupts
* Priority encoding
*************************************************************/
module interruptMaskRegister(
	
	input CLK,
	input RESET,
	input [7:0] DIN,
	input RD,
	input WR,
	input [1:0] ADDR,
	
	input INTS1,
	input INTS2,
	input INTS3,
	input INTS4,
	input INTS5,
	input INTS6,
	input INTS7,
	
	output reg [15:0] DOUT,
	output reg INT1
	
);

reg INT;
reg [7:0] INTS;
reg [7:0] PRI;
reg [7:0] MASK_REG;
reg [7:0] INTS_REG;
reg [2:0] PRI_REG;

always @(*) begin
	// Combinational logic
		INTS = {INTS7,INTS6,INTS5,INTS4,INTS3,INTS2,INTS1,1'b0} & MASK_REG;
		// Highest priority is INT1
		PRI = INTS[1] ? 1 :
				  INTS[2] ? 2 :
				  INTS[3] ? 3 :
				  INTS[4] ? 4 :
				  INTS[5] ? 5 :
				  INTS[6] ? 6 :
				  INTS[7] ? 7 : 0;
		INT = PRI != 0;
		
		DOUT = 8'h00;
		if(RD) begin
			case(ADDR)
				2'b00: DOUT = MASK_REG;
				2'b01: DOUT = INTS_REG;
				2'b10: DOUT = PRI_REG;
				2'b11: DOUT = 8'h00;
			endcase
		end
end

always @(posedge CLK or posedge RESET) begin
	
	if(RESET) begin
		MASK_REG <= 8'h00;
		INTS_REG <= 8'h00;
		PRI_REG  <= 3'b000;
		INT1     <= 0;
	end else begin
		if(WR) begin
			if(ADDR == 2'b00) MASK_REG <= DIN;
		end
				
		INTS_REG <= INTS;
		PRI_REG <= PRI;
		INT1 <= INT;
  end
end
endmodule
		
		