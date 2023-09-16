library verilog;
use verilog.vl_types.all;
entity stdby_cntl is
    generic(
        CNT_SIZE        : integer := 8
    );
    port(
        STDBY           : out    vl_logic;
        STOP            : out    vl_logic;
        SFLAG           : out    vl_logic;
        BGOFF           : out    vl_logic;
        POROFF          : out    vl_logic;
        osc_ena         : out    vl_logic;
        osc_dis         : out    vl_logic;
        STDBY_ENA       : in     vl_logic;
        CFG_STDBY       : in     vl_logic;
        I2C_WAKE        : in     vl_logic;
        BG_STABLE       : in     vl_logic;
        OSC_CLK         : in     vl_logic;
        CIB_CLK         : in     vl_logic;
        CIB_TIMEOUT     : in     vl_logic;
        CIB_STDBY       : in     vl_logic;
        CIB_CLR_FLAG    : in     vl_logic;
        MC1_CLK_SEL     : in     vl_logic;
        MC1_USER_TIMER  : in     vl_logic;
        MC1_BYPASS_TIMER: in     vl_logic;
        MC1_EN_I2CWAKE  : in     vl_logic;
        MC1_EN_CIBWAKE  : in     vl_logic;
        MC1_EN_CFGSTDBY : in     vl_logic;
        MC1_EN_CIBSTDBY : in     vl_logic;
        MC1_DIS_BG      : in     vl_logic_vector(1 downto 0);
        mc1_stdby_bg    : in     vl_logic_vector(1 downto 0);
        mc1_dis_osc     : in     vl_logic;
        programn_pin    : in     vl_logic;
        progn_persist   : in     vl_logic;
        cib_osc_dis     : in     vl_logic
    );
end stdby_cntl;
