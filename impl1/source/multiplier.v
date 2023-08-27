`timescale 1ns / 1ps
module multiplier(a, b, out);
input [15:0] a;
input [15:0] b;
output [31:0] out;

assign out = a * b;

endmodule
	