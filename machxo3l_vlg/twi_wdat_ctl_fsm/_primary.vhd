library verilog;
use verilog.vl_types.all;
entity twi_wdat_ctl_fsm is
    generic(
        IDLE_D          : integer := 0;
        SYNC_1_D        : integer := 1;
        SYNC_2_D        : integer := 3;
        RSHIFT_D        : integer := 2;
        LD_LATCH_D      : integer := 6;
        RSHIFT_CRC_D    : integer := 7;
        WAIT_CRC_D      : integer := 5;
        RSHIFT_NACK_ACK_D: integer := 4;
        CHECK_ACK_D     : integer := 12;
        WAIT_START_D    : integer := 8
    );
    port(
        twi_wrclk       : in     vl_logic;
        twi_resetb      : in     vl_logic;
        twi_start_from_xo2: in     vl_logic;
        twi_bit_ct      : in     vl_logic;
        twi_byte_ct     : in     vl_logic;
        twi_wdat_rshift_reg: in     vl_logic_vector(7 downto 0);
        twi_wdat_bit_count_reg: in     vl_logic_vector(2 downto 0);
        twi_wdat_byte_count_reg: in     vl_logic_vector(3 downto 0);
        twi_bad_frame   : in     vl_logic;
        twi_crc_enable  : out    vl_logic;
        twi_chk_crc_enable: out    vl_logic;
        twi_clr_crc_flag: out    vl_logic;
        twi_clr_rshift_reg: out    vl_logic;
        twi_rshift_by_one: out    vl_logic;
        twi_clr_bitct   : out    vl_logic;
        twi_incr_bitct  : out    vl_logic;
        twi_clr_bytect  : out    vl_logic;
        twi_incr_bytect : out    vl_logic;
        twi_padding_start_d: out    vl_logic;
        twi_padding_end_d: out    vl_logic;
        twi_clr_padding_error: out    vl_logic;
        twi_ld_latch    : out    vl_logic;
        twi_ld_latch_slave: out    vl_logic;
        twi_clr_ack_nack_flag: out    vl_logic;
        twi_early_start : out    vl_logic;
        twi_late_start  : out    vl_logic;
        twi_valid_start : out    vl_logic;
        twi_chk_ack_enable: out    vl_logic;
        twi_chk_good_frame: out    vl_logic;
        twi_twogoodframes: out    vl_logic
    );
end twi_wdat_ctl_fsm;
