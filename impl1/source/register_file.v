/**
*
*
* The register operation performed during a clock cycle is
* controlled by the REGOPX bits
* REGAOPX  - Load (1) data to the register addressed by ADDR_A
*
* REGBOPX 1  0
*         |  |  
*         |  ----- Enable (1) inc/dec on the register addressed by ADDR_B*         -------- Increment (1) or decrement (0)
**/
module register_file(

	input [15:0] DIN,
	input [3:0] REGAX,
	input [3:0] REGBX,
	input REGAOPX,
	input [1:0] REGBOPX,
	input CLK,
	input RESETN,
	
	output  [15:0] DOUT_A,
	output  [15:0] DOUT_B,
	output  [15:0] DOUT_PC
	
);

reg [14:0] INC_DECN;
reg [15:0] LD_EN;
reg [14:0] INC_DEC_EN;
reg [15:0] OEN_A;
reg [15:0] OEN_B;
reg [15:0] OEN_C;
reg [15:0] OEN_DATA;
reg [15:0] OEN_ADDR;
reg [15:0] OEN_REG;

wire [15:0] DBUS;

register registers[15:0] (
	.CLK(CLK),
	.RESETN(RESETN),
	.INC_DECN({ 1'b1, INC_DECN }),    // Always increment the PC r15
	.INC_DEC_EN({ 1'b1, INC_DEC_EN}), // 
	.DIN(DIN),
	.OEN_A(OEN_A),
	.OEN_B(OEN_B),
	.OEN_C(16'h7fff),
	.DOUT_A(DOUT_A),
	.DOUT_B(DOUT_B),
	.DOUT_C(DOUT_PC),
	.LD_EN(LD_EN)
);

always @ (*)
begin
	OEN_A = 16'hffff;
	OEN_A[REGAX] = 0;
	OEN_B = 16'hffff;
	OEN_B[REGBX] = 0;
	INC_DEC_EN = 16'hffff;
	INC_DECN = 16'hffff;
	LD_EN = 16'hffff;
	LD_EN[REGAX] <= ~REGAOPX;
	INC_DEC_EN[REGBX] = ~REGBOPX[0];
	INC_DECN[REGBX] = REGBOPX[1];
end
		

endmodule