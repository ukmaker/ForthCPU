library verilog;
use verilog.vl_types.all;
entity erasprgmtmr is
    port(
        timeout         : out    vl_logic;
        ep_clken        : out    vl_logic;
        enable_ep       : out    vl_logic;
        slotsel         : in     vl_logic_vector(3 downto 0);
        rangesel        : in     vl_logic_vector(1 downto 0);
        reset           : in     vl_logic;
        entimer         : in     vl_logic;
        tstentimer      : in     vl_logic;
        normclk         : in     vl_logic;
        tstclken        : in     vl_logic;
        tstclk          : in     vl_logic;
        en_timeout_dischrg_per: in     vl_logic
    );
end erasprgmtmr;
