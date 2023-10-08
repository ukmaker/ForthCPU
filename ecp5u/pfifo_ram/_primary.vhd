library verilog;
use verilog.vl_types.all;
entity pfifo_ram is
    port(
        rstb_rxr        : in     vl_logic;
        rstb_txp        : in     vl_logic;
        lol             : in     vl_logic;
        wr_clk          : in     vl_logic;
        wr_addr         : in     vl_logic_vector(2 downto 0);
        wr_data         : in     vl_logic_vector(9 downto 0);
        rd_clk          : in     vl_logic;
        rd_addr         : in     vl_logic_vector(2 downto 0);
        rd_data         : out    vl_logic_vector(9 downto 0)
    );
end pfifo_ram;
