library verilog;
use verilog.vl_types.all;
entity MUX2X2 is
    port(
        z               : out    vl_logic;
        d               : in     vl_logic_vector(1 downto 0);
        s               : in     vl_logic
    );
end MUX2X2;
