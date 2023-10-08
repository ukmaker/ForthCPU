library verilog;
use verilog.vl_types.all;
entity ts_upcounter is
    port(
        asc_clk         : in     vl_logic;
        ts_resetb       : in     vl_logic;
        ts_upct_d       : in     vl_logic;
        ts_clr_d        : in     vl_logic;
        ts_ct16         : out    vl_logic
    );
end ts_upcounter;
