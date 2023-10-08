library verilog;
use verilog.vl_types.all;
entity ts_ana_demratio_fsm is
    generic(
        idle            : integer := 0;
        st_settle_0     : integer := 1;
        st_settle_1     : integer := 3;
        st_settle_2     : integer := 2;
        st_settle_3     : integer := 6;
        st_lrshift_0    : integer := 7;
        st_lrshift_1    : integer := 5;
        st_lrshift_2    : integer := 4;
        st_lrshift_3    : integer := 12;
        st_config_0     : integer := 14;
        st_config_1     : integer := 10;
        st_config_2     : integer := 15;
        st_wait         : integer := 9;
        st_done         : integer := 8
    );
    port(
        ts_clk          : in     vl_logic;
        ts_resetb       : in     vl_logic;
        ts_start_d      : in     vl_logic;
        ts_ct16_d       : in     vl_logic;
        ts_dgflow_done_d: in     vl_logic;
        ts_adc_reset_clrb: out    vl_logic;
        ts_clr_cnt      : out    vl_logic;
        ts_up_cnt       : out    vl_logic;
        ts_ct8_d        : in     vl_logic;
        ts_clrcnt8      : out    vl_logic;
        ts_upcnt8       : out    vl_logic;
        ts_ct2_d        : in     vl_logic;
        ts_ct3_d        : in     vl_logic;
        ts_cic_data_valid: in     vl_logic;
        ts_clrcnt3      : out    vl_logic;
        ts_upcnt3       : out    vl_logic;
        ts_ld1          : out    vl_logic;
        ts_ld2          : out    vl_logic;
        ts_lrshift      : out    vl_logic;
        ts_sarcalib_done_clr: out    vl_logic;
        ts_cic_counter_clr: out    vl_logic;
        ts_cic_strobe_en: out    vl_logic;
        ts_disable_cal_tst: in     vl_logic
    );
end ts_ana_demratio_fsm;
