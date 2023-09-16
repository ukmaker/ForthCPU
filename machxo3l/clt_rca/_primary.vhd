library verilog;
use verilog.vl_types.all;
entity clt_rca is
    generic(
        ADD_DBW         : integer := 16
    );
    port(
        sout            : out    vl_logic_vector;
        cout            : out    vl_logic;
        ain             : in     vl_logic_vector;
        bin             : in     vl_logic_vector;
        cin             : in     vl_logic
    );
end clt_rca;
