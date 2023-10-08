library verilog;
use verilog.vl_types.all;
entity spi_ip is
    port(
        mclk_o          : out    vl_logic;
        mclk_oe         : out    vl_logic;
        mosi_o          : out    vl_logic;
        mosi_oe         : out    vl_logic;
        miso_o          : out    vl_logic;
        miso_oe         : out    vl_logic;
        mcsn_o          : out    vl_logic_vector(7 downto 0);
        mcsn_oe         : out    vl_logic_vector(7 downto 0);
        sb_dat_o        : out    vl_logic_vector(7 downto 0);
        sb_ack_o        : out    vl_logic;
        spi_irq         : out    vl_logic;
        spi_wkup        : out    vl_logic;
        SB_ID           : in     vl_logic_vector(3 downto 0);
        spi_rst_async   : in     vl_logic;
        sck_tcv         : in     vl_logic;
        mosi_i          : in     vl_logic;
        miso_i          : in     vl_logic;
        scsn_usr        : in     vl_logic;
        sb_clk_i        : in     vl_logic;
        sb_we_i         : in     vl_logic;
        sb_stb_i        : in     vl_logic;
        sb_adr_i        : in     vl_logic_vector(7 downto 0);
        sb_dat_i        : in     vl_logic_vector(7 downto 0);
        scan_test_mode  : in     vl_logic
    );
end spi_ip;
