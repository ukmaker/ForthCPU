library verilog;
use verilog.vl_types.all;
entity cfg_div is
    generic(
        DIV_SIZE        : integer := 6
    );
    port(
        clk_out         : out    vl_logic;
        hlf_cyc         : out    vl_logic;
        clk_in          : in     vl_logic;
        clk_en          : in     vl_logic;
        clk_run         : in     vl_logic;
        clk_tog         : in     vl_logic;
        clk_pol         : in     vl_logic;
        div_exp         : in     vl_logic;
        div             : in     vl_logic_vector
    );
end cfg_div;
