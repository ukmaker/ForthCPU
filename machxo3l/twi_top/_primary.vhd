library verilog;
use verilog.vl_types.all;
entity twi_top is
    generic(
        IS_VEGAS        : integer := 0
    );
    port(
        twi_wdat_reg_to_asc_9: out    vl_logic_vector(7 downto 0);
        twi_wdat_reg_to_asc_8: out    vl_logic_vector(7 downto 0);
        twi_wdat_reg_to_asc_7: out    vl_logic_vector(7 downto 0);
        twi_wdat_reg_to_asc_6: out    vl_logic_vector(7 downto 0);
        twi_wdat_reg_to_asc_5: out    vl_logic_vector(7 downto 0);
        twi_wdat_reg_to_asc_4: out    vl_logic_vector(7 downto 0);
        twi_wdat_reg_to_asc_3: out    vl_logic_vector(7 downto 0);
        twi_wdat_reg_to_asc_2: out    vl_logic_vector(7 downto 0);
        twi_wdat_reg_to_asc_15: out    vl_logic_vector(7 downto 0);
        twi_wdat_reg_to_asc_14: out    vl_logic_vector(7 downto 0);
        twi_wdat_reg_to_asc_13: out    vl_logic_vector(7 downto 0);
        twi_wdat_reg_to_asc_12: out    vl_logic_vector(7 downto 0);
        twi_wdat_reg_to_asc_11: out    vl_logic_vector(7 downto 0);
        twi_wdat_reg_to_asc_10: out    vl_logic_vector(7 downto 0);
        twi_wdat_padding_error: out    vl_logic;
        twi_wdat_nack_rcvd: out    vl_logic;
        twi_wdat_invalid_ack_nack: out    vl_logic;
        twi_wdat_crc_error: out    vl_logic;
        twi_twogoodframes: out    vl_logic;
        twi_start       : out    vl_logic;
        twi_rdat        : out    vl_logic;
        twi_late_start  : out    vl_logic;
        twi_early_start : out    vl_logic;
        twi_chk_good_frame: out    vl_logic;
        twi_rdat_addr   : out    vl_logic_vector(3 downto 0);
        twi_rdat_data_from_latch: out    vl_logic_vector(7 downto 0);
        twi_rdat_read   : out    vl_logic;
        twi_wdat_write_reg: out    vl_logic;
        twi_wrclk       : in     vl_logic;
        twi_wdat        : in     vl_logic;
        twi_resetb      : in     vl_logic;
        twi_loopback_en : in     vl_logic;
        twi_crc_padding_disable: in     vl_logic;
        twi_asc_to_rdat_latch_0: in     vl_logic_vector(7 downto 0);
        twi_asc_to_rdat_latch_1: in     vl_logic_vector(7 downto 0);
        twi_asc_to_rdat_latch_2: in     vl_logic_vector(7 downto 0);
        twi_asc_to_rdat_latch_3: in     vl_logic_vector(7 downto 0);
        twi_asc_to_rdat_latch_4: in     vl_logic_vector(7 downto 0);
        twi_asc_to_rdat_latch_5: in     vl_logic_vector(7 downto 0);
        twi_asc_to_rdat_latch_6: in     vl_logic_vector(7 downto 0);
        twi_asc_to_rdat_latch_7: in     vl_logic_vector(7 downto 0);
        twi_asc_to_rdat_latch_8: in     vl_logic_vector(7 downto 0);
        safestate_iob   : in     vl_logic
    );
end twi_top;
