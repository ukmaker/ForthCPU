library verilog;
use verilog.vl_types.all;
entity hsc_oa22x2v1e is
    port(
        A1              : in     vl_logic;
        A2              : in     vl_logic;
        B1              : in     vl_logic;
        B2              : in     vl_logic;
        Z               : out    vl_logic
    );
end hsc_oa22x2v1e;
