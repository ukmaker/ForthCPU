library verilog;
use verilog.vl_types.all;
entity ser_tilo_rvt is
    generic(
        delay           : integer := 0
    );
    port(
        tilo            : out    vl_logic;
        vccq            : inout  vl_logic;
        vssq            : inout  vl_logic;
        vssqs           : inout  vl_logic
    );
end ser_tilo_rvt;
