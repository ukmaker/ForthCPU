library verilog;
use verilog.vl_types.all;
entity ts_dg_arith is
    generic(
        WIDTH           : integer := 32;
        SIZE            : integer := 16;
        CIC_SIZE        : integer := 1;
        TCH_NUM         : integer := 3
    );
    port(
        asc_clk         : in     vl_logic;
        cfg_resetb      : in     vl_logic;
        ana_resetb      : in     vl_logic;
        ts_mfg_test_mode: in     vl_logic;
        ts_cfg_trim_thresh_short: in     vl_logic;
        ts_cfg_trim_thresh_open: in     vl_logic;
        ts_cfg_trim_offset: in     vl_logic_vector(7 downto 0);
        ts_filter_datain: in     vl_logic;
        ts_datain       : in     vl_logic_vector(7 downto 0);
        ts_dataout      : out    vl_logic_vector(7 downto 0);
        ts_tmon_a_reg   : out    vl_logic_vector;
        ts_tmon_b_reg   : out    vl_logic_vector;
        ts_vol_ld_addr  : in     vl_logic;
        ts_vol_ld_data  : in     vl_logic;
        ts_vol_rd       : in     vl_logic;
        ts_cfg_ld_addr  : in     vl_logic;
        ts_cfg_ld_data  : in     vl_logic;
        ts_cfg_rd       : in     vl_logic;
        ts_ana_half_clk : out    vl_logic;
        ts_ana_div4_clk : out    vl_logic;
        ts_porkchop     : out    vl_logic;
        ts_ana_adc_resetb: out    vl_logic;
        ts_ana_beta_cmp : in     vl_logic;
        ts_ana_beta_cmp_en: out    vl_logic;
        ts_ana_beta_cmp_done: out    vl_logic;
        ts_ana_single_end_en: out    vl_logic;
        ts_ana_channel  : out    vl_logic_vector(2 downto 0);
        ts_ana_beta_bits: out    vl_logic_vector(5 downto 0);
        ts_ana_demratio : out    vl_logic_vector(15 downto 0);
        ts_ana_demout_bit: out    vl_logic;
        cfg_imon1_cr0_sel: out    vl_logic;
        cfg_imon1_cr1_sel: out    vl_logic;
        cfg_himon1_cr0_sel: out    vl_logic;
        cfg_himon1_cr1_sel: out    vl_logic;
        ts_ana_mfg      : out    vl_logic_vector(7 downto 0);
        ts_dtpi         : in     vl_logic;
        ts_sync_hvblock : in     vl_logic;
        ts_disable_clk_mfg: in     vl_logic;
        ts_mfg_hvblk_dis: in     vl_logic;
        ts_trim_hvblk_dis: in     vl_logic
    );
end ts_dg_arith;
