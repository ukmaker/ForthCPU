module registers(

input [15:0] din,
input [3:0] addr_a,
input [3:0] addr_b,

input wrn,
input clk,

output reg [15:0] dout_a,
output reg [15:0] dout_b

);

reg [15:0] regs [15:0];

always @ (posedge clk)
begin
	if(wrn == 0) begin
		regs[addr_a] <= din;
	end
end

always @ (*)
begin
	dout_a = regs[addr_a];
	dout_b = regs[addr_b];
end
	
endmodule