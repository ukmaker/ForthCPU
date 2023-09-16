library verilog;
use verilog.vl_types.all;
entity nand2x2v1s is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        Z               : out    vl_logic
    );
end nand2x2v1s;
