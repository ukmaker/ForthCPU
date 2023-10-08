library verilog;
use verilog.vl_types.all;
entity i2c_sci is
    port(
        i2ccr1          : out    vl_logic_vector(7 downto 0);
        i2ccmdr         : out    vl_logic_vector(7 downto 0);
        i2ctxdr         : out    vl_logic_vector(7 downto 0);
        i2cbr           : out    vl_logic_vector(9 downto 0);
        i2csaddr        : out    vl_logic_vector(7 downto 0);
        i2ccr1_wt       : out    vl_logic;
        i2ccmdr_wt      : out    vl_logic;
        i2cbr_wt        : out    vl_logic;
        i2ctxdr_wt      : out    vl_logic;
        i2csaddr_wt     : out    vl_logic;
        i2crxdr_rd      : out    vl_logic;
        i2cgcdr_rd      : out    vl_logic;
        trim_sda_del    : out    vl_logic_vector(3 downto 0);
        sb_dat_o        : out    vl_logic_vector(7 downto 0);
        sb_ack_o        : out    vl_logic;
        i2c_irq         : out    vl_logic;
        SB_ID           : in     vl_logic_vector(3 downto 0);
        i2c_rst_async   : in     vl_logic;
        sb_clk_i        : in     vl_logic;
        sb_we_i         : in     vl_logic;
        sb_stb_i        : in     vl_logic;
        sb_adr_i        : in     vl_logic_vector(7 downto 0);
        sb_dat_i        : in     vl_logic_vector(7 downto 0);
        i2csr           : in     vl_logic_vector(7 downto 0);
        i2crxdr         : in     vl_logic_vector(7 downto 0);
        i2cgcdr         : in     vl_logic_vector(7 downto 0);
        scan_test_mode  : in     vl_logic
    );
end i2c_sci;
