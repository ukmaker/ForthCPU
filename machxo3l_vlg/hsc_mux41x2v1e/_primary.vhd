library verilog;
use verilog.vl_types.all;
entity hsc_mux41x2v1e is
    port(
        D0              : in     vl_logic;
        D1              : in     vl_logic;
        D2              : in     vl_logic;
        D3              : in     vl_logic;
        SD1             : in     vl_logic;
        SD2             : in     vl_logic;
        Z               : out    vl_logic
    );
end hsc_mux41x2v1e;
