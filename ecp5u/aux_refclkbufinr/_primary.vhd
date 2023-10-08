library verilog;
use verilog.vl_types.all;
entity aux_refclkbufinr is
    port(
        sg11_inr_out    : out    vl_logic;
        vcca            : inout  vl_logic;
        vccaux          : inout  vl_logic;
        vssa            : inout  vl_logic;
        sgau_eninr      : in     vl_logic;
        sgau_inr_nref   : in     vl_logic;
        sgau_inr_pref   : in     vl_logic;
        sgio_inr_comp   : in     vl_logic;
        sgio_inr_true   : in     vl_logic
    );
end aux_refclkbufinr;
