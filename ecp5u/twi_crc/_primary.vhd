library verilog;
use verilog.vl_types.all;
entity twi_crc is
    port(
        twi_clk         : in     vl_logic;
        twi_resetb      : in     vl_logic;
        twi_crc_clr     : in     vl_logic;
        twi_crc_enable  : in     vl_logic;
        twi_din         : in     vl_logic;
        twi_crc_out_reg : out    vl_logic_vector(7 downto 0)
    );
end twi_crc;
