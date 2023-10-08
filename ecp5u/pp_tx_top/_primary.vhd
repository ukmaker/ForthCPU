library verilog;
use verilog.vl_types.all;
entity pp_tx_top is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        txd_i           : in     vl_logic_vector(11 downto 0);
        txd_o           : out    vl_logic_vector(9 downto 0);
        uc_mode         : in     vl_logic;
        fc_mode         : in     vl_logic;
        pcie_mode       : in     vl_logic;
        rio_mode        : in     vl_logic;
        xge_mode        : in     vl_logic;
        ge_mode         : in     vl_logic
    );
end pp_tx_top;
