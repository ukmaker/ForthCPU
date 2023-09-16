library verilog;
use verilog.vl_types.all;
entity twi_rdat_bit_upct is
    port(
        twi_clk         : in     vl_logic;
        twi_resetb      : in     vl_logic;
        twi_incr_bitct_d: in     vl_logic;
        twi_clr_bitct_d : in     vl_logic;
        twi_sym_ct      : out    vl_logic;
        twi_bitct7      : out    vl_logic
    );
end twi_rdat_bit_upct;
