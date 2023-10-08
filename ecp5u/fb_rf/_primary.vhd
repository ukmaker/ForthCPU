library verilog;
use verilog.vl_types.all;
entity fb_rf is
    generic(
        ADDR_WIDTH      : integer := 2;
        DATA_WIDTH      : integer := 12
    );
    port(
        rst_n           : in     vl_logic;
        clk_a           : in     vl_logic;
        a_a             : in     vl_logic_vector;
        d_a             : in     vl_logic_vector;
        we_a            : in     vl_logic;
        clk_b           : in     vl_logic;
        a_b             : in     vl_logic_vector;
        d_b             : out    vl_logic_vector
    );
end fb_rf;
