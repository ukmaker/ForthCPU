library verilog;
use verilog.vl_types.all;
entity twi_bfm_monitor is
    generic(
        TWI_CRC_SEED    : integer := 255;
        TWI_ACK         : integer := 6;
        TWI_NACK        : integer := 9;
        RDAT_DATA_START : integer := 8;
        RDAT_DATA_END   : integer := 79;
        RDAT_FILL_START : integer := 80;
        RDAT_FILL_END   : integer := 111;
        RDAT_CRC_START  : integer := 112;
        RDAT_CRC_END    : integer := 119;
        RDAT_ACK_START  : integer := 124;
        RDAT_ACK_END    : integer := 127;
        WDAT_FILL_START : integer := 8;
        WDAT_FILL_END   : integer := 23;
        WDAT_DATA_START : integer := 24;
        WDAT_DATA_END   : integer := 111;
        WDAT_CRC_START  : integer := 112;
        WDAT_CRC_END    : integer := 119;
        WDAT_ACK_START  : integer := 124;
        WDAT_ACK_END    : integer := 127;
        TWI_CRC_POLY    : integer := 47;
        DEF_RESET       : integer := 0;
        WRCLK_PERIOD    : integer := 125;
        MSGLEN          : integer := 30
    );
    port(
        wrclk           : in     vl_logic;
        wdat            : in     vl_logic;
        rdat            : out    vl_logic
    );
end twi_bfm_monitor;
