library verilog;
use verilog.vl_types.all;
entity ser_lg_nor2_lv_2x is
    port(
        \out\           : out    vl_logic;
        vccq            : inout  vl_logic;
        vssq            : inout  vl_logic;
        vssqs           : inout  vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic
    );
end ser_lg_nor2_lv_2x;
