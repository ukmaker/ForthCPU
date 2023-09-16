library verilog;
use verilog.vl_types.all;
entity ts_ana_upcounter1 is
    port(
        ts_ana_clk      : in     vl_logic;
        ts_resetb       : in     vl_logic;
        ts_count_reg    : out    vl_logic_vector(1 downto 0);
        ts_count8_reg   : out    vl_logic_vector(3 downto 0);
        ts_upct8_d      : in     vl_logic;
        ts_clrct8_d     : in     vl_logic;
        ts_ct8          : out    vl_logic;
        ts_upct3_d      : in     vl_logic;
        ts_clrct3_d     : in     vl_logic;
        ts_ct2          : out    vl_logic;
        ts_ct3          : out    vl_logic
    );
end ts_ana_upcounter1;
