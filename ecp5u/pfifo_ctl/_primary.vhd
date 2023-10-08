library verilog;
use verilog.vl_types.all;
entity pfifo_ctl is
    port(
        rstb_rxr        : in     vl_logic;
        rstb_txp        : in     vl_logic;
        wr_clk          : in     vl_logic;
        rd_clk          : in     vl_logic;
        pfifor_clr      : in     vl_logic;
        pfifow_clr      : in     vl_logic;
        pfifo_clr_sel   : in     vl_logic;
        fifo_err        : out    vl_logic;
        full_d          : out    vl_logic;
        empty_d         : out    vl_logic;
        wr_addr         : out    vl_logic_vector(2 downto 0);
        rd_addr         : out    vl_logic_vector(2 downto 0)
    );
end pfifo_ctl;
