library verilog;
use verilog.vl_types.all;
entity twi_wdat_check is
    port(
        twi_wdat_crc_error: out    vl_logic;
        twi_padding_error_d: out    vl_logic;
        twi_nack_rcvd   : out    vl_logic;
        twi_invalid_ack_nack: out    vl_logic;
        twi_rdat_ack    : out    vl_logic;
        twi_bad_frame   : out    vl_logic;
        twi_wdat_from_xo2_data_2: in     vl_logic;
        twi_wdat_from_xo2_data_1: in     vl_logic;
        twi_wdat_frame  : in     vl_logic_vector(7 downto 0);
        twi_wdat_crc_enable: in     vl_logic;
        twi_wdat_clr_crc_flag: in     vl_logic;
        twi_wdat_clr    : in     vl_logic;
        twi_wdat_chk_crc_enable: in     vl_logic;
        twi_wdat_byte_count_reg: in     vl_logic_vector(3 downto 0);
        twi_wdat_bit_count_reg: in     vl_logic_vector(2 downto 0);
        twi_resetb      : in     vl_logic;
        twi_padding_start: in     vl_logic;
        twi_padding_end : in     vl_logic;
        twi_clr_padding_error: in     vl_logic;
        twi_clr_ack_nack_flag: in     vl_logic;
        twi_clk         : in     vl_logic;
        twi_chk_ack_enable: in     vl_logic;
        twi_crc_padding_disable: in     vl_logic;
        twi_early_start : in     vl_logic;
        twi_late_start  : in     vl_logic;
        twi_valid_start : in     vl_logic
    );
end twi_wdat_check;
