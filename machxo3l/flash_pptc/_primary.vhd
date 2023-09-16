library verilog;
use verilog.vl_types.all;
entity flash_pptc is
    generic(
        st_idle         : integer := 0;
        st_romt_init    : integer := 1;
        st_romt_rd      : integer := 3;
        st_romt_cap     : integer := 2;
        st_romt_chk     : integer := 6;
        st_trmt_init    : integer := 7;
        st_trmt_rd      : integer := 5;
        st_trmt_chk     : integer := 4;
        st_trmt_cap     : integer := 12;
        st_ramt_init    : integer := 13;
        st_ramt_rdwt    : integer := 15;
        st_ramt_cap     : integer := 14;
        st_ramt_incr    : integer := 10;
        st_ramt_chk     : integer := 11;
        st_ramt_wait    : integer := 9;
        st_finish       : integer := 8
    );
    port(
        lsc_ppt         : out    vl_logic;
        fl_finish_ppt   : out    vl_logic;
        fl_busy_ppt     : out    vl_logic;
        ppt_row_addr    : out    vl_logic_vector(15 downto 0);
        ppt_read128_exec: out    vl_logic;
        ppt_read_rom_exec: out    vl_logic;
        ppt_en          : out    vl_logic;
        ppt_rowsel      : out    vl_logic;
        ppt_pset        : out    vl_logic;
        ppt_load_trim   : out    vl_logic;
        ppt_init_tsf_asr_exec: out    vl_logic;
        ppt_exec_buf_cap: out    vl_logic;
        ppt_write_incr_exec: out    vl_logic;
        ppt_dsr_shf8_en : out    vl_logic;
        ppt_dsr_shf     : out    vl_logic;
        romt_cap_0      : out    vl_logic;
        romt_cap_1      : out    vl_logic;
        romt_cap_2      : out    vl_logic;
        romt_cap_3      : out    vl_logic;
        ppt_state       : out    vl_logic_vector(3 downto 0);
        isc_rst_async   : in     vl_logic;
        isc_rst_sync    : in     vl_logic;
        smclk           : in     vl_logic;
        fsafe           : in     vl_logic;
        mfg_ppt_abort   : in     vl_logic;
        fl_start_ppt    : in     vl_logic;
        ppt_row_nowait  : in     vl_logic;
        busy_flash      : in     vl_logic;
        busy_sram       : in     vl_logic;
        romr_ppt_bits   : in     vl_logic_vector(7 downto 0);
        trmr_ppt_bits   : in     vl_logic_vector(7 downto 0);
        mc1_ppt_bits    : in     vl_logic_vector(7 downto 0)
    );
end flash_pptc;
