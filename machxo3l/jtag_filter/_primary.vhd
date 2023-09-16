library verilog;
use verilog.vl_types.all;
entity jtag_filter is
    port(
        A               : in     vl_logic;
        Z               : out    vl_logic
    );
end jtag_filter;
