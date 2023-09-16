library verilog;
use verilog.vl_types.all;
entity hsc_dlatnsrqnx2v1e is
    port(
        CDN             : in     vl_logic;
        CK              : in     vl_logic;
        D               : in     vl_logic;
        PD              : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic
    );
end hsc_dlatnsrqnx2v1e;
