library verilog;
use verilog.vl_types.all;
entity config_cntl is
    port(
        jshift          : out    vl_logic;
        jtdi            : out    vl_logic;
        jce             : out    vl_logic_vector(2 downto 1);
        cfg_se          : out    vl_logic;
        sel_scan2       : out    vl_logic;
        iscan_out       : out    vl_logic_vector(7 downto 0);
        por             : out    vl_logic;
        cfg_addr_por_n  : out    vl_logic;
        cfg_data_por_n  : out    vl_logic;
        sram_ppt_addr   : out    vl_logic_vector(3 downto 0);
        gsrn            : out    vl_logic;
        sf_ppt_addr     : in     vl_logic_vector(3 downto 0);
        isptcy_shcap    : in     vl_logic;
        isptcy_tdi      : in     vl_logic;
        isptcy_ener1    : in     vl_logic;
        isptcy_ener2    : in     vl_logic;
        iscan_en        : in     vl_logic_vector(7 downto 0);
        jtdo            : in     vl_logic_vector(2 downto 1);
        pi_sn           : in     vl_logic;
        scan2_out       : in     vl_logic;
        pfsafe          : in     vl_logic;
        pwrup_pur_n     : in     vl_logic;
        cfg_osc         : in     vl_logic;
        gsrn_sync_clk   : in     vl_logic;
        gsrn_out        : in     vl_logic;
        gsrn_sync       : in     vl_logic
    );
end config_cntl;
