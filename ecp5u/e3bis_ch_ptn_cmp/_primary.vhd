library verilog;
use verilog.vl_types.all;
entity e3bis_ch_ptn_cmp is
    generic(
        \K28_5_\        : integer := 380;
        K28_5           : integer := 643
    );
    port(
        clk             : in     vl_logic;
        bus8bit_sel     : in     vl_logic;
        bist_rrst       : in     vl_logic;
        bist_mode       : in     vl_logic;
        bist_ptn_sel    : in     vl_logic_vector(2 downto 0);
        bist_head_sel   : in     vl_logic_vector(1 downto 0);
        bist_res_sel    : in     vl_logic_vector(1 downto 0);
        bist_time_out   : in     vl_logic;
        latch_bist_err  : in     vl_logic;
        rx_data         : in     vl_logic_vector(9 downto 0);
        sync_head_req   : in     vl_logic_vector(1 downto 0);
        udbc1_low       : in     vl_logic_vector(7 downto 0);
        udbc2_low       : in     vl_logic_vector(7 downto 0);
        udbc1_hi        : in     vl_logic_vector(1 downto 0);
        udbc2_hi        : in     vl_logic_vector(1 downto 0);
        disable_timer   : out    vl_logic;
        bist_head_found : out    vl_logic;
        bist_start      : out    vl_logic;
        bist_ok         : out    vl_logic;
        bist_done       : out    vl_logic;
        bist_err_rpt    : out    vl_logic_vector(12 downto 0)
    );
end e3bis_ch_ptn_cmp;
