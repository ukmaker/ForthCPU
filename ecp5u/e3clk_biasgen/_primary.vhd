library verilog;
use verilog.vl_types.all;
entity e3clk_biasgen is
    port(
        nref            : out    vl_logic;
        pref            : out    vl_logic;
        vccaux          : inout  vl_logic;
        vssa            : inout  vl_logic;
        ibias50u        : in     vl_logic;
        sgau_eninr      : in     vl_logic
    );
end e3clk_biasgen;
