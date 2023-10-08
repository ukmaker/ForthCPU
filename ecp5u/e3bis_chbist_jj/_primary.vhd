library verilog;
use verilog.vl_types.all;
entity e3bis_chbist_jj is
    port(
        txclk           : in     vl_logic;
        rxclk           : in     vl_logic;
        bist_wrst       : in     vl_logic;
        bist_rrst       : in     vl_logic;
        bist_mode       : in     vl_logic;
        bist_ptn_sel    : in     vl_logic_vector(2 downto 0);
        bist_head_sel   : in     vl_logic_vector(1 downto 0);
        bist_time_sel   : in     vl_logic_vector(1 downto 0);
        bist_res_sel    : in     vl_logic_vector(1 downto 0);
        bus8bit_sel     : in     vl_logic;
        bypass_tx_gate  : in     vl_logic;
        sync_head_req   : in     vl_logic_vector(1 downto 0);
        udbc1_low       : in     vl_logic_vector(7 downto 0);
        udbc2_low       : in     vl_logic_vector(7 downto 0);
        udbc1_hi        : in     vl_logic_vector(1 downto 0);
        udbc2_hi        : in     vl_logic_vector(1 downto 0);
        rx_data         : in     vl_logic_vector(9 downto 0);
        bist_tx_data    : out    vl_logic_vector(9 downto 0);
        bist_report     : out    vl_logic_vector(15 downto 0)
    );
end e3bis_chbist_jj;
