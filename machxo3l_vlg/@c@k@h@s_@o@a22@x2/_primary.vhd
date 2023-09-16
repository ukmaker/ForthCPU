library verilog;
use verilog.vl_types.all;
entity CKHS_OA22X2 is
    port(
        z               : out    vl_logic;
        a2              : in     vl_logic;
        a1              : in     vl_logic;
        b2              : in     vl_logic;
        b1              : in     vl_logic
    );
end CKHS_OA22X2;
