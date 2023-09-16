library verilog;
use verilog.vl_types.all;
entity ANDabNX2 is
    port(
        z               : out    vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic
    );
end ANDabNX2;
