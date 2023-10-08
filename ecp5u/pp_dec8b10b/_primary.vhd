library verilog;
use verilog.vl_types.all;
entity pp_dec8b10b is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        data_10b        : in     vl_logic_vector(9 downto 0);
        bypass          : in     vl_logic;
        k_ctrl          : out    vl_logic;
        code_violation  : out    vl_logic;
        disparity_error : out    vl_logic;
        data_8b         : out    vl_logic_vector(7 downto 0)
    );
end pp_dec8b10b;
