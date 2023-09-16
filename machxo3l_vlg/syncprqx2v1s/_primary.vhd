library verilog;
use verilog.vl_types.all;
entity syncprqx2v1s is
    port(
        CDN             : in     vl_logic;
        CK              : in     vl_logic;
        D               : in     vl_logic;
        Q               : out    vl_logic
    );
end syncprqx2v1s;
