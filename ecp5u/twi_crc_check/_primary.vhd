library verilog;
use verilog.vl_types.all;
entity twi_crc_check is
    port(
        twi_wdat_crc_error: out    vl_logic;
        twi_wdat_crc_error_d_0: out    vl_logic;
        twi_clk         : in     vl_logic;
        twi_resetb      : in     vl_logic;
        twi_wdat_from_xo2_data_2: in     vl_logic;
        twi_wdat_frame  : in     vl_logic_vector(7 downto 0);
        twi_wdat_clr    : in     vl_logic;
        twi_wdat_crc_enable: in     vl_logic;
        twi_wdat_chk_crc_enable: in     vl_logic;
        twi_wdat_clr_crc_flag: in     vl_logic;
        twi_wdat_byte_count_reg: in     vl_logic_vector(3 downto 0);
        twi_wdat_bit_count_reg: in     vl_logic_vector(2 downto 0)
    );
end twi_crc_check;
