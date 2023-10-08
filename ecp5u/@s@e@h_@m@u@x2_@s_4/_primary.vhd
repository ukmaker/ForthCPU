library verilog;
use verilog.vl_types.all;
entity SEH_MUX2_S_4 is
    port(
        X               : out    vl_logic;
        D0              : in     vl_logic;
        D1              : in     vl_logic;
        S               : in     vl_logic
    );
end SEH_MUX2_S_4;
