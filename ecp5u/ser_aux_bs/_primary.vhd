library verilog;
use verilog.vl_types.all;
entity ser_aux_bs is
    port(
        bsout           : out    vl_logic;
        bs_en           : in     vl_logic;
        inn             : in     vl_logic;
        inp             : in     vl_logic;
        vcca25          : inout  vl_logic;
        i50urpoly       : inout  vl_logic;
        vcca            : inout  vl_logic;
        vssa            : inout  vl_logic;
        vssas           : inout  vl_logic
    );
end ser_aux_bs;
