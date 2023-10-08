library verilog;
use verilog.vl_types.all;
entity ser_lg_inv_lv_nonrf_2x1 is
    port(
        \out\           : out    vl_logic;
        vccrx           : inout  vl_logic;
        vssrx           : inout  vl_logic;
        \in\            : in     vl_logic
    );
end ser_lg_inv_lv_nonrf_2x1;
