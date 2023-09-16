library verilog;
use verilog.vl_types.all;
entity flash_sdm is
    generic(
        DECRYPTION      : integer := 1;
        st_idle         : integer := 0;
        st_init         : integer := 1;
        st_aset         : integer := 3;
        st_rdwt         : integer := 2;
        st_dcap         : integer := 6;
        st_finish       : integer := 4;
        st_abort        : integer := 5
    );
    port(
        lsc_sdm         : out    vl_logic;
        fl_finish_sdm   : out    vl_logic;
        fl_busy_sdm     : out    vl_logic;
        sdm_init_sram_asr_exec: out    vl_logic;
        sdm_set_addr    : out    vl_logic;
        sdm_row_addr    : out    vl_logic_vector(15 downto 0);
        sdm_exec_buf_cap: out    vl_logic;
        sdm_exec_buf_shf_en: out    vl_logic;
        sdm_read128_incr_exec: out    vl_logic;
        sdm_start_bse   : out    vl_logic;
        sdm_bse_eof     : out    vl_logic;
        fail_sdm        : out    vl_logic;
        preamble_std_sdm: out    vl_logic;
        preamble_enc_sdm: out    vl_logic;
        preamble_err_sdm: out    vl_logic;
        isc_rst_async   : in     vl_logic;
        isc_rst_sync    : in     vl_logic;
        smclk           : in     vl_logic;
        isc_exec_d      : in     vl_logic;
        fl_start_sdm0   : in     vl_logic;
        fl_start_sdm1   : in     vl_logic;
        fl_start_sdm2   : in     vl_logic;
        fsd_gold_addr   : in     vl_logic_vector(15 downto 0);
        dev_sdm_qual    : in     vl_logic;
        busy_flash      : in     vl_logic;
        eof_cfg         : in     vl_logic;
        eof_ufm         : in     vl_logic;
        flash_secplus   : in     vl_logic;
        finish_bse      : in     vl_logic;
        fail_bse        : in     vl_logic;
        njbse_preamble  : in     vl_logic;
        sdm_run         : in     vl_logic;
        dnld_dat        : in     vl_logic_vector(7 downto 0)
    );
end flash_sdm;
