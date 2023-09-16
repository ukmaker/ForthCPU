library verilog;
use verilog.vl_types.all;
entity fe_gen is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        \in\            : in     vl_logic;
        \out\           : out    vl_logic
    );
end fe_gen;
