library verilog;
use verilog.vl_types.all;
entity clt_daci is
    generic(
        DAC_DBW         : integer := 8;
        SYS_DBW         : integer := 8
    );
    port(
        dac_clt_dout    : out    vl_logic_vector;
        dac_bpz         : out    vl_logic_vector(1 downto 0);
        clt_rstb        : in     vl_logic;
        clt_clk         : in     vl_logic;
        clt_dat0        : in     vl_logic_vector;
        clt_dat1        : in     vl_logic_vector;
        clt_dat2        : in     vl_logic_vector;
        clt_dat3        : in     vl_logic_vector;
        sd_bpz_all      : in     vl_logic_vector(15 downto 0);
        dac_chn_sel     : in     vl_logic_vector(2 downto 0);
        dac_ready       : in     vl_logic;
        dac_init        : in     vl_logic
    );
end clt_daci;
