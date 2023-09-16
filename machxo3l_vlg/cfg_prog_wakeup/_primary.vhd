library verilog;
use verilog.vl_types.all;
entity cfg_prog_wakeup is
    generic(
        FLASH_MEM       : integer := 1;
        ST_IDLE         : integer := 0;
        ST_INIT         : integer := 1;
        ST_WAIT         : integer := 3;
        ST_T0           : integer := 2;
        ST_T1           : integer := 6;
        ST_T2           : integer := 7;
        ST_T3           : integer := 5
    );
    port(
        gsrn_tmr        : out    vl_logic;
        gwe_tmr         : out    vl_logic;
        goe_tmr         : out    vl_logic;
        done_tmr        : out    vl_logic;
        fio_tmr         : out    vl_logic;
        fmib_tmr        : out    vl_logic;
        busy_wkup       : out    vl_logic;
        wkup_aux_pulse  : out    vl_logic;
        sleep_mode_flag : out    vl_logic;
        wkup_done_cib   : out    vl_logic;
        por             : in     vl_logic;
        smclk           : in     vl_logic;
        wkupclk         : in     vl_logic;
        done_pin_sync   : in     vl_logic;
        start_wakeup    : in     vl_logic;
        enter_offline_exec: in     vl_logic;
        enter_offline_eqv: in     vl_logic;
        enter_sleep_mode: in     vl_logic;
        exit_sleep_mode : in     vl_logic;
        jtag_active     : in     vl_logic;
        rst_wkup_done   : in     vl_logic;
        scanen          : in     vl_logic;
        ctrl_wkup_tran  : in     vl_logic;
        ctrl_ndr        : in     vl_logic;
        mc1_gsr_phase   : in     vl_logic_vector(2 downto 0);
        mc1_gwe_phase   : in     vl_logic_vector(2 downto 0);
        mc1_goe_phase   : in     vl_logic_vector(2 downto 0);
        mc1_done_phase  : in     vl_logic_vector(3 downto 0);
        mc1_pll_chk     : in     vl_logic_vector(7 downto 0);
        mc1_sync_ext_done: in     vl_logic;
        mc1_gsrn        : in     vl_logic;
        mc1_gwe         : in     vl_logic;
        mc1_goe         : in     vl_logic;
        mc1_mib         : in     vl_logic;
        mc1_sleep_gsrn  : in     vl_logic;
        mc1_sleep_gwe   : in     vl_logic;
        mc1_sleep_fio   : in     vl_logic;
        mc1_wkup_pw     : in     vl_logic_vector(3 downto 0);
        mc1_wkup_pd     : in     vl_logic_vector(3 downto 0);
        fsd_persist_done: in     vl_logic;
        cib_pll_lock    : in     vl_logic_vector(7 downto 0)
    );
end cfg_prog_wakeup;
