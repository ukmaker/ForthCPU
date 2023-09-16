library verilog;
use verilog.vl_types.all;
entity flag_dbl is
    port(
        flag_out        : out    vl_logic;
        clk             : in     vl_logic;
        rst_async       : in     vl_logic;
        set_flag        : in     vl_logic
    );
end flag_dbl;
