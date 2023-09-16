library verilog;
use verilog.vl_types.all;
entity clt_fadd is
    port(
        so              : out    vl_logic;
        co              : out    vl_logic;
        ai              : in     vl_logic;
        bi              : in     vl_logic;
        ci              : in     vl_logic
    );
end clt_fadd;
