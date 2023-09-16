library verilog;
use verilog.vl_types.all;
entity PCNTR is
    generic(
        STDBYOPT        : string  := "USER_CFG";
        TIMEOUT         : string  := "BYPASS";
        WAKEUP          : string  := "USER_CFG";
        POROFF          : string  := "FALSE";
        BGOFF           : string  := "FALSE"
    );
    port(
        CLK             : in     vl_logic;
        USERTIMEOUT     : in     vl_logic;
        USERSTDBY       : in     vl_logic;
        CLRFLAG         : in     vl_logic;
        CFGWAKE         : in     vl_logic;
        CFGSTDBY        : in     vl_logic;
        STDBY           : out    vl_logic;
        STOP            : out    vl_logic;
        SFLAG           : out    vl_logic
    );
end PCNTR;
