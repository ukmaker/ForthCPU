library verilog;
use verilog.vl_types.all;
entity tc_16bit is
    generic(
        TC_SIZE         : integer := 16
    );
    port(
        TC_OC           : out    vl_logic;
        TC_INT          : out    vl_logic;
        TC_CNT          : out    vl_logic_vector;
        TC_TOP          : out    vl_logic_vector;
        TC_OCR          : out    vl_logic_vector;
        TC_ICR          : out    vl_logic_vector;
        TC_BTF          : out    vl_logic;
        TC_OVF          : out    vl_logic;
        TC_OCRF         : out    vl_logic;
        TC_ICRF         : out    vl_logic;
        SCANEN          : in     vl_logic;
        TCK             : in     vl_logic;
        GSRN            : in     vl_logic;
        TC_RSTN         : in     vl_logic;
        CLKIN           : in     vl_logic_vector(3 downto 0);
        TC_IC           : in     vl_logic;
        TC_TOP_SET      : in     vl_logic_vector;
        TC_OCR_SET      : in     vl_logic_vector;
        TC_CNT_RESET    : in     vl_logic;
        TC_OC_FORCE     : in     vl_logic;
        TC_GSRN_DIS     : in     vl_logic;
        TC_CNT_PAUSE    : in     vl_logic;
        TC_TOP_SEL      : in     vl_logic;
        TC_MODE         : in     vl_logic_vector(1 downto 0);
        TC_OC_MODE      : in     vl_logic_vector(1 downto 0);
        TC_SCLK_SEL     : in     vl_logic_vector(2 downto 0);
        TC_CCLK_SEL     : in     vl_logic_vector(2 downto 0);
        TC_RSTN_ENA     : in     vl_logic;
        TC_IC_ENA       : in     vl_logic;
        TC_OVF_ENA      : in     vl_logic;
        TIMERCOUNTER_INT: in     vl_logic
    );
end tc_16bit;
