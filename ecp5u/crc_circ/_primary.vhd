library verilog;
use verilog.vl_types.all;
entity crc_circ is
    generic(
        seedvalue       : integer := 65535
    );
    port(
        signature       : out    vl_logic_vector(7 downto 0);
        chksumb         : out    vl_logic;
        clk             : in     vl_logic;
        clk_en          : in     vl_logic;
        mi              : in     vl_logic;
        setseed         : in     vl_logic;
        enchksumout     : in     vl_logic;
        rd_lower        : in     vl_logic
    );
end crc_circ;
