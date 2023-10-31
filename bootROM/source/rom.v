/* Verilog netlist generated by SCUBA Diamond (64-bit) 3.12.1.454 */
/* Module Version: 2.8 */
/* C:\lscc\diamond\3.12\ispfpga\bin\nt64\scuba.exe -w -n rom -lang verilog -synth synplify -bus_exp 7 -bb -arch xo3c00a -type rom -addr_width 6 -num_rows 64 -data_width 16 -outdata UNREGISTERED -memfile c:/users/duncan/git/forthcpu/bootrom/source/blink.mem -memformat orca  */
/* Tue Oct 31 18:09:40 2023 */


`timescale 1 ns / 1 ps
module rom (Address, Q)/* synthesis NGD_DRC_MASK=1 */;
    input wire [5:0] Address;
    output wire [15:0] Q;


    defparam mem_0_15.initval =  64'h0000154555505511 ;
    ROM64X1A mem_0_15 (.AD5(Address[5]), .AD4(Address[4]), .AD3(Address[3]), 
        .AD2(Address[2]), .AD1(Address[1]), .AD0(Address[0]), .DO0(Q[15]));

    defparam mem_0_14.initval =  64'h0000015555515400 ;
    ROM64X1A mem_0_14 (.AD5(Address[5]), .AD4(Address[4]), .AD3(Address[3]), 
        .AD2(Address[2]), .AD1(Address[1]), .AD0(Address[0]), .DO0(Q[14]));

    defparam mem_0_13.initval =  64'h0000044000000000 ;
    ROM64X1A mem_0_13 (.AD5(Address[5]), .AD4(Address[4]), .AD3(Address[3]), 
        .AD2(Address[2]), .AD1(Address[1]), .AD0(Address[0]), .DO0(Q[13]));

    defparam mem_0_12.initval =  64'h0000040000000000 ;
    ROM64X1A mem_0_12 (.AD5(Address[5]), .AD4(Address[4]), .AD3(Address[3]), 
        .AD2(Address[2]), .AD1(Address[1]), .AD0(Address[0]), .DO0(Q[12]));

    defparam mem_0_11.initval =  64'h0000015000010000 ;
    ROM64X1A mem_0_11 (.AD5(Address[5]), .AD4(Address[4]), .AD3(Address[3]), 
        .AD2(Address[2]), .AD1(Address[1]), .AD0(Address[0]), .DO0(Q[11]));

    defparam mem_0_10.initval =  64'h0000000000000000 ;
    ROM64X1A mem_0_10 (.AD5(Address[5]), .AD4(Address[4]), .AD3(Address[3]), 
        .AD2(Address[2]), .AD1(Address[1]), .AD0(Address[0]), .DO0(Q[10]));

    defparam mem_0_9.initval =  64'h0000140014505111 ;
    ROM64X1A mem_0_9 (.AD5(Address[5]), .AD4(Address[4]), .AD3(Address[3]), 
        .AD2(Address[2]), .AD1(Address[1]), .AD0(Address[0]), .DO0(Q[9]));

    defparam mem_0_8.initval =  64'h0000014110444400 ;
    ROM64X1A mem_0_8 (.AD5(Address[5]), .AD4(Address[4]), .AD3(Address[3]), 
        .AD2(Address[2]), .AD1(Address[1]), .AD0(Address[0]), .DO0(Q[8]));

    defparam mem_0_7.initval =  64'h0000140000505000 ;
    ROM64X1A mem_0_7 (.AD5(Address[5]), .AD4(Address[4]), .AD3(Address[3]), 
        .AD2(Address[2]), .AD1(Address[1]), .AD0(Address[0]), .DO0(Q[7]));

    defparam mem_0_6.initval =  64'h0000140000505000 ;
    ROM64X1A mem_0_6 (.AD5(Address[5]), .AD4(Address[4]), .AD3(Address[3]), 
        .AD2(Address[2]), .AD1(Address[1]), .AD0(Address[0]), .DO0(Q[6]));

    defparam mem_0_5.initval =  64'h0000150440505000 ;
    ROM64X1A mem_0_5 (.AD5(Address[5]), .AD4(Address[4]), .AD3(Address[3]), 
        .AD2(Address[2]), .AD1(Address[1]), .AD0(Address[0]), .DO0(Q[5]));

    defparam mem_0_4.initval =  64'h0000150401505001 ;
    ROM64X1A mem_0_4 (.AD5(Address[5]), .AD4(Address[4]), .AD3(Address[3]), 
        .AD2(Address[2]), .AD1(Address[1]), .AD0(Address[0]), .DO0(Q[4]));

    defparam mem_0_3.initval =  64'h0000040041515400 ;
    ROM64X1A mem_0_3 (.AD5(Address[5]), .AD4(Address[4]), .AD3(Address[3]), 
        .AD2(Address[2]), .AD1(Address[1]), .AD0(Address[0]), .DO0(Q[3]));

    defparam mem_0_2.initval =  64'h0000140100404011 ;
    ROM64X1A mem_0_2 (.AD5(Address[5]), .AD4(Address[4]), .AD3(Address[3]), 
        .AD2(Address[2]), .AD1(Address[1]), .AD0(Address[0]), .DO0(Q[2]));

    defparam mem_0_1.initval =  64'h0000140404404410 ;
    ROM64X1A mem_0_1 (.AD5(Address[5]), .AD4(Address[4]), .AD3(Address[3]), 
        .AD2(Address[2]), .AD1(Address[1]), .AD0(Address[0]), .DO0(Q[1]));

    defparam mem_0_0.initval =  64'h0000015104505000 ;
    ROM64X1A mem_0_0 (.AD5(Address[5]), .AD4(Address[4]), .AD3(Address[3]), 
        .AD2(Address[2]), .AD1(Address[1]), .AD0(Address[0]), .DO0(Q[0]));



    // exemplar begin
    // exemplar end

endmodule
