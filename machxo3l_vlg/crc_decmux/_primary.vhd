library verilog;
use verilog.vl_types.all;
entity crc_decmux is
    port(
        s0              : out    vl_logic;
        crcimux         : out    vl_logic;
        datareg         : in     vl_logic_vector(7 downto 0);
        crcctr          : in     vl_logic_vector(2 downto 0)
    );
end crc_decmux;
