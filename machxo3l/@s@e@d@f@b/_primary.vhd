library verilog;
use verilog.vl_types.all;
entity SEDFB is
    port(
        SEDCLKOUT       : out    vl_logic;
        SEDDONE         : out    vl_logic;
        SEDINPROG       : out    vl_logic;
        SEDERR          : out    vl_logic
    );
end SEDFB;
