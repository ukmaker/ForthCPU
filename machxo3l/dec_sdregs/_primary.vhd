library verilog;
use verilog.vl_types.all;
entity dec_sdregs is
    generic(
        FLASH_MEM       : integer := 1;
        EFUSE_MEM       : integer := 1
    );
    port(
        sd_dec_only     : out    vl_logic;
        sd_key_last     : out    vl_logic_vector(127 downto 0);
        por             : in     vl_logic;
        smclk           : in     vl_logic;
        ENC_ONLY_EN     : in     vl_logic;
        fl_erase_fea    : in     vl_logic;
        cmd_load_feabits: in     vl_logic;
        cmd_load_key    : in     vl_logic;
        feabits_update  : in     vl_logic;
        key_update      : in     vl_logic;
        buf128_int      : in     vl_logic_vector(127 downto 0);
        exec_buf        : in     vl_logic_vector(127 downto 0)
    );
end dec_sdregs;
