`include "../../constants.v"

module memory(
	
	input CLK,
	input RESET,
	
	input [15:0] ADDR,
	input [15:0] DIN,
	output [15:0] DOUT,
	input RDN,
	input WR0N,
	input WR1N
);

wire CLKEN;
reg WE;
reg BE0, BE1;

wire [15:0] RAM_DATA;
wire [15:0] ROM_DATA;

wire RAM_MAP;
wire ROM_MAP;

RAM RAMInst(
	.Address(ADDR[12:0]),
	.Data(DIN),
	.Clock(CLK),
	.WE(WE),
	.ByteEn({BE0, BE1}),
	.ClockEn(CLKEN),
	.Q(RAM_DATA),
	.Reset(RESET)
);

rom romInst(
	.Address(ADDR[4:0]), 
	.Q(ROM_DATA)
);

/************************************************
* Decode the address to enable RAM or ROM
* ROM 0x0000 to 0x2000 
*   16'b 0000 0000 0000 0000 
*   16'b 0010 0000 0000 0000
* RAM 0x2000 to 0x6000 
*   16'b 0010 0000 0000 0000
*   16'b 0110 0000 0000 0000
************************************************/
assign ROM_MAP = (ADDR[15:13] == 3'b000);
assign RAM_MAP = (ADDR[15:13] == 3'b001 | ADDR[15:13] == 3'b010  | ADDR[15:13] == 3'b011 | ADDR[15:13] == 3'b010 );
assign DOUT = RAM_MAP ? RAM_DATA : (ROM_MAP ? ROM_DATA : 16'h0000);
assign CLKEN = RAM_MAP;

always @(*) begin
	if(RAM_MAP) begin
		if(RDN == 0) begin
			BE0 = 1;
			BE1 = 1;
			WE = 0;
		end else if(WR0N == 0 | WR1N == 0) begin
			BE1 = ~WR0N; // note enables seem to be numbered in reverse order
			BE0 = ~WR1N;
			WE = 1;
		end else begin
			BE0 = 0;
			BE1 = 0;
			WE = 0;
		end
	end
end

endmodule