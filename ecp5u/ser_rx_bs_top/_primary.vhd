library verilog;
use verilog.vl_types.all;
entity ser_rx_bs_top is
    port(
        bsout           : out    vl_logic;
        ibias50u_rxbs   : inout  vl_logic;
        bs_en           : in     vl_logic;
        inn             : in     vl_logic;
        inp             : in     vl_logic;
        vcca25          : inout  vl_logic;
        hs_inp          : out    vl_logic;
        hs_inn          : out    vl_logic;
        vccrx           : inout  vl_logic;
        vssrx           : inout  vl_logic;
        ldr_sel         : in     vl_logic
    );
end ser_rx_bs_top;
