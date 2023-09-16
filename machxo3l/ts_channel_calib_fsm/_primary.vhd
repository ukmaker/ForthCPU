library verilog;
use verilog.vl_types.all;
entity ts_channel_calib_fsm is
    generic(
        idle            : integer := 0;
        st_settle       : integer := 1;
        st_config       : integer := 3;
        st_set_bit_0    : integer := 2;
        st_wait_comp    : integer := 6;
        st_set_bit_1    : integer := 7;
        st_rset_bit     : integer := 5;
        st_done         : integer := 13;
        st_wait_dgflow  : integer := 4
    );
    port(
        ts_clk          : in     vl_logic;
        ts_resetb       : in     vl_logic;
        ts_start_d      : in     vl_logic;
        ts_beta_cmp_d   : in     vl_logic;
        ts_ct5_d        : in     vl_logic;
        ts_ct12_d       : in     vl_logic;
        ts_dgflow_done_d: in     vl_logic;
        ts_clr_cnt      : out    vl_logic;
        ts_up_cnt       : out    vl_logic;
        ts_setsar_bit   : out    vl_logic;
        ts_rsetsar_bit  : out    vl_logic;
        ts_sarcalib_en  : out    vl_logic;
        ts_sarcalib_done: out    vl_logic;
        ts_disable_cal_tst: in     vl_logic
    );
end ts_channel_calib_fsm;
