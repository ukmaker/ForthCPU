library verilog;
use verilog.vl_types.all;
entity hsc_nand2ix2v1e is
    port(
        AN              : in     vl_logic;
        B               : in     vl_logic;
        Z               : out    vl_logic
    );
end hsc_nand2ix2v1e;
