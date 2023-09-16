library verilog;
use verilog.vl_types.all;
entity cfg_crc16 is
    port(
        cfg_crc         : out    vl_logic_vector(15 downto 0);
        njm_crc_err     : out    vl_logic;
        por             : in     vl_logic;
        smclk           : in     vl_logic;
        cfg_crc_en      : in     vl_logic;
        crc_din         : in     vl_logic_vector(7 downto 0);
        cfg_reset_crc16 : in     vl_logic;
        nj_check_crc    : in     vl_logic
    );
end cfg_crc16;
