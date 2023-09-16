library verilog;
use verilog.vl_types.all;
entity clt_sysi is
    generic(
        CLT_DBW         : integer := 10;
        SYS_DBW         : integer := 8
    );
    port(
        sys_iavg_dout   : out    vl_logic_vector;
        sys_ucp_dout    : out    vl_logic_vector;
        ucp_pending     : out    vl_logic;
        sys_rstb        : in     vl_logic;
        sys_clk         : in     vl_logic;
        sys_iavg_dat_cs : in     vl_logic;
        sys_ucp_dat_cs  : in     vl_logic;
        sys_addr        : in     vl_logic_vector(2 downto 0);
        sys_rd_str      : in     vl_logic;
        imon_avg_dat0   : in     vl_logic_vector;
        imon_avg_dat1   : in     vl_logic_vector;
        imon_avg_dat2   : in     vl_logic_vector;
        imon_avg_dat3   : in     vl_logic_vector;
        ucp_cnv_dat     : in     vl_logic_vector;
        sys_wt_str      : in     vl_logic;
        sys_ucp_cr_sel  : in     vl_logic;
        sch_ucp_goes    : in     vl_logic;
        sch_ucp_done    : in     vl_logic
    );
end clt_sysi;
