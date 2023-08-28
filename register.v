/**
* All registers are capable of increment or decrement
* by two. This is so they can be used as PC, stack pointers etc.
**/
module register(
	input CLK,
	input INC_DECN,
	input LDN,
	input IDN,
	input OEN_A,
	input OEN_B,
	input OEN_C,
	input RESETN,
	input [15:0] DIN,
	output [15:0] DBUS_A,
	output [15:0] DBUS_B,
	output [15:0] DBUS_C
);

reg [15:0] DOUT;

initial begin
	DOUT = 16'h0000;
end

assign DBUS_A = OEN_A ? 16'hzzzz : DOUT;
assign DBUS_B = OEN_B ? 16'hzzzz : DOUT;
assign DBUS_C = OEN_C ? 16'hzzzz : DOUT;

always @ (posedge CLK)
begin
	if(!RESETN)
	begin 
		DOUT <= 0; 
	end else if(!LDN) 
	begin // Preload takes precedence over INC/DEC
		DOUT <= DIN;
	end else if(!IDN) 
	begin // Enable inc/dec
		if(INC_DECN) 
		begin // Increment
			DOUT <= DOUT + 2;
		end else 
		begin
			DOUT <= DOUT - 2;
		end
	end

end

endmodule