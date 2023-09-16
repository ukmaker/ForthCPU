library verilog;
use verilog.vl_types.all;
entity noglitch_clkmux is
    port(
        scan_mode       : in     vl_logic;
        rst_n           : in     vl_logic;
        aclkin          : in     vl_logic;
        bclkin          : in     vl_logic;
        aclksel         : in     vl_logic;
        anoswitch       : in     vl_logic;
        bnoswitch       : in     vl_logic;
        noclock         : out    vl_logic;
        outclk          : out    vl_logic
    );
end noglitch_clkmux;
