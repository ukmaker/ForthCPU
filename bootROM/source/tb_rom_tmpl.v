//Verilog testbench template generated by SCUBA Diamond (64-bit) 3.12.1.454
`timescale 1 ns / 1 ps
module tb;
    reg [5:0] Address = 6'b0;
    wire [15:0] Q;

    integer i0 = 0, i1 = 0;

    GSR GSR_INST (.GSR(1'b1));
    PUR PUR_INST (.PUR(1'b1));

    rom u1 (.Address(Address), .Q(Q)
    );

    initial
    begin
       Address <= 0;
      #100;
      #10;
      for (i1 = 0; i1 < 67; i1 = i1 + 1) begin
        #10;
         Address <= Address + 1'b1;
      end
    end
endmodule