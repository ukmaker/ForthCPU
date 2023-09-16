library verilog;
use verilog.vl_types.all;
entity ts_ana_upcounter is
    port(
        ts_ana_clk      : in     vl_logic;
        ts_resetb       : in     vl_logic;
        ts_upct_d       : in     vl_logic;
        ts_clr_d        : in     vl_logic;
        ts_ct5          : out    vl_logic;
        ts_ct12         : out    vl_logic;
        ts_ct16         : out    vl_logic;
        ts_count_reg    : out    vl_logic_vector(3 downto 0)
    );
end ts_ana_upcounter;
