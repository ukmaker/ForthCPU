library verilog;
use verilog.vl_types.all;
entity sb_prbs is
    port(
        data_out        : out    vl_logic_vector(9 downto 0);
        match_error     : out    vl_logic;
        data_in         : in     vl_logic_vector(9 downto 0);
        width10_not8    : in     vl_logic;
        polynomial31_not7: in     vl_logic;
        lock            : in     vl_logic;
        clock           : in     vl_logic;
        reset_n         : in     vl_logic
    );
end sb_prbs;
