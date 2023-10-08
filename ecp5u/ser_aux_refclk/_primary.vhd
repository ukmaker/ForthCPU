library verilog;
use verilog.vl_types.all;
entity ser_aux_refclk is
    port(
        refck2core      : out    vl_logic;
        refck_outp      : out    vl_logic;
        refck_outn      : out    vl_logic;
        refck_tx        : out    vl_logic;
        rx_refck_local  : out    vl_logic;
        i50uconst       : inout  vl_logic;
        i50urply        : inout  vl_logic;
        vcca            : inout  vl_logic;
        vcca25          : inout  vl_logic;
        vssa            : inout  vl_logic;
        vssas           : inout  vl_logic;
        ck_core_tx      : in     vl_logic;
        pwdnb           : in     vl_logic;
        refck_4nd_sel   : in     vl_logic_vector(1 downto 0);
        refck_cmos      : in     vl_logic;
        refck_dcbias_en : in     vl_logic;
        refck_out_sel   : in     vl_logic_vector(1 downto 0);
        refck_rterm     : in     vl_logic;
        refck_to_nd_en  : in     vl_logic;
        refclkn         : in     vl_logic;
        refclkp         : in     vl_logic;
        tx_refck_sel    : in     vl_logic
    );
end ser_aux_refclk;
