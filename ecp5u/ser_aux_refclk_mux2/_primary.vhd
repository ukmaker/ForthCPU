library verilog;
use verilog.vl_types.all;
entity ser_aux_refclk_mux2 is
    port(
        y               : out    vl_logic;
        vccq            : inout  vl_logic;
        vssq            : inout  vl_logic;
        in0             : in     vl_logic;
        in1             : in     vl_logic;
        sel             : in     vl_logic
    );
end ser_aux_refclk_mux2;
