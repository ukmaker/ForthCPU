library verilog;
use verilog.vl_types.all;
entity ser_lg_inv_lv_2x is
    port(
        \out\           : out    vl_logic;
        vccq            : inout  vl_logic;
        vssq            : inout  vl_logic;
        vssqs           : inout  vl_logic;
        \in\            : in     vl_logic
    );
end ser_lg_inv_lv_2x;
