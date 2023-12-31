library verilog;
use verilog.vl_types.all;
entity cfg_i2c is
    port(
        cfg_i2c_dout    : out    vl_logic_vector(7 downto 0);
        i2ccr1_wt_prm   : out    vl_logic;
        i2ccmdr_wt_prm  : out    vl_logic;
        i2cbr_wt_prm    : out    vl_logic;
        i2ctxdr_wt_prm  : out    vl_logic;
        i2crxdr_rd_prm  : out    vl_logic;
        i2cgcdr_rd_prm  : out    vl_logic;
        i2ccr1_prm      : out    vl_logic_vector(7 downto 0);
        i2ccmdr_prm     : out    vl_logic_vector(7 downto 0);
        i2ctxdr_prm     : out    vl_logic_vector(7 downto 0);
        i2cbr_prm       : out    vl_logic_vector(9 downto 0);
        smclk           : in     vl_logic;
        nj_rst_async    : in     vl_logic;
        nj_rst_sync     : in     vl_logic;
        p_i2c           : in     vl_logic;
        isc_operational : in     vl_logic;
        isc_exec_b      : in     vl_logic;
        isc_exec_e      : in     vl_logic;
        isc_disable_exec: in     vl_logic;
        cfg_i2c_dat     : in     vl_logic_vector(15 downto 0);
        lsc_i2ci_crbr_wt_qual: in     vl_logic;
        lsc_i2ci_txdr_wt_qual: in     vl_logic;
        lsc_i2ci_rxdr_rd_qual: in     vl_logic;
        lsc_i2ci_sr_rd_qual: in     vl_logic;
        i2csr_1st       : in     vl_logic_vector(7 downto 0);
        i2crxdr_1st     : in     vl_logic_vector(7 downto 0);
        i2ccr1_1st      : in     vl_logic_vector(7 downto 0);
        i2ccmdr_1st     : in     vl_logic_vector(7 downto 0);
        i2ctxdr_1st     : in     vl_logic_vector(7 downto 0);
        i2cbr_1st       : in     vl_logic_vector(9 downto 0);
        wb_i2ccr1_wt_1st: in     vl_logic;
        wb_i2ccmdr_wt_1st: in     vl_logic;
        wb_i2cbr_wt_1st : in     vl_logic;
        wb_i2ctxdr_wt_1st: in     vl_logic;
        wb_i2crxdr_rd_1st: in     vl_logic;
        wb_i2cgcdr_rd_1st: in     vl_logic
    );
end cfg_i2c;
