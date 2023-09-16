library verilog;
use verilog.vl_types.all;
entity cfg_clk is
    port(
        usrclk          : out    vl_logic;
        dtsclk          : out    vl_logic;
        del_clk         : out    vl_logic;
        cib_wkup_clk_sel: out    vl_logic;
        smclk_div       : out    vl_logic;
        smclk_sel_enc   : out    vl_logic_vector(1 downto 0);
        rti_npd         : out    vl_logic;
        tdr_sel_tck     : out    vl_logic;
        sedclk_div      : out    vl_logic;
        por             : in     vl_logic;
        intclk          : in     vl_logic;
        smclk_int       : in     vl_logic;
        smclk_ext       : in     vl_logic;
        scpu_writen     : in     vl_logic;
        tck             : in     vl_logic;
        mfg_clkx2       : in     vl_logic;
        mfg_tckrti      : in     vl_logic;
        mfg_tckrti_force: in     vl_logic;
        sed_en          : in     vl_logic;
        sedclk          : in     vl_logic;
        ctrl_smfreq_sel : in     vl_logic_vector(1 downto 0);
        cib_wkupclk_en  : in     vl_logic;
        ref_sys_slow    : in     vl_logic;
        mc1_dts_clk     : in     vl_logic;
        mc1_sync_source : in     vl_logic;
        mc1_sed_clk     : in     vl_logic_vector(6 downto 0);
        mc1_usr_clk     : in     vl_logic_vector(6 downto 0);
        rti             : in     vl_logic;
        seldr_ss        : in     vl_logic;
        updr_ss         : in     vl_logic;
        upir_ss         : in     vl_logic;
        tdrclk_sw_i     : in     vl_logic;
        busy_seldr      : in     vl_logic
    );
end cfg_clk;
