library verilog;
use verilog.vl_types.all;
entity cfg_data is
    port(
        rfifo_out       : out    vl_logic_vector(7 downto 0);
        wfifo_out       : out    vl_logic_vector(15 downto 0);
        rfifo_empty     : out    vl_logic;
        rfifo_full      : out    vl_logic;
        rfifo_overflow  : out    vl_logic;
        wfifo_empty     : out    vl_logic;
        wfifo_full      : out    vl_logic;
        wfifo_overflow  : out    vl_logic;
        njtrx_rst_async : in     vl_logic;
        njvfy_rst_exec  : in     vl_logic;
        smclk           : in     vl_logic;
        fifo_clk        : in     vl_logic;
        fifo_rst        : in     vl_logic;
        rfifo_din       : in     vl_logic_vector(15 downto 0);
        rfifo_we        : in     vl_logic;
        rfifo_w16       : in     vl_logic;
        wfifo_re        : in     vl_logic;
        wfifo_r16       : in     vl_logic;
        wfifo_din       : in     vl_logic_vector(7 downto 0);
        rfifo_re        : in     vl_logic;
        wfifo_we        : in     vl_logic
    );
end cfg_data;
