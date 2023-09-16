library verilog;
use verilog.vl_types.all;
entity cfg_dec is
    port(
        DEC_LOAD        : out    vl_logic;
        DEC_DOUT        : out    vl_logic_vector(63 downto 0);
        MUX_CLK         : in     vl_logic;
        ASYNC_RST_N     : in     vl_logic;
        CODE8           : in     vl_logic_vector(7 downto 0);
        CODE9           : in     vl_logic_vector(7 downto 0);
        CODEA           : in     vl_logic_vector(7 downto 0);
        CODEB           : in     vl_logic_vector(7 downto 0);
        CODEC           : in     vl_logic_vector(7 downto 0);
        CODED           : in     vl_logic_vector(7 downto 0);
        CODEE           : in     vl_logic_vector(7 downto 0);
        CODEF           : in     vl_logic_vector(7 downto 0);
        DEC_EN          : in     vl_logic;
        DEC_RDY         : in     vl_logic;
        DEC_DIN         : in     vl_logic_vector(7 downto 0)
    );
end cfg_dec;
