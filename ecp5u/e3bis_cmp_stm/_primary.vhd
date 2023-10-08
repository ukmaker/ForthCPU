library verilog;
use verilog.vl_types.all;
entity e3bis_cmp_stm is
    generic(
        S0              : integer := 0;
        S1              : integer := 1;
        S2              : integer := 2;
        S3              : integer := 3;
        S4              : integer := 4;
        S5              : integer := 5;
        S6              : integer := 6;
        S7              : integer := 7
    );
    port(
        clk             : in     vl_logic;
        \reset_\        : in     vl_logic;
        sync_head_req   : in     vl_logic_vector(1 downto 0);
        latch_bist_err  : in     vl_logic;
        bist_to         : in     vl_logic;
        start_match     : in     vl_logic;
        k28_5_hd_match  : in     vl_logic;
        mtch_12         : in     vl_logic;
        disable_timer   : out    vl_logic;
        en_compare      : out    vl_logic;
        latch_bist_ok   : out    vl_logic;
        re_search_head  : out    vl_logic;
        bist_head_found : out    vl_logic;
        bist_start      : out    vl_logic
    );
end e3bis_cmp_stm;
