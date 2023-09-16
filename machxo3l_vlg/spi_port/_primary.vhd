library verilog;
use verilog.vl_types.all;
entity spi_port is
    generic(
        SBW             : integer := 8;
        SBCW            : integer := 3;
        DVW             : integer := 6;
        mst_idle        : integer := 0;
        mst_mcsn        : integer := 1;
        mst_ldly        : integer := 3;
        mst_mrun        : integer := 2;
        mst_mhld        : integer := 6;
        mst_tdly        : integer := 7;
        mst_rcsn        : integer := 5;
        mst_idly        : integer := 4
    );
    port(
        mclk_o          : out    vl_logic;
        mclk_oe         : out    vl_logic;
        mosi_o          : out    vl_logic;
        mosi_oe         : out    vl_logic;
        miso_o          : out    vl_logic;
        miso_oe         : out    vl_logic;
        mcsn_cfg_2d     : out    vl_logic;
        mcsn_o          : out    vl_logic_vector(7 downto 0);
        mcsn_oe         : out    vl_logic_vector(7 downto 0);
        spisr           : out    vl_logic_vector;
        spirxdr         : out    vl_logic_vector;
        spi_wkup        : out    vl_logic;
        spi_port_sck_tcv_inv: out    vl_logic;
        spi_rst_async   : in     vl_logic;
        sck_tcv         : in     vl_logic;
        mosi_i          : in     vl_logic;
        miso_i          : in     vl_logic;
        scsn_usr        : in     vl_logic;
        scsn_cfg        : in     vl_logic;
        spi_clk         : in     vl_logic;
        scanen          : in     vl_logic;
        spicr0          : in     vl_logic_vector;
        spicr1          : in     vl_logic_vector;
        spicr2          : in     vl_logic_vector;
        spibr           : in     vl_logic_vector;
        spicsr          : in     vl_logic_vector;
        spitxdr         : in     vl_logic_vector;
        wb_spicr0_wt    : in     vl_logic;
        wb_spicr1_wt    : in     vl_logic;
        wb_spicr2_wt    : in     vl_logic;
        wb_spibr_wt     : in     vl_logic;
        wb_spicsr_wt    : in     vl_logic;
        wb_spitxdr_wt   : in     vl_logic;
        wb_spirxdr_rd   : in     vl_logic;
        cfg_spi_en      : in     vl_logic
    );
end spi_port;
