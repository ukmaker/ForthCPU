library verilog;
use verilog.vl_types.all;
entity ts_cic_strobe_valid_fsm is
    generic(
        idle            : integer := 0;
        st_strobe1a     : integer := 1;
        st_0            : integer := 3;
        st_strobe1b     : integer := 2;
        st_1            : integer := 6;
        st_strobe2      : integer := 7;
        st_2            : integer := 5;
        st_valid        : integer := 4
    );
    port(
        asc_clk         : in     vl_logic;
        ts_resetb       : in     vl_logic;
        ts_ct0          : in     vl_logic;
        ts_ct1          : in     vl_logic;
        ts_ct2          : in     vl_logic;
        ts_strobe       : out    vl_logic;
        ts_valid        : out    vl_logic
    );
end ts_cic_strobe_valid_fsm;
