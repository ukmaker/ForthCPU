library verilog;
use verilog.vl_types.all;
entity pp_enc8b10b is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        k_cntrl         : in     vl_logic;
        data_8b         : in     vl_logic_vector(7 downto 0);
        force_disparity : in     vl_logic;
        force_disparity_sel: in     vl_logic;
        fc_mode         : in     vl_logic;
        ge_mode         : in     vl_logic;
        correct_disp    : in     vl_logic;
        data_10b        : out    vl_logic_vector(9 downto 0)
    );
end pp_enc8b10b;
