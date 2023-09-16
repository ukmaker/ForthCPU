library verilog;
use verilog.vl_types.all;
entity sci_interrupt_neg is
    port(
        status          : out    vl_logic;
        intr            : out    vl_logic;
        rst_n           : in     vl_logic;
        forceint        : in     vl_logic;
        set             : in     vl_logic;
        clr             : in     vl_logic;
        enable          : in     vl_logic;
        scan_clk        : in     vl_logic;
        scan_mode       : in     vl_logic
    );
end sci_interrupt_neg;
