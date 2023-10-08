library verilog;
use verilog.vl_types.all;
entity e3bis_ch_timer is
    port(
        clk             : in     vl_logic;
        bist_rrst       : in     vl_logic;
        bist_mode       : in     vl_logic;
        bist_time_sel   : in     vl_logic_vector(1 downto 0);
        bist_start      : in     vl_logic;
        disable_timer   : in     vl_logic;
        bist_time_out   : out    vl_logic;
        latch_bist_err  : out    vl_logic
    );
end e3bis_ch_timer;
