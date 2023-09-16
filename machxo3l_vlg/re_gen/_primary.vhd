library verilog;
use verilog.vl_types.all;
entity re_gen is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        \in\            : in     vl_logic;
        \out\           : out    vl_logic
    );
end re_gen;
