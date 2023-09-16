library verilog;
use verilog.vl_types.all;
entity clt_cmp is
    generic(
        CMP_DBW         : integer := 16
    );
    port(
        agtb            : out    vl_logic;
        aeqb            : out    vl_logic;
        altb            : out    vl_logic;
        ain             : in     vl_logic_vector;
        bin             : in     vl_logic_vector
    );
end clt_cmp;
