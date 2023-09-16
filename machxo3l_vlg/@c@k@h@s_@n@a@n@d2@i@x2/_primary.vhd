library verilog;
use verilog.vl_types.all;
entity CKHS_NAND2IX2 is
    port(
        z               : out    vl_logic;
        an              : in     vl_logic;
        b               : in     vl_logic
    );
end CKHS_NAND2IX2;
