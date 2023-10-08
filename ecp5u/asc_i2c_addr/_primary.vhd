library verilog;
use verilog.vl_types.all;
entity asc_i2c_addr is
    generic(
        CLK_FREQ_MHZ    : integer := 8
    );
    port(
        clock           : in     vl_logic;
        reset_n         : in     vl_logic;
        tap_select      : out    vl_logic_vector(2 downto 0);
        i2c_addr_clk    : out    vl_logic;
        i2c_resetb      : out    vl_logic;
        comparator_result_asynch: in     vl_logic;
        comparator_sample: out    vl_logic;
        enable_i2c_address_eval: in     vl_logic;
        cfg_continuous_address_eval: in     vl_logic;
        address_lsb     : out    vl_logic_vector(2 downto 0);
        address_lsb_done: out    vl_logic
    );
end asc_i2c_addr;
