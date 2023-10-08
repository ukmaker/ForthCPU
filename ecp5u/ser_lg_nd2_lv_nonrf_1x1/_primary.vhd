library verilog;
use verilog.vl_types.all;
entity ser_lg_nd2_lv_nonrf_1x1 is
    port(
        y               : out    vl_logic;
        vccrx           : inout  vl_logic;
        vssrx           : inout  vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic
    );
end ser_lg_nd2_lv_nonrf_1x1;
