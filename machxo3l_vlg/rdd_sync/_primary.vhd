library verilog;
use verilog.vl_types.all;
entity rdd_sync is
    generic(
        init            : integer := 0;
        st1             : integer := 1;
        st2             : integer := 3;
        st3             : integer := 2
    );
    port(
        rdd_out         : out    vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        rdd_in          : in     vl_logic
    );
end rdd_sync;
