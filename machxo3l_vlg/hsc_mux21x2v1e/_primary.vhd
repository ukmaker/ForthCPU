library verilog;
use verilog.vl_types.all;
entity hsc_mux21x2v1e is
    port(
        D0              : in     vl_logic;
        D1              : in     vl_logic;
        SD              : in     vl_logic;
        Z               : out    vl_logic
    );
end hsc_mux21x2v1e;
