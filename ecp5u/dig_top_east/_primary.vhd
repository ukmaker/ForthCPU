library verilog;
use verilog.vl_types.all;
entity dig_top_east is
    port(
        clock           : in     vl_logic;
        resetn          : in     vl_logic;
        ana_resetb      : in     vl_logic;
        mfg_array_tmon_tst_en: in     vl_logic;
        mfg_array_tmonclk_dis: in     vl_logic;
        ts_cfg_trim_thresh_short: in     vl_logic;
        ts_cfg_trim_thresh_open: in     vl_logic;
        ts_cfg_trim_offset: in     vl_logic_vector(7 downto 0);
        cfgbus_ld_addr_latch: in     vl_logic;
        cfgbus_ld_master_data_latch: in     vl_logic;
        cfgbus_ld_slave_data_latch: in     vl_logic;
        cfgbus_master_latch_datain: in     vl_logic_vector(7 downto 0);
        cfgbus_master_latch_dataout_east: out    vl_logic_vector(7 downto 0);
        cfgarray_dataout_oe: in     vl_logic;
        ts_datain       : in     vl_logic_vector(7 downto 0);
        ts_dataout      : out    vl_logic_vector(7 downto 0);
        ts_vol_ld_addr  : in     vl_logic;
        ts_vol_rd       : in     vl_logic;
        ts_vol_ld_data  : in     vl_logic;
        ts_tmon_a_reg   : out    vl_logic_vector(2 downto 0);
        ts_tmon_b_reg   : out    vl_logic_vector(2 downto 0);
        cfg_imon1_cr0   : out    vl_logic_vector(7 downto 0);
        cfg_imon1_cr1   : out    vl_logic_vector(7 downto 0);
        cfg_himon1_cr0  : out    vl_logic_vector(7 downto 0);
        cfg_himon1_cr1  : out    vl_logic_vector(7 downto 0);
        ts_filter_datain: in     vl_logic;
        dtpi            : in     vl_logic;
        ts_ana_half_clk : out    vl_logic;
        ts_ana_div4_clk : out    vl_logic;
        ts_ana_adc_resetb: out    vl_logic;
        ts_ana_beta_cmp : in     vl_logic;
        ts_ana_single_end_en: out    vl_logic;
        ts_ana_beta_cmp_en: out    vl_logic;
        ts_ana_beta_cmp_done: out    vl_logic;
        ts_ana_channel  : out    vl_logic_vector(2 downto 0);
        ts_ana_beta_bits: out    vl_logic_vector(5 downto 0);
        ts_ana_demratio : out    vl_logic_vector(15 downto 0);
        ts_ana_demout   : out    vl_logic;
        ts_porkchop     : out    vl_logic;
        ts_ana_mfg      : out    vl_logic_vector(7 downto 0);
        ts_sync_hvblock : in     vl_logic;
        mfg_hvblk_dis   : in     vl_logic;
        ts_trim_hvblk_dis: in     vl_logic
    );
end dig_top_east;
