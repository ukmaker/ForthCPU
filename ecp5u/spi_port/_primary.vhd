library verilog;
use verilog.vl_types.all;
entity spi_port is
    generic(
        mst_idle        : integer := 0;
        mst_cken        : integer := 1;
        mst_ckmo        : integer := 3;
        mst_mcsn        : integer := 2;
        mst_ldly        : integer := 6;
        mst_mrun        : integer := 7;
        mst_mhld        : integer := 5;
        mst_tdly        : integer := 4;
        mst_rcsn        : integer := 12;
        mst_csmo        : integer := 13;
        mst_ckds        : integer := 9;
        mst_idly        : integer := 8
    );
    port(
        mclk_o          : out    vl_logic;
        mclk_oe         : out    vl_logic;
        mosi_o          : out    vl_logic;
        mosi_oe         : out    vl_logic;
        miso_o          : out    vl_logic;
        miso_oe         : out    vl_logic;
        mcsn_o          : out    vl_logic_vector(7 downto 0);
        mcsn_oe         : out    vl_logic_vector(7 downto 0);
        spisr           : out    vl_logic_vector(7 downto 0);
        spirxdr         : out    vl_logic_vector(7 downto 0);
        spi_wkup        : out    vl_logic;
        spi_rst_async   : in     vl_logic;
        sck_tcv         : in     vl_logic;
        mosi_i          : in     vl_logic;
        miso_i          : in     vl_logic;
        scsn_usr        : in     vl_logic;
        sb_clk_i        : in     vl_logic;
        spicr0          : in     vl_logic_vector(7 downto 0);
        spicr1          : in     vl_logic_vector(7 downto 0);
        spicr2          : in     vl_logic_vector(7 downto 0);
        spibr           : in     vl_logic_vector(7 downto 0);
        spicsr          : in     vl_logic_vector(7 downto 0);
        spitxdr         : in     vl_logic_vector(7 downto 0);
        spicr0_wt       : in     vl_logic;
        spicr1_wt       : in     vl_logic;
        spicr2_wt       : in     vl_logic;
        spibr_wt        : in     vl_logic;
        spicsr_wt       : in     vl_logic;
        spitxdr_wt      : in     vl_logic;
        spirxdr_rd      : in     vl_logic
    );
end spi_port;
