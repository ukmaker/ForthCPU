library verilog;
use verilog.vl_types.all;
entity ts_ana_lrshift_reg is
    port(
        ts_clk          : in     vl_logic;
        ts_resetb       : in     vl_logic;
        ts_clr          : in     vl_logic;
        ts_i2c_ld_lo    : in     vl_logic;
        ts_i2c_ld_hi    : in     vl_logic;
        ts_ld1          : in     vl_logic;
        ts_ld2          : in     vl_logic;
        ts_ld3          : in     vl_logic;
        ts_lrshift      : in     vl_logic;
        ts_demratio     : out    vl_logic_vector(15 downto 0);
        ts_din          : in     vl_logic_vector(7 downto 0);
        ts_dout         : out    vl_logic_vector(7 downto 0)
    );
end ts_ana_lrshift_reg;
