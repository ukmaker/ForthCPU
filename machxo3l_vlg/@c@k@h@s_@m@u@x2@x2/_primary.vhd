library verilog;
use verilog.vl_types.all;
entity CKHS_MUX2X2 is
    port(
        z               : out    vl_logic;
        d1              : in     vl_logic;
        d0              : in     vl_logic;
        sd              : in     vl_logic
    );
end CKHS_MUX2X2;
