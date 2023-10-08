library verilog;
use verilog.vl_types.all;
entity ts_cic is
    generic(
        WIDTH           : integer := 20
    );
    port(
        cic_clk         : in     vl_logic;
        asc_clk         : in     vl_logic;
        ts_resetb       : in     vl_logic;
        cfg_resetb      : in     vl_logic;
        ts_data_valid   : out    vl_logic;
        ts_data_valid_en: in     vl_logic;
        ts_cic_counter_clr: in     vl_logic;
        ts_filter_datain: in     vl_logic;
        ts_filter_dataout: out    vl_logic_vector(15 downto 0);
        ts_datain       : in     vl_logic_vector(7 downto 0);
        ts_cic_dataout  : out    vl_logic_vector(7 downto 0);
        ts_vol_rd       : in     vl_logic;
        ts_vol_ld_data  : in     vl_logic;
        ts_ld_from_i2c_filter_dataout_lo_reg: in     vl_logic;
        ts_ld_from_i2c_filter_dataout_hi_reg: in     vl_logic;
        ts_ld_from_i2c_filter_data_ready: in     vl_logic;
        ts_mfg_start_mul: out    vl_logic;
        ts_ld_from_alu_toffset_reg: in     vl_logic
    );
end ts_cic;
