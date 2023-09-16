library verilog;
use verilog.vl_types.all;
entity decompress_unit is
    port(
        decompress_rcv_full: out    vl_logic;
        decompress_busy : out    vl_logic;
        decompress_1byte: out    vl_logic;
        decompress_8byte: out    vl_logic;
        decompress_out  : out    vl_logic_vector(63 downto 0);
        dec_load        : out    vl_logic;
        por             : in     vl_logic;
        smclk           : in     vl_logic;
        isc_rst_sync    : in     vl_logic;
        decom_mode1     : in     vl_logic;
        decompress_en   : in     vl_logic;
        decompress_rcv_en: in     vl_logic;
        decompress_din  : in     vl_logic_vector(7 downto 0);
        comp_dic        : in     vl_logic_vector(63 downto 0)
    );
end decompress_unit;
