library verilog;
use verilog.vl_types.all;
entity clt_pfmux is
    generic(
        CLT_DBW         : integer := 10
    );
    port(
        sd_clt_prof0    : out    vl_logic_vector;
        sd_clt_prof1    : out    vl_logic_vector;
        sd_clt_prof2    : out    vl_logic_vector;
        sd_clt_prof3    : out    vl_logic_vector;
        twi_chn_pfsel   : in     vl_logic_vector(15 downto 0);
        sd_clt_prof0_0  : in     vl_logic_vector;
        sd_clt_prof0_1  : in     vl_logic_vector;
        sd_clt_prof0_2  : in     vl_logic_vector;
        sd_clt_prof1_0  : in     vl_logic_vector;
        sd_clt_prof1_1  : in     vl_logic_vector;
        sd_clt_prof1_2  : in     vl_logic_vector;
        sd_clt_prof2_0  : in     vl_logic_vector;
        sd_clt_prof2_1  : in     vl_logic_vector;
        sd_clt_prof2_2  : in     vl_logic_vector;
        sd_clt_prof3_0  : in     vl_logic_vector;
        sd_clt_prof3_1  : in     vl_logic_vector;
        sd_clt_prof3_2  : in     vl_logic_vector
    );
end clt_pfmux;
