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
	output reg [15:0] DOUT
);

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

endmodule