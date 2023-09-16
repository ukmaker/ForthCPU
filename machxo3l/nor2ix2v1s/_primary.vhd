library verilog;
use verilog.vl_types.all;
entity nor2ix2v1s is
    port(
        AN              : in     vl_logic;
        B               : in     vl_logic;
        Z               : out    vl_logic
    );
end nor2ix2v1s;
