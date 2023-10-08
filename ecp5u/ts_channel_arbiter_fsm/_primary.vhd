library verilog;
use verilog.vl_types.all;
entity ts_channel_arbiter_fsm is
    generic(
        idle            : integer := 1;
        st_ch0          : integer := 2;
        st_ch1          : integer := 4;
        st_ch2          : integer := 8
    );
    port(
        asc_clk         : in     vl_logic;
        ts_resetb       : in     vl_logic;
        ts_channel_en_d : in     vl_logic_vector(2 downto 0);
        ts_dgflow_done_d: in     vl_logic;
        ts_st_ch0_d     : out    vl_logic;
        ts_st_ch1_d     : out    vl_logic;
        ts_st_ch2_d     : out    vl_logic
    );
end ts_channel_arbiter_fsm;
