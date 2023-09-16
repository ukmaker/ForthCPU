library verilog;
use verilog.vl_types.all;
entity CKHS_MUX4X2 is
    port(
        z               : out    vl_logic;
        d3              : in     vl_logic;
        d2              : in     vl_logic;
        d1              : in     vl_logic;
        d0              : in     vl_logic;
        sd2             : in     vl_logic;
        sd1             : in     vl_logic
    );
end CKHS_MUX4X2;
