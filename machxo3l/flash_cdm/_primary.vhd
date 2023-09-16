library verilog;
use verilog.vl_types.all;
entity flash_cdm is
    generic(
        st_idle         : integer := 0;
        st_trmr_set     : integer := 1;
        st_tfu_rd       : integer := 3;
        st_tfu_cap      : integer := 2;
        st_trm_wait     : integer := 6;
        st_fear_set     : integer := 7;
        st_udss_set     : integer := 5;
        st_finish       : integer := 4
    );
    port(
        lsc_cdm         : out    vl_logic;
        fl_finish_cdm   : out    vl_logic;
        fl_busy_cdm     : out    vl_logic;
        cdm_row_addr    : out    vl_logic_vector(15 downto 0);
        cdm_read64_exec : out    vl_logic;
        cdm_read128_exec: out    vl_logic;
        cdm_read_udss_exec: out    vl_logic;
        cdm_load_trim   : out    vl_logic;
        cdm_load_mes    : out    vl_logic;
        cdm_load_key    : out    vl_logic;
        cdm_load_pwd    : out    vl_logic;
        cdm_load_feature: out    vl_logic;
        cdm_load_feabits: out    vl_logic;
        cdm_load_otps   : out    vl_logic;
        cdm_load_ues    : out    vl_logic;
        isc_rst_async   : in     vl_logic;
        isc_rst_sync    : in     vl_logic;
        smclk           : in     vl_logic;
        fl_start_cdm    : in     vl_logic;
        busy_flash      : in     vl_logic
    );
end flash_cdm;
