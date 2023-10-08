library verilog;
use verilog.vl_types.all;
entity twi is
    port(
        twi_resetb      : in     vl_logic;
        twi_wrclk       : in     vl_logic;
        twi_wdat        : in     vl_logic;
        twi_rdat        : out    vl_logic;
        twi_wdat_addr   : out    vl_logic_vector(3 downto 0);
        twi_rdat_addr   : out    vl_logic_vector(3 downto 0);
        twi_rdat_data_from_latch: in     vl_logic_vector(7 downto 0);
        twi_wdat_data_from_3wire: out    vl_logic_vector(7 downto 0);
        twi_wdat_write  : out    vl_logic;
        twi_wdat_write_reg: out    vl_logic;
        twi_rdat_read   : out    vl_logic;
        twi_rdat_read_reg: out    vl_logic;
        twi_start       : out    vl_logic;
        twi_early_start : out    vl_logic;
        twi_late_start  : out    vl_logic;
        twi_wdat_crc_error: out    vl_logic;
        twi_wdat_padding_error: out    vl_logic;
        twi_wdat_invalid_ack_nack: out    vl_logic;
        twi_wdat_nack_rcvd: out    vl_logic;
        twi_chk_good_frame: out    vl_logic;
        twi_twogoodframes: out    vl_logic;
        twi_crc_padding_disable: in     vl_logic;
        twi_loopback_en : in     vl_logic;
        safestate_iob   : in     vl_logic
    );
end twi;
