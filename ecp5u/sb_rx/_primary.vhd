library verilog;
use verilog.vl_types.all;
entity sb_rx is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        data_i          : in     vl_logic_vector(9 downto 0);
        bw8_rx          : in     vl_logic;
        sb_inv_rx       : in     vl_logic;
        sb_loopback_rx  : in     vl_logic;
        prbs_select     : in     vl_logic;
        prbs_lock       : in     vl_logic;
        data_lb         : in     vl_logic_vector(9 downto 0);
        data_o          : out    vl_logic_vector(9 downto 0);
        prbs_error      : out    vl_logic
    );
end sb_rx;
