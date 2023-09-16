library verilog;
use verilog.vl_types.all;
entity AO222S is
    port(
        A1              : in     vl_logic;
        A2              : in     vl_logic;
        B1              : in     vl_logic;
        B2              : in     vl_logic;
        C1              : in     vl_logic;
        C2              : in     vl_logic;
        Z               : out    vl_logic
    );
end AO222S;
