library verilog;
use verilog.vl_types.all;
entity e3clk_slfbias_yg is
    port(
        inn             : inout  vl_logic;
        inp             : inout  vl_logic;
        vccaux          : inout  vl_logic;
        vccl            : inout  vl_logic;
        vcm             : inout  vl_logic;
        vssl            : inout  vl_logic;
        dcbias_en       : in     vl_logic
    );
end e3clk_slfbias_yg;
