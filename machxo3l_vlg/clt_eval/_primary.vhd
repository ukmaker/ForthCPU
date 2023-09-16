library verilog;
use verilog.vl_types.all;
entity clt_eval is
    generic(
        CLT_DBW         : integer := 10;
        DAC_DBW         : integer := 8;
        XTR_DBW         : integer := 3
    );
    port(
        ucp_cnv_dat     : out    vl_logic_vector;
        clt_dat0        : out    vl_logic_vector;
        clt_dat1        : out    vl_logic_vector;
        clt_dat2        : out    vl_logic_vector;
        clt_dat3        : out    vl_logic_vector;
        imon_avg_dat0   : out    vl_logic_vector;
        imon_avg_dat1   : out    vl_logic_vector;
        imon_avg_dat2   : out    vl_logic_vector;
        imon_avg_dat3   : out    vl_logic_vector;
        clt_eval_done   : out    vl_logic;
        clt_rstb        : in     vl_logic;
        clt_clk         : in     vl_logic;
        sd_clt_chn_inv  : in     vl_logic_vector(7 downto 0);
        sd_clt_prof0    : in     vl_logic_vector;
        sd_clt_prof1    : in     vl_logic_vector;
        sd_clt_prof2    : in     vl_logic_vector;
        sd_clt_prof3    : in     vl_logic_vector;
        ucp_eval_en     : in     vl_logic;
        clt_eval_en     : in     vl_logic;
        imon_eval_en    : in     vl_logic;
        clt_eval_start  : in     vl_logic;
        clt_eval_mux_sel: in     vl_logic_vector(5 downto 0);
        adc_data_reg    : in     vl_logic_vector;
        clt_chn_byp     : in     vl_logic;
        ch1_bypass      : in     vl_logic;
        ch2_bypass      : in     vl_logic;
        ch3_bypass      : in     vl_logic;
        ch4_bypass      : in     vl_logic
    );
end clt_eval;
