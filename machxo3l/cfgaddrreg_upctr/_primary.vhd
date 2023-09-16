library verilog;
use verilog.vl_types.all;
entity cfgaddrreg_upctr is
    port(
        addr_out        : out    vl_logic_vector(7 downto 0);
        count_eq_maxcfgaddr: out    vl_logic;
        count_eq_maxtrimaddr: out    vl_logic;
        ctrbit0         : out    vl_logic;
        count_eq_crcbyteaddr: out    vl_logic;
        strt_addr       : in     vl_logic_vector(7 downto 0);
        reset           : in     vl_logic;
        load            : in     vl_logic;
        incr            : in     vl_logic;
        clk             : in     vl_logic
    );
end cfgaddrreg_upctr;
