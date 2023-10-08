library verilog;
use verilog.vl_types.all;
entity ser_rx_cdr_dyffqn is
    port(
        q               : out    vl_logic;
        qn              : out    vl_logic;
        vccrx           : inout  vl_logic;
        vssrx           : inout  vl_logic;
        vssrxs          : inout  vl_logic;
        clk_n           : in     vl_logic;
        clk_p           : in     vl_logic;
        d               : in     vl_logic
    );
end ser_rx_cdr_dyffqn;
