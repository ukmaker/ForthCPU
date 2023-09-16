library verilog;
use verilog.vl_types.all;
entity twi_rdat_ctl_fsm is
    generic(
        IDLE_D          : integer := 0;
        LD_REG_D        : integer := 1;
        RSHIFT_D        : integer := 3;
        CLR_RSHIFT_D    : integer := 2;
        LD_CRC_D        : integer := 6;
        RSHIFT_CRC_D    : integer := 7;
        LD_SYMBOL_D     : integer := 5;
        RSHIFT_SYMBOL_D : integer := 4;
        LD_ACK_D        : integer := 12;
        LD_NACK_D       : integer := 13;
        RSHIFT_NACK_OR_ACK_D: integer := 9;
        INIT_D          : integer := 8
    );
    port(
        twi_clk         : in     vl_logic;
        twi_resetb      : in     vl_logic;
        twi_start_from_xo2: in     vl_logic;
        twi_ack         : in     vl_logic;
        twi_nack        : in     vl_logic;
        twi_sym_ct      : in     vl_logic;
        twi_bit_ct      : in     vl_logic;
        twi_byte_ct     : in     vl_logic;
        twi_rdat_byte_count_reg: in     vl_logic_vector(3 downto 0);
        twi_crc_enable_d: out    vl_logic;
        twi_clr_rshift_reg: out    vl_logic;
        twi_clr_crc     : out    vl_logic;
        twi_ld_rshift_reg: out    vl_logic;
        twi_ld_crc      : out    vl_logic;
        twi_ld_sym      : out    vl_logic;
        twi_ld_ack      : out    vl_logic;
        twi_ld_nack     : out    vl_logic;
        twi_rshift_by_one: out    vl_logic;
        twi_clr_bitct   : out    vl_logic;
        twi_incr_bitct  : out    vl_logic;
        twi_incr_bytect : out    vl_logic
    );
end twi_rdat_ctl_fsm;
