library verilog;
use verilog.vl_types.all;
entity clt_cmp_bit is
    port(
        agtb            : out    vl_logic;
        aeqb            : out    vl_logic;
        altb            : out    vl_logic;
        ai              : in     vl_logic;
        bi              : in     vl_logic
    );
end clt_cmp_bit;
