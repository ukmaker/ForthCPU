library verilog;
use verilog.vl_types.all;
entity twi_bit_upct is
    port(
        twi_clk         : in     vl_logic;
        twi_resetb      : in     vl_logic;
        twi_incr_bitct_d: in     vl_logic;
        twi_clr_bitct_d : in     vl_logic;
        twi_count_reg   : out    vl_logic_vector(2 downto 0);
        twi_bitct8      : out    vl_logic
    );
end twi_bit_upct;
