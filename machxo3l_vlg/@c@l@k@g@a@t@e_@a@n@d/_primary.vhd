library verilog;
use verilog.vl_types.all;
entity CLKGATE_AND is
    port(
        clock_out       : out    vl_logic;
        enable          : in     vl_logic;
        clock_in        : in     vl_logic
    );
end CLKGATE_AND;
