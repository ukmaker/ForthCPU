library verilog;
use verilog.vl_types.all;
entity twi_rdat_byte_upct is
    port(
        twi_clk         : in     vl_logic;
        twi_resetb      : in     vl_logic;
        twi_incr_bytect_d: in     vl_logic;
        twi_clr_bytect_d: in     vl_logic;
        twi_bytect16    : out    vl_logic;
        twi_count_reg   : out    vl_logic_vector(3 downto 0)
    );
end twi_rdat_byte_upct;
