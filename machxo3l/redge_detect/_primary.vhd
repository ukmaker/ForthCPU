library verilog;
use verilog.vl_types.all;
entity redge_detect is
    port(
        A               : in     vl_logic;
        Z               : out    vl_logic
    );
end redge_detect;
