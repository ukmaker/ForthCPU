library verilog;
use verilog.vl_types.all;
entity e3bis_head_founder is
    port(
        clk             : in     vl_logic;
        bist_head_sel   : in     vl_logic_vector(1 downto 0);
        bus8bit_sel     : in     vl_logic;
        \reset_\        : in     vl_logic;
        re_search_head  : in     vl_logic;
        rx_data         : in     vl_logic_vector(9 downto 0);
        rx_head_10b     : out    vl_logic_vector(9 downto 0)
    );
end e3bis_head_founder;
