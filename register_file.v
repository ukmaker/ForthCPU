module register_file(

	input [15:0] DIN,
	input [3:0] ADDR_A,
	input [3:0] ADDR_B,
	input UP_DOWNN,
	input LDN,
	input IDN,
	input CLK,
	input RESETN,
	
	output [15:0] DOUT_A,
	output [15:0] DOUT_B
	
);

reg [15:0] LDX;
reg [15:0] IDX;
reg [15:0] OEN_A;
reg [15:0] OEN_B;

register registers[15:0] (
	.CLK(CLK),
	.RESETN(RESETN),
	.INC_DECN(UP_DOWNN),
	.DIN(DIN),
	.DBUS_A(DOUT_A),
	.DBUS_B(DOUT_B),
	.LDN(LDX),
	.IDN(IDX),
	.OEN_A(OEN_A),
	.OEN_B(OEN_B)
);

integer i;


always @ (*)
begin
	OEN_A = 16'hffff;
	OEN_A[ADDR_A] = 0;
	OEN_B = 16'hffff;
	OEN_B[ADDR_B] = 0;
	
	if(!LDN)
	begin
		// load data to the register selected by ADDR_A
		LDX <= 16'hffff;
		LDX[ADDR_A] <= 0;
	end else if(!IDN)
	begin
		// enable inc/dec
		IDX <= 16'hffff;
		IDX[ADDR_A] <= 0;
	end
end
		



endmodule