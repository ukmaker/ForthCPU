library verilog;
use verilog.vl_types.all;
entity pcs_mux2_4 is
    port(
        D0              : in     vl_logic;
        D1              : in     vl_logic;
        S               : in     vl_logic;
        X               : out    vl_logic
    );
end pcs_mux2_4;
