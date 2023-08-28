module register_file(

	input [15:0] DIN,
	input [3:0] ADDR_A,
	input [3:0] ADDR_B,
	input LDN,
	input UP_DOWNN,
	input IDN,
	input CLK,
	input RESETN,
	
	output [15:0] DOUT_A,
	output [15:0] DOUT_B,
	output [15:0] DOUT_C
	
);

reg [15:0] INC_DECX;
reg [15:0] LDX;
reg [15:0] IDX;
reg [15:0] OEN_A;
reg [15:0] OEN_B;
reg [15:0] OEN_C;

register registers[15:0] (
	.CLK(CLK),
	.RESETN(RESETN),
	.INC_DECN(INC_DECX),
	.DIN(DIN),
	.DBUS_A(DOUT_A),
	.DBUS_B(DOUT_B),
	.DBUS_C(DOUT_C),
	.LDN(LDX),
	.IDN(IDX),
	.OEN_A(OEN_A),
	.OEN_B(OEN_B),
	.OEN_C(OEN_C)
);

integer i;




always @ (*)
begin
	OEN_A = 16'hffff;
	OEN_A[ADDR_A] = 0;
	OEN_B = 16'hffff;
	OEN_B[ADDR_B] = 0;
	OEN_C = 16'hffff;
	OEN_C[15] = 0; // always output the PC
	INC_DECX = UP_DOWNN;
	INC_DECX[15] = 1; // Always increment the PC
	IDX[15] = 0;
	
	if(!LDN)
	begin
		// load data to the register selected by ADDR_A
		LDX <= 16'hffff;
		LDX[ADDR_A] <= 0;
	end else if(!IDN)
	begin
		// enable inc/dec
		IDX <= 16'h0fff;
		IDX[ADDR_A] <= 0;
	end
end
		



endmodule