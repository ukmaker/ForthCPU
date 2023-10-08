library verilog;
use verilog.vl_types.all;
entity ser_tg_lvtw is
    port(
        a               : inout  vl_logic;
        b               : inout  vl_logic;
        vccq            : inout  vl_logic;
        vssq            : inout  vl_logic;
        \on\            : in     vl_logic;
        onb             : in     vl_logic
    );
end ser_tg_lvtw;
