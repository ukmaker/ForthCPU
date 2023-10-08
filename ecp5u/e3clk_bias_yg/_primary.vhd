library verilog;
use verilog.vl_types.all;
entity e3clk_bias_yg is
    port(
        vcm_0v95        : out    vl_logic;
        i50urply        : inout  vl_logic;
        vcca25          : inout  vl_logic;
        vssa            : inout  vl_logic;
        pwdnb           : in     vl_logic
    );
end e3clk_bias_yg;
