library verilog;
use verilog.vl_types.all;
entity pp_ge_idle is
    generic(
        \WAIT\          : integer := 0;
        GO              : integer := 1;
        K28_5           : integer := 444;
        I2              : integer := 80
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        xmit            : in     vl_logic;
        ge_mode         : in     vl_logic;
        d_in            : in     vl_logic_vector(10 downto 0);
        rx_even_in      : in     vl_logic;
        d_out           : out    vl_logic_vector(10 downto 0);
        rx_even_out     : out    vl_logic
    );
end pp_ge_idle;
