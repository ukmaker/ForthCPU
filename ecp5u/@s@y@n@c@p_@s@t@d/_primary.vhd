library verilog;
use verilog.vl_types.all;
entity SYNCP_STD is
    port(
        q               : out    vl_logic;
        d               : in     vl_logic;
        ck              : in     vl_logic;
        cdn             : in     vl_logic
    );
end SYNCP_STD;
