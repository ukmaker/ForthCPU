library verilog;
use verilog.vl_types.all;
entity pinshorter is
    port(
        PLUS            : inout  vl_logic;
        MINUS           : inout  vl_logic
    );
end pinshorter;
