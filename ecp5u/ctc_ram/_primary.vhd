library verilog;
use verilog.vl_types.all;
entity ctc_ram is
    port(
        RESETR          : in     vl_logic;
        RESETW          : in     vl_logic;
        WCLK            : in     vl_logic;
        WA              : in     vl_logic_vector(3 downto 0);
        WE              : in     vl_logic;
        DI              : in     vl_logic_vector(11 downto 0);
        RCLK            : in     vl_logic;
        RA              : in     vl_logic_vector(3 downto 0);
        RE              : in     vl_logic;
        DO              : out    vl_logic_vector(11 downto 0)
    );
end ctc_ram;
