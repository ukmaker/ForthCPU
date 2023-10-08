library verilog;
use verilog.vl_types.all;
entity ser_aux_regulator is
    port(
        i50uconst       : inout  vl_logic_vector(1 downto 0);
        i50urpoly       : inout  vl_logic_vector(1 downto 0);
        lststoutn       : inout  vl_logic;
        lststoutp       : inout  vl_logic;
        vcca            : inout  vl_logic;
        vcca25          : inout  vl_logic;
        vcca_reg        : inout  vl_logic;
        vssa            : inout  vl_logic;
        vssas           : inout  vl_logic;
        pwdnb           : in     vl_logic;
        rg_en           : in     vl_logic;
        rg_set          : in     vl_logic_vector(1 downto 0);
        tst_en          : in     vl_logic;
        tst_sel         : in     vl_logic_vector(2 downto 0)
    );
end ser_aux_regulator;
