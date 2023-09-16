library verilog;
use verilog.vl_types.all;
entity CKHS_AND2X2 is
    port(
        z               : out    vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic
    );
end CKHS_AND2X2;
