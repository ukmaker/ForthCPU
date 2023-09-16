library verilog;
use verilog.vl_types.all;
entity ts_channel_calib is
    port(
        asc_clk         : in     vl_logic;
        ts_clk          : in     vl_logic;
        ts_resetb       : in     vl_logic;
        ts_start_d      : in     vl_logic;
        ts_beta_cmp_d   : in     vl_logic;
        ts_ct5_d        : in     vl_logic;
        ts_ct12_d       : in     vl_logic;
        ts_dgflow_done_d: in     vl_logic;
        ts_count_reg    : in     vl_logic_vector(2 downto 0);
        ts_clr_cnt      : out    vl_logic;
        ts_up_cnt       : out    vl_logic;
        ts_sarcalib_en  : out    vl_logic;
        ts_sarcalib_done: out    vl_logic;
        ts_sar_reg      : out    vl_logic_vector(5 downto 0);
        ts_datain       : in     vl_logic_vector(7 downto 0);
        ts_dataout      : out    vl_logic_vector(7 downto 0);
        ts_rd_from_i2c_sar_reg: in     vl_logic;
        ts_vol_ld_data  : in     vl_logic;
        ts_vol_rd       : in     vl_logic;
        ts_disable_cal_tst: in     vl_logic
    );
end ts_channel_calib;
