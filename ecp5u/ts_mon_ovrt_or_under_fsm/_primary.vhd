library verilog;
use verilog.vl_types.all;
entity ts_mon_ovrt_or_under_fsm is
    generic(
        wait_d          : integer := 0;
        upct_d          : integer := 1;
        dnct_d          : integer := 3;
        rset_tmon_d     : integer := 7;
        set_tmon_d      : integer := 4
    );
    port(
        asc_clk         : in     vl_logic;
        ts_resetb       : in     vl_logic;
        ts_valid        : in     vl_logic;
        ts_hyst_neg     : in     vl_logic;
        ts_cmp_ovrtthres: in     vl_logic;
        ts_cmp_ovrthyst : in     vl_logic;
        ts_tmon_alarm   : in     vl_logic;
        ts_tol_reg      : in     vl_logic_vector(3 downto 0);
        ts_clrtmon_ovrt : out    vl_logic;
        ts_setmon_ovrt  : out    vl_logic
    );
end ts_mon_ovrt_or_under_fsm;
