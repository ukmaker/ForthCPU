/**
* All registers are capable of increment or decrement
* by two. This is so they can be used as PC, stack pointers etc.
**/
module register(
	input CLK,
	input INC_DECN,
	input INC_DEC_EN,
	input LD_EN,	
	input RESETN,
	input [15:0] DIN,
	input OEN_A, OEN_B, OEN_C,
	output tri [15:0] DOUT_A,
	output tri [15:0] DOUT_B,
	output tri [15:0] DOUT_C
);

reg [15:0] DOUT;

initial begin
	DOUT = 16'h0000;
end

always @ (posedge CLK)
begin
	if(!RESETN)
	begin 
		DOUT <= 0; 
	end else if(!LD_EN) 
	begin // Preload takes precedence over INC/DEC
		DOUT <= DIN;
	end else if(!INC_DEC_EN) 
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

assign DOUT_A = OEN_A ? 16'bzzzzzzzzzzzzzzz : DOUT;
assign DOUT_B = OEN_B ? 16'bzzzzzzzzzzzzzzz : DOUT;
assign DOUT_C = OEN_C ? 16'bzzzzzzzzzzzzzzz : DOUT;

endmodule