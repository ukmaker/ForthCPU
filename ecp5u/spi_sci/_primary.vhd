library verilog;
use verilog.vl_types.all;
entity spi_sci is
    port(
        spicr0          : out    vl_logic_vector(7 downto 0);
        spicr1          : out    vl_logic_vector(7 downto 0);
        spicr2          : out    vl_logic_vector(7 downto 0);
        spibr           : out    vl_logic_vector(7 downto 0);
        spicsr          : out    vl_logic_vector(7 downto 0);
        spitxdr         : out    vl_logic_vector(7 downto 0);
        spicr0_wt       : out    vl_logic;
        spicr1_wt       : out    vl_logic;
        spicr2_wt       : out    vl_logic;
        spibr_wt        : out    vl_logic;
        spicsr_wt       : out    vl_logic;
        spitxdr_wt      : out    vl_logic;
        spirxdr_rd      : out    vl_logic;
        sb_dat_o        : out    vl_logic_vector(7 downto 0);
        sb_ack_o        : out    vl_logic;
        spi_irq         : out    vl_logic;
        SB_ID           : in     vl_logic_vector(3 downto 0);
        spi_rst_async   : in     vl_logic;
        sb_clk_i        : in     vl_logic;
        sb_we_i         : in     vl_logic;
        sb_stb_i        : in     vl_logic;
        sb_adr_i        : in     vl_logic_vector(7 downto 0);
        sb_dat_i        : in     vl_logic_vector(7 downto 0);
        spisr           : in     vl_logic_vector(7 downto 0);
        spirxdr         : in     vl_logic_vector(7 downto 0);
        scan_test_mode  : in     vl_logic
    );
end spi_sci;
