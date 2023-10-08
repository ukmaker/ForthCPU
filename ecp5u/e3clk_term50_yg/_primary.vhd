library verilog;
use verilog.vl_types.all;
entity e3clk_term50_yg is
    port(
        inn             : inout  vl_logic;
        inp             : inout  vl_logic;
        vccaux          : inout  vl_logic;
        vccl            : inout  vl_logic;
        vssl            : inout  vl_logic;
        sg2_enterm      : in     vl_logic
    );
end e3clk_term50_yg;
