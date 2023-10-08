library verilog;
use verilog.vl_types.all;
entity e3clk_fntend_yg is
    port(
        sg1_inr_out     : out    vl_logic;
        i50uconst       : inout  vl_logic;
        sgau_eninr      : inout  vl_logic;
        vcca            : inout  vl_logic;
        vcca25          : inout  vl_logic;
        vcm_0v95        : inout  vl_logic;
        vssa            : inout  vl_logic;
        dcbias_en       : in     vl_logic;
        inn             : in     vl_logic;
        inp             : in     vl_logic;
        refck_rterm     : in     vl_logic
    );
end e3clk_fntend_yg;
