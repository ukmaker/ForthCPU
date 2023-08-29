/**
* REGX 2 1 0
*      |  |  |
*      |  |   - Load (1) data to the register addressed by ADDR_A
*      |  ----- Enable (1) inc/dec on the register addressed by ADDR_B*      -------- Increment (1) or decrement (0)
**/
module register_file(

	input [15:0] DIN,
	input [3:0] ADDR_A,
	input [3:0] ADDR_B,
	input [2:0] REGX,
	input CLK,
	input RESETN,
	
	output reg [15:0] DOUT_A,
	output reg [15:0] DOUT_B,
	output reg [15:0] DOUT_PC
	
);

reg [14:0] INC_DECN;
reg [15:0] LD_EN;
reg [14:0] INC_DEC_EN;
reg [15:0] OEN_A;
reg [15:0] OEN_B;
wire [15:0] DBUS;

register registers[15:0] (
	.CLK(CLK),
	.RESETN(RESETN),
	.INC_DECN({ 1'b1, INC_DECN }),    // Always increment the PC r15
	.INC_DEC_EN({ 1'b1, INC_DEC_EN}), // 
	.DIN(DIN),
	.DOUT(DBUS),
	.LD_EN(LD_EN)
);

always @ (*)
begin
	OEN_A = 16'hffff;
	OEN_A[ADDR_A] = 0;
	OEN_B = 16'hffff;
	OEN_B[ADDR_B] = 0;
	DOUT_PC <= registers[15].DOUT;
	INC_DEC_EN = 0;
	INC_DECN = 0;
	
	if(!REGX[0])
	begin
		// load data to the register selected by ADDR_A
		LD_EN <= 16'hffff;
		LD_EN[ADDR_A] <= 0;
	end else if(REGX[1])
	begin
		INC_DEC_EN[ADDR_B] = 1;
	
		if(REGX[2]) // Increment
		begin
				INC_DECN[ADDR_B] = 1;
		end
	end
end
		

endmodule