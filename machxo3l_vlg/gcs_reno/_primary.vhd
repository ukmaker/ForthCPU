library verilog;
use verilog.vl_types.all;
entity gcs_reno is
    port(
        gcs_twi_thres   : in     vl_logic_vector(3 downto 0);
        gcs_twi_cmp     : in     vl_logic_vector(2 downto 0);
        gcs_twi_hyst_enable: in     vl_logic_vector(3 downto 0);
        gcs_twi_data    : in     vl_logic_vector(5 downto 0);
        gcs_i2c_ctrl    : in     vl_logic_vector(5 downto 0);
        gcs_cfg_thres   : in     vl_logic_vector(3 downto 0);
        gcs_cfg_thres_select: in     vl_logic;
        vmon_ldsshdw    : in     vl_logic;
        resetn          : in     vl_logic;
        gcs_cfg_data_ctrl: in     vl_logic_vector(11 downto 0);
        gcs_cfg_config  : in     vl_logic_vector(23 downto 0);
        gcs_cfg_sel_b   : in     vl_logic_vector(5 downto 0);
        gcs_imon_thres  : out    vl_logic_vector(3 downto 0);
        gcs_imonf       : in     vl_logic_vector(1 downto 0);
        gcs_imona       : in     vl_logic_vector(2 downto 1);
        gcs_imonb       : in     vl_logic;
        gcs_vmona       : in     vl_logic_vector(7 downto 4);
        gcs_vmonb       : in     vl_logic_vector(6 downto 5);
        gcs_dio_in      : in     vl_logic_vector(5 downto 0);
        gcs_hv_out      : out    vl_logic_vector(3 downto 0);
        gcs_dio_out     : out    vl_logic_vector(1 downto 0)
    );
end gcs_reno;
