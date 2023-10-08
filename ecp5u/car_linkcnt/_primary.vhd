library verilog;
use verilog.vl_types.all;
entity car_linkcnt is
    port(
        asc_clk         : in     vl_logic;
        asc_resetb      : in     vl_logic;
        asc_half_clk    : out    vl_logic;
        asc_div4_clk    : out    vl_logic;
        asc_div8_clk    : out    vl_logic;
        asc_div16_clk   : out    vl_logic;
        asc_div32_clk   : out    vl_logic;
        asc_div128_clk  : out    vl_logic;
        asc_div256_clk  : out    vl_logic;
        cfg_resetb      : in     vl_logic;
        ana_resetb      : in     vl_logic;
        ts_dtpi         : in     vl_logic;
        ts_adc_demratio_clr_resetb: in     vl_logic;
        ts_dgflow_done  : in     vl_logic;
        ts_ana_dig_resetb: out    vl_logic;
        ts_ana_dgflow_resetb: out    vl_logic;
        ts_output_regs_resetb: out    vl_logic;
        ts_test_config_resetb: out    vl_logic;
        ts_cfg_resetb   : out    vl_logic;
        ts_ana_adc_resetb: out    vl_logic;
        ts_alarm_resetb : out    vl_logic;
        ts_sync_hvblock : in     vl_logic;
        ts_valid_tmon_addr: in     vl_logic;
        ts_cfg_ld_data  : in     vl_logic;
        ts_enable_ext_reset_tst: in     vl_logic;
        ts_8mhz_clk     : out    vl_logic;
        ts_disable_clk_mfg: in     vl_logic;
        ts_cic_clk      : out    vl_logic;
        ts_gate_adc_reset: in     vl_logic;
        ts_mfg_hvblk_dis: in     vl_logic;
        ts_trim_hvblk_dis: in     vl_logic
    );
end car_linkcnt;
