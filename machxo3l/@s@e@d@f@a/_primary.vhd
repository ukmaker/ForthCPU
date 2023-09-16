library verilog;
use verilog.vl_types.all;
entity SEDFA is
    generic(
        SED_CLK_FREQ    : string  := "3.5";
        CHECKALWAYS     : string  := "DISABLED";
        DEV_DENSITY     : string  := "1200"
    );
    port(
        SEDENABLE       : in     vl_logic;
        SEDSTART        : in     vl_logic;
        SEDFRCERR       : in     vl_logic;
        SEDSTDBY        : in     vl_logic;
        SEDERR          : out    vl_logic;
        SEDDONE         : out    vl_logic;
        SEDINPROG       : out    vl_logic;
        SEDCLKOUT       : out    vl_logic
    );
end SEDFA;
