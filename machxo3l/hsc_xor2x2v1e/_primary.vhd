library verilog;
use verilog.vl_types.all;
entity hsc_xor2x2v1e is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        Z               : out    vl_logic
    );
end hsc_xor2x2v1e;
