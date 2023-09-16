library verilog;
use verilog.vl_types.all;
entity twi_rdat_rshift_reg is
    port(
        twi_clk         : in     vl_logic;
        twi_resetb      : in     vl_logic;
        twi_clr         : in     vl_logic;
        twi_ld          : in     vl_logic;
        twi_ld_crc      : in     vl_logic;
        twi_ld_sym      : in     vl_logic;
        twi_ld_ack      : in     vl_logic;
        twi_ld_nack     : in     vl_logic;
        twi_rshift      : in     vl_logic;
        twi_sdi         : in     vl_logic;
        twi_crc_din     : in     vl_logic_vector(7 downto 0);
        twi_din         : in     vl_logic_vector(7 downto 0);
        twi_dout        : out    vl_logic_vector(7 downto 0);
        twi_rdat        : out    vl_logic
    );
end twi_rdat_rshift_reg;
