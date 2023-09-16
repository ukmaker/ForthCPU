library verilog;
use verilog.vl_types.all;
entity sci_mux is
    generic(
        awidth          : integer := 11;
        dwidth          : integer := 8
    );
    port(
        rst_n           : in     vl_logic;
        scan_mode       : in     vl_logic;
        cfg_mode        : in     vl_logic;
        sciclk_tree     : out    vl_logic;
        sciclk          : out    vl_logic;
        rst_i           : out    vl_logic;
        cyc_i           : out    vl_logic;
        stb_i           : out    vl_logic;
        we_i            : out    vl_logic;
        adr_i           : out    vl_logic_vector;
        dat_i           : out    vl_logic_vector;
        dat_o           : in     vl_logic_vector;
        ack_o           : in     vl_logic;
        cfg_clk_i       : in     vl_logic;
        cfg_rst_i       : in     vl_logic;
        cfg_stb_i       : in     vl_logic;
        cfg_we_i        : in     vl_logic;
        cfg_adr_i       : in     vl_logic_vector;
        cfg_dat_i       : in     vl_logic_vector;
        cfg_dat_o       : out    vl_logic_vector;
        cfg_ack_o       : out    vl_logic;
        wb_clk_i        : in     vl_logic;
        wb_rst_i        : in     vl_logic;
        wb_cyc_i        : in     vl_logic;
        wb_stb_i        : in     vl_logic;
        wb_we_i         : in     vl_logic;
        wb_adr_i        : in     vl_logic_vector;
        wb_dat_i        : in     vl_logic_vector;
        wb_dat_o        : out    vl_logic_vector;
        wb_ack_o        : out    vl_logic
    );
end sci_mux;
