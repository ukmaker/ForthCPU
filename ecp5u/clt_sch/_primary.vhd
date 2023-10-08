library verilog;
use verilog.vl_types.all;
entity clt_sch is
    generic(
        CLT_DBW         : integer := 10;
        SYS_DBW         : integer := 8
    );
    port(
        ucp_eval_en     : out    vl_logic;
        clt_eval_en     : out    vl_logic;
        imon_eval_en    : out    vl_logic;
        clt_eval_start  : out    vl_logic;
        clt_eval_mux_sel: out    vl_logic_vector(5 downto 0);
        adc_data_reg    : out    vl_logic_vector;
        clt_chn_byp     : out    vl_logic;
        adc_socb        : out    vl_logic;
        adc_mux_sel     : out    vl_logic_vector(3 downto 0);
        adc_atten       : out    vl_logic;
        sch_ucp_goes    : out    vl_logic;
        sch_ucp_done    : out    vl_logic;
        clt_rstb        : in     vl_logic;
        clt_clk         : in     vl_logic;
        clt_ena         : in     vl_logic;
        clt_eval_done   : in     vl_logic;
        sys_ucp_lp      : in     vl_logic;
        ucp_pending     : in     vl_logic;
        ucp_adc_mux_sel : in     vl_logic_vector(5 downto 0);
        sys_imon_en     : in     vl_logic_vector(3 downto 0);
        twi_clt_chn_en  : in     vl_logic_vector;
        sd_clt_chn_byp  : in     vl_logic_vector(7 downto 0);
        sd_clt_chn_attn : in     vl_logic_vector(7 downto 0);
        sd_clt_rate_sel : in     vl_logic_vector(1 downto 0);
        sd_imon_rate_sel: in     vl_logic_vector(1 downto 0);
        hvblock         : in     vl_logic;
        vmon_odd        : in     vl_logic;
        adc_done        : in     vl_logic;
        adc_data        : in     vl_logic_vector
    );
end clt_sch;
