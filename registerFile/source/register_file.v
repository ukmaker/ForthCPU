module register_file(
	input wire [15:0] DataInA ,
    input wire [15:0] DataInB ,
    input wire [3:0] AddressA ,
    input wire [3:0] AddressB ,
    input wire ClockA ,
    input wire ClockB ,
    input wire ClockEnA ,
    input wire ClockEnB ,
    input wire WrA ,
    input wire WrB ,
    input wire ResetA ,
    input wire ResetB ,
    output wire [15:0] QA ,
    output wire [15:0] QB
);

dpram __ (.DataInA( DataInA), .DataInB( DataInB), .AddressA( AddressA), .AddressB( AddressB), 
    .ClockA( ClockA), .ClockB(ClockB ), .ClockEnA(ClockEnA ), .ClockEnB( ClockEnB), .WrA(WrA ), .WrB( WrB), 
    .ResetA(ResetA ), .ResetB(ResetB ), .QA(QA ), .QB( QB));


endmodule