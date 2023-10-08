library verilog;
use verilog.vl_types.all;
entity i2c_ip is
    port(
        sda_out         : out    vl_logic;
        sda_oe          : out    vl_logic;
        scl_out         : out    vl_logic;
        scl_oe          : out    vl_logic;
        sb_dat_o        : out    vl_logic_vector(7 downto 0);
        sb_ack_o        : out    vl_logic;
        i2c_irq         : out    vl_logic;
        i2c_wkup        : out    vl_logic;
        SB_ID           : in     vl_logic_vector(3 downto 0);
        ADDR_LSB_USR    : in     vl_logic_vector(1 downto 0);
        i2c_rst_async   : in     vl_logic;
        sda_in          : in     vl_logic;
        scl_in          : in     vl_logic;
        del_clk         : in     vl_logic;
        sb_clk_i        : in     vl_logic;
        sb_we_i         : in     vl_logic;
        sb_stb_i        : in     vl_logic;
        sb_adr_i        : in     vl_logic_vector(7 downto 0);
        sb_dat_i        : in     vl_logic_vector(7 downto 0);
        scan_test_mode  : in     vl_logic
    );
end i2c_ip;
