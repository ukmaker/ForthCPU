library verilog;
use verilog.vl_types.all;
entity ser_aux_refclk_afe is
    port(
        \out\           : out    vl_logic;
        i50uconst       : inout  vl_logic;
        i50urply        : inout  vl_logic;
        vcca            : inout  vl_logic;
        vcca25          : inout  vl_logic;
        vssa            : inout  vl_logic;
        vssas           : inout  vl_logic;
        pwdnb           : in     vl_logic;
        refck_dcbias_en : in     vl_logic;
        refck_rterm     : in     vl_logic;
        refclkn         : in     vl_logic;
        refclkp         : in     vl_logic
    );
end ser_aux_refclk_afe;
