library verilog;
use verilog.vl_types.all;
entity ser_ch_hsmux is
    port(
        hsclkn          : out    vl_logic;
        hsclkp          : out    vl_logic;
        synco           : out    vl_logic;
        vccq            : inout  vl_logic;
        vssq            : inout  vl_logic;
        vssqs           : inout  vl_logic;
        bit_from_nd_en  : in     vl_logic;
        ck3g4txn        : in     vl_logic;
        ck3g4txn_nd     : in     vl_logic;
        ck3g4txp        : in     vl_logic;
        ck3g4txp_nd     : in     vl_logic;
        sync            : in     vl_logic;
        sync_local_en   : in     vl_logic;
        sync_nd         : in     vl_logic;
        sync_nd_en      : in     vl_logic
    );
end ser_ch_hsmux;
