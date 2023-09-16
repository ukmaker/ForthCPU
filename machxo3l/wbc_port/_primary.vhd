library verilog;
use verilog.vl_types.all;
entity wbc_port is
    generic(
        SBW             : integer := 8
    );
    port(
        wbcact          : out    vl_logic;
        wbcsr           : out    vl_logic_vector;
        wbcrxdr         : out    vl_logic_vector;
        wbc_enable      : out    vl_logic;
        wbc_cfgrst      : out    vl_logic;
        wbc_rfifo_we    : out    vl_logic;
        wbc_wfifo_re    : out    vl_logic;
        wbc_rfifo_din   : out    vl_logic_vector;
        wbc_rst_async   : in     vl_logic;
        smclk           : in     vl_logic;
        wbc_clk         : in     vl_logic;
        wbccr1          : in     vl_logic_vector;
        wbctxdr         : in     vl_logic_vector;
        wb_wbccr1_wt    : in     vl_logic;
        wb_wbctxdr_wt   : in     vl_logic;
        wb_wbcrxdr_rd   : in     vl_logic;
        wfifo_out       : in     vl_logic_vector;
        rfifo_empty     : in     vl_logic;
        rfifo_full      : in     vl_logic;
        wfifo_empty     : in     vl_logic;
        wfifo_full      : in     vl_logic;
        cfgp_active     : in     vl_logic;
        i2c_active      : in     vl_logic
    );
end wbc_port;
