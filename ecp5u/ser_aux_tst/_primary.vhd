library verilog;
use verilog.vl_types.all;
entity ser_aux_tst is
    port(
        atsten          : out    vl_logic;
        hststen         : out    vl_logic_vector(7 downto 0);
        lststen         : out    vl_logic_vector(7 downto 0);
        tstoutn         : out    vl_logic;
        tstoutp         : out    vl_logic;
        i50uconst       : inout  vl_logic;
        lststmuxn       : inout  vl_logic;
        lststmuxp       : inout  vl_logic;
        mfgtstout       : inout  vl_logic;
        vcca            : inout  vl_logic;
        vcca25          : inout  vl_logic;
        vssa            : inout  vl_logic;
        vssas           : inout  vl_logic;
        hststinn        : in     vl_logic_vector(3 downto 0);
        hststinp        : in     vl_logic_vector(3 downto 0);
        lststinn        : in     vl_logic_vector(4 downto 0);
        lststinp        : in     vl_logic_vector(4 downto 0);
        mfgtstctl       : in     vl_logic;
        mfgtstin        : in     vl_logic;
        pwdnb           : in     vl_logic;
        tst_en          : in     vl_logic;
        tst_sel         : in     vl_logic_vector(3 downto 0)
    );
end ser_aux_tst;
